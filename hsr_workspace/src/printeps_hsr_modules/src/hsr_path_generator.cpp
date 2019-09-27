#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/core/core.hpp>
#include <pcl_ros/io/pcd_io.h>

#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/WrenchStamped.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/PoseArray.h>

#include <visualization_msgs/MarkerArray.h>

#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/point_cloud2_iterator.h>
#include <sensor_msgs/JointState.h>

#include <nav_msgs/OccupancyGrid.h>

#include <geometry_msgs/TransformStamped.h>
#include <pcl_ros/transforms.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
#include <pcl/visualization/cloud_viewer.h>
#include <iostream>
#include <geometry_msgs/Pose2D.h>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <algorithm>
#include <limits>
#include <Eigen/Dense>

#include <boost/thread/thread.hpp>
#include <pcl/common/common_headers.h>
#include <pcl/features/normal_3d.h>
#include <pcl/point_types.h>


#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_broadcaster.h>

#include "printeps_hsr_modules/PathGenerator.h"

#include "printeps_hsr_modules/HsrObstacle.h"
#include "printeps_hsr_modules/HsrObstacleArray.h"
#include "printeps_hsr_modules/HsrTableset.h"

#include "printeps_hsr_modules/HsrPerson.h"
#include "printeps_hsr_modules/HsrOpenpose.h"

using namespace std;

class pathlist
{
private:
public:
    double resolution;
    int origin[2];//座標
    vector< vector <double> > path;//x,y
};

class potential
{
private:
public:
    double resolution;//m
    int width;//m
    int height;//m
    int origin[2];//座標
    vector< vector <double> > data;//x,y
    void setup(double Resolution, int Width,int Height ,int originX,int originY)
    {
        resolution=Resolution;
        width=Width;
        height=Height;
        origin[0]=originX;
        origin[1]=originY;
        data.clear();
        for(int i=0;i<(int)(width/resolution);i++)
        {
            vector<double>d;
            for(int j=0;j<(int)(height/resolution);j++)
            {
                d.push_back(0);
            }
            data.push_back(d);
        }
    }
};

class astar
{
private:
    double start[2],goal[2];
    potential Potential;
public:
    void setup(double startX,double startY,double goalX,double goalY,potential Potentialfield)
    {
        start[0]=startX;
        start[1]=startY;
        goal[0]=goalX;
        goal[1]=goalY;
        Potential=Potentialfield;
    }
    pathlist solve()
    {
        //パスを計算
        int Start[3],Goal[3];
        for(int i=0;i<2;i++)
        {
            Start[i]=(int)(start[i]/Potential.resolution)+Potential.origin[i];
            Goal[i]=(int)(goal[i]/Potential.resolution)+Potential.origin[i];
        }
        Start[2]=0;
        Goal[2]=0;
        //cout<<"start   "<<Start[0]<<"  "<<Start[1]<<endl;
        //cout<<"goal   "<<Goal[0]<<"  "<<Goal[1]<<endl;
        //cout<<"AstarFunc"<<endl;
        int gridnum[2]={Potential.data.size(),Potential.data[0].size()};


        // A*
        //cout<<" start A*"<<endl;
        //コストの定義
        //cout<<" set cost"<<endl;
        vector < vector<double> >TotalCost;
        for (int i=0;i<Potential.data.size();i++)
        {
            vector<double>totalcost;
            for (int j=0;j<Potential.data[0].size();j++)
            {
                totalcost.push_back(0);
            }
            TotalCost.push_back(totalcost);
        }
    
        vector < vector<double> >HCost;
        for (int i=0;i<Potential.data.size();i++)
        {
            vector<double>hcost;
            for (int j=0;j<Potential.data[0].size();j++)
            {
                hcost.push_back(0);
            }
            HCost.push_back(hcost);
        }
        //cout<<" set open close"<<endl;
        //Open,Closeを用意
        vector < vector<double> >Open;
        vector<double> open;
        vector < vector<double> >Close;
        vector<double> close;
    
        //StartをOpenに入れる
        open.push_back(Start[0]);
        open.push_back(Start[1]);
        open.push_back(Start[2]);
        Open.push_back(open);
        open.clear();
    
        HCost[Start[0]][Start[1]]=sqrt(pow((Open[0][0]-Goal[0]),2)+pow((Open[0][1]-Goal[1]),2));
        TotalCost[Open[0][0]][Open[0][1]]=HCost[Open[0][0]][Open[0][1]];
        //cout<<" set oparent"<<endl;
        //親のメモリ確保
        vector < vector<double> >Parent;
        vector<double> parent;
        parent.push_back(Open[0][0]);
        parent.push_back(Open[0][1]);
        parent.push_back(Open[0][2]);
        parent.push_back(Open[0][0]);
        parent.push_back(Open[0][1]);
        parent.push_back(Open[0][2]);
        Parent.push_back(parent);
        parent.clear();
    
        //path探索が終わったかどうか
        bool Searching=false;
    
        //n,mの確保
        vector<double>n;
        vector<double>m;
        for(int i=0;i<3;i++)
        {
            n.push_back(0);
            m.push_back(0);
        }
        //cout<<" start Loop"<<endl;
        while(1)
        {
            //cout<<"  1"<<endl;
            //①OPENリストの中身がなくなったら終了(失敗)
            if (Open.size()==0)
            {
                Searching=false;
                //cout<<"  fnish1"<<endl;
                break;
            }
         
            if (Parent.size()>3000)
            {
                Searching=false;
                //cout<<"  fnish2"<<endl;
                break;
            }
         
            //cout<<"  2"<<endl;
            //②OPENリストの中でTotalCostが最小のノードを探す
            double minimumCost=TotalCost[Open[0][0]][Open[0][1]];
            for(int i=0;i<Open.size();i++)
            {
                //cout<<"  "<<Open[i][0]<<" "<<Open[i][1]<<endl;
                if(minimumCost>=TotalCost[Open[i][0]][Open[i][1]])
                {
                    minimumCost=TotalCost[Open[i][0]][Open[i][1]];
                    n[0]=Open[i][0];
                    n[1]=Open[i][1];
                    n[2]=Open[i][2];
                }
            }
            //cout<<"    n"<<n[0]<<" "<<n[1]<<endl;
            //cout<<"  3"<<endl;
            //③nがGの時終了，それ以外の時はnをCloseへ
            //cout<<"    open"<<Open.size()<<endl;
            //cout<<"    close"<<Close.size()<<endl;
            if(n[0]==Goal[0] && n[1]==Goal[1])
            {
                //cout<<"  finish!!!!!"<<endl;
                break;
            }
            else
            {
                Close.push_back(n);
                for(int i=0;i<Open.size();i++)
                {
                    if(Open[i][0]==n[0] && Open[i][1]==n[1])
                    {
                        Open.erase(Open.begin()+i);
                        Searching=true;
                        break;
                    }
                }
            }
            //cout<<"    open"<<Open.size()<<endl;
            //cout<<"    close"<<Close.size()<<endl;
            //cout<<"  4"<<endl;
            //④nに隣接するノードに対してアクセス
            for(int i=-1;i<2;i++)
            {
                for(int j=-1;j<2;j++)
                {
                    if(i==0 && j==0)
                    {
    
                    }
                    else
                    {
                        
                        m[0]=n[0]+i;
                        m[1]=n[1]+j;
                        //cout<<"    a"<<m[0]<<" "<<m[1]<<endl;
                        if(m[0]>0 && m[0]<=Potential.data.size() && m[1]>0 && m[1]<=Potential.data[0].size())
                        {
                            //cout<<"    b"<<endl;
                            //仮のコストtotalcostの計算
                            HCost[m[0]][m[1]]=sqrt(pow((m[0]-Goal[0]),2)+pow((m[1]-Goal[1]),2));
                            //HCost[m[0]][m[1]]=pow((m[0]-Goal[0]),2)+pow((m[1]-Goal[1]),2);
                            double Cost=(Potential.data[m[0]][m[1]]-Potential.data[n[0]][n[1]]);
                            double movementCost=sqrt(pow(i,2)+pow(j,2));
                            double totalcost=TotalCost[n[0]][n[1]]-HCost[n[0]][n[1]]+HCost[m[0]][m[1]]+25*Cost+movementCost;
                            m[2]=0;
    
                            //cout<<"    c"<<endl;
                            //ステータスの判定
                            int status=0; //open:1,close:2,それ以外:0
                            //cout<<"    opensize"<<Open.size()<<endl;
                            for(int k=0;k<Open.size();k++)
                            {
                                //cout<<"    open"<<Open[0][0]<<" "<<Open[0][1]<<endl;
                                if(Open[k][0]==m[0] && Open[k][1]==m[1])
                                {
                                    status=1;
                                }
                            }
                            if(status==0)
                            {
                                //cout<<"    c0"<<endl;
                                for(int k=0;k<Close.size();k++)
                                {
                                    if(Close[k][0]==m[0] && Close[k][1]==m[1])
                                    {
                                        status=2;
                                    }
                                }
                            }
                            //cout<<"    d"<<endl;
                            //ステータスに応じて操作
                            if(status==0)
                            {
                                //cout<<"    0"<<endl;
                                //cout<<"       1"<<endl;
                                TotalCost[m[0]][m[1]]=totalcost;
                                Open.push_back(m);
                                //cout<<"       2"<<endl;
                               

                                parent.push_back(m[0]);
                                parent.push_back(m[1]);
                                parent.push_back(m[2]);
                                parent.push_back(n[0]);
                                parent.push_back(n[1]);
                                parent.push_back(n[2]);
                                Parent.push_back(parent);
                                parent.clear();
                                //cout<<"       4"<<endl;
                                //cout<<"    m"<<m.size()<<"  "<<m[0]<<" "<<m[1]<<" "<<m[2]<<endl;
                                //cout<<"    open"<<Open.size()<<endl;
                                //cout<<"    open"<<Open[0].size()<<endl;
                                //cout<<"    open"<<Open.size()<<"  "<<Open[0][0]<<" "<<Open[0][1]<<endl;
                            }
                            else if(status==1)
                            {
                                //cout<<"    1"<<endl;
                                if(TotalCost[m[0]][m[1]]>totalcost)
                                {
                                    TotalCost[m[0]][m[1]]=totalcost;
                                    parent.push_back(m[0]);
                                    parent.push_back(m[1]);
                                    parent.push_back(m[2]);
                                    parent.push_back(n[0]);
                                    parent.push_back(n[1]);
                                    parent.push_back(n[2]);
                                    Parent.push_back(parent);
                                    parent.clear();
                                }
                            }
                            else
                            {
                                //cout<<"    2"<<endl;
                                if(TotalCost[m[0]][m[1]]>totalcost)
                                {
                                    TotalCost[m[0]][m[1]]=totalcost;
                                    parent.push_back(m[0]);
                                    parent.push_back(m[1]);
                                    parent.push_back(m[2]);
                                    parent.push_back(n[0]);
                                    parent.push_back(n[1]);
                                    parent.push_back(n[2]);
                                    Parent.push_back(parent);
                                    parent.clear();
                                }
                            }
                        }
                    }
                }
            }
        }
        //cout<<"finish"<<endl;
     
        //Parentをたどっていく
        //pathlistの確保
        vector < vector<double> >Pathlist;
        vector<double> parent2;
        parent2.push_back(Goal[0]);
        parent2.push_back(Goal[1]);
        parent2.push_back(4);
        
        double Child[3];
        //cout<<Searching<<endl;;
        if (Searching)
        {
            Child[0]=Goal[0];
            Child[1]=Goal[1];
            Child[2]=4;
        }
        else
        {
            double minimumCost=Potential.data[Parent[0][0]][Parent[0][1]];
            for(int i=0;i<Parent.size();i++)
            {
                //cout<<"  "<<Open[i][0]<<" "<<Open[i][1]<<endl;
                if(minimumCost>=Potential.data[Parent[i][0]][Parent[i][1]])
                {
                    minimumCost=Potential.data[Parent[i][0]][Parent[i][1]];
                    Child[0]=Parent[i][0];
                    Child[1]=Parent[i][1];
                    Child[2]=4;
                    parent2[0]=Parent[i][0];
                    parent2[1]=Parent[i][1];
                    parent2[2]=4;
                }
            }
        }
        Pathlist.push_back(parent2);
        //cout<<"loop start:"<<Parent.size()<<endl;
        while(1)
        {
            //cout<<"1   "<<Parent.size()<<endl;
        
            for(int i=0;i<Parent.size();i++)
            {
                int p=Parent.size()-i-1;
                //cout<<"11  "<<Parent[i][0]<<" "<<Parent[i][1]<<endl;
                if(Parent[i][0]==Child[0] && Parent[i][1]==Child[1])
                {
                    //cout<<"111"<<endl;
                    parent2[0]=Parent[i][0];
                    parent2[1]=Parent[i][1];
                    parent2[2]=Parent[i][2];
                    Pathlist.push_back(parent2);
                    Child[0]=Parent[i][3];
                    Child[1]=Parent[i][4];
                    Child[2]=Parent[i][5];
                    //cout<<"112"<<endl;
                    break;
                }
            }
            //cout<<"2"<<endl;
            if(Start[0]==Child[0] && Start[1]==Child[1])
            {
                //cout<<"21"<<endl;
                parent2[0]=Start[0];
                parent2[1]=Start[1];
                parent2[2]=Start[2];
                //cout<<"22"<<endl;
                Pathlist.push_back(parent2);
                break;
            }
            //cout<<"3"<<endl;
        }
        //cout<<"4"<<endl;
        reverse(Pathlist.begin(), Pathlist.end());  
        //cout<<"5"<<endl;
        //cout<<"generated Path"<<endl;
        //ROS_INFO("setPotential----Generated Path");
        
        pathlist Path;
        Path.resolution=Potential.resolution;
        Path.origin[0]=Potential.origin[0];
        Path.origin[1]=Potential.origin[1];
        Path.path=Pathlist;

        return Path;
    }
};

class setPotential
{
private:
    ros::NodeHandle                                       _nh;
    ros::ServiceServer pathGeneratorService             = _nh.advertiseService("hsr_path_generator",&setPotential::generatePath,this);
    ros::Publisher pubPotential                         = _nh.advertise<sensor_msgs::PointCloud2> ("hsr_potential", 1);
    ros::Publisher pubCOG                               = _nh.advertise<geometry_msgs::Pose2D> ("/hsr_cog", 5);

    ros::Subscriber sub_map                             = _nh.subscribe("map",1,&setPotential::getMap,this);
    ros::Subscriber sub_static_obstacle                 = _nh.subscribe("/hsr_obstacles",1,&setPotential::getStaticObstacle,this);
    ros::Subscriber sub_openpose                        = _nh.subscribe("hsr_filtered_people",5,&setPotential::getOpenpose,this);
        
    tf::TransformListener tfListener;

    potential map;//元のmapを格納用
    potential mapPotential;//mapの解像度をpotentialに合わせたmapPotential
    potential Potential;//統合されたポテンシャル          cout<<"length:"<<pathLength<<endl;

    pathlist path;
    sensor_msgs::PointCloud2 output1;
    geometry_msgs::PoseArray pathout;

    printeps_hsr_modules::HsrObstacleArray staticObstacles;
    vector <printeps_hsr_modules::HsrObstacle> tables;
    vector <printeps_hsr_modules::HsrObstacle> chairs; 

    printeps_hsr_modules::HsrOpenpose observedPeople; 
    printeps_hsr_modules::HsrOpenpose targetPeople; 

    geometry_msgs::Pose2D getCOG(geometry_msgs::Pose2D goal)
    {
        //認識信頼度が０ではない人の中で、認識信頼度が低い人のほうを向くようにしたい
        //認識信頼度が０でない人の中で、（1-認識信頼度）を重みとした、人の位置の重み付け重心をロボットの注視点とする
        //ただ、全員の信頼度が0の場合は机、普通の重心を注視する
        geometry_msgs::Pose2D COG;
        COG.x       =0;
        COG.y       =0;
        COG.theta   =0;
       
        double weights=0;
        for(int chairNum=0;chairNum<targetPeople.people.size();chairNum++)
        {
            COG.x   += targetPeople.people[chairNum].confidence*targetPeople.people[chairNum].pose.x;
            COG.y   += targetPeople.people[chairNum].confidence*targetPeople.people[chairNum].pose.y;
            weights += targetPeople.people[chairNum].confidence;
        }
        if(weights>0)
        {
            COG.x   /= weights;
            COG.y   /= weights;
        }
        else
        {
            COG=goal;
        }
        return COG;
    }

public:
    setPotential()
    {
        ROS_INFO("====================pathGenerator====================");
        ROS_INFO("Listening for incoming data on topic /map ...");
        observedPeople.people.clear();
    }
    ~setPotential(){}
    bool generatePath(printeps_hsr_modules::PathGenerator::Request  &req,
                      printeps_hsr_modules::PathGenerator::Response &res)
    {
        //ポテンシャルの初期化(解像度[m],横[m],縦[m],真ん中のグリッドx,真ん中のグリッドy)
        Potential.setup(0.15,30,30,100,100);
        //mapの考慮
        //Potential=this->map2potential(Potential,map);
        //既知障害物の考慮
        if(req.multimodalPathplanning.data)//multimodalポテンシャルを考慮する場合
        {
            Potential=this->setStaticObstacle(Potential,10);
        }
        else
        {
            Potential=this->setStaticObstacle(Potential,7.0);
        }
        //ワゴンの障害物考慮
        /*if(!this->checkGrasp())
        {
            Potential=this->setWagonObstacle(Potential,15);
        }*/
        //動的障害物の考慮
        //Potential=this->setDynamicObstacle(Potential,req.dynamicObstacle);
        //ゴール位置の考慮
        Potential=this->setGoal(Potential,req.goal.x,req.goal.y);

        //目的地から、向かう先のテーブル番号の取得
        int tableNum=this->getTableNum(req.goal.x,req.goal.y);
        if(req.multimodalPathplanning.data)//multimodalポテンシャルを考慮する場合
        {
            cout<<"tableNum:"<<tableNum<<endl;
            //テーブル番号からと観測できている人から、関与する人のピックアップ
            //椅子と人の位置の紐付け
            targetPeople = observedPeople;
            geometry_msgs::PoseArray targetPeoplePos;
            targetPeoplePos.header.frame_id="map";
            for(int peopleNum=0;peopleNum<targetPeople.people.size();peopleNum++)
            {
                geometry_msgs::Pose Pose;
                Pose.position.x=targetPeople.people[peopleNum].pose.x;
                Pose.position.y=targetPeople.people[peopleNum].pose.y;

                tf::Quaternion quaternion=tf::createQuaternionFromRPY(0,0,targetPeople.people[peopleNum].pose.theta);
                geometry_msgs::Quaternion quat_Msg;
                quaternionTFToMsg(quaternion,quat_Msg);//この関数はROSのライブラリ
                Pose.orientation=quat_Msg;

                targetPeoplePos.poses.push_back(Pose);
            }
            //pubTargetPeople.publish(targetPeoplePos);

            //観測できた人に応じてポテンシャルに反映
            Potential=this->setMultimodalPotential(Potential,targetPeople, 1);
        }
        
        //生成されたポテンシャルのpublish
        output1=this->createPcd(Potential);
        output1.header.frame_id ="map";
        pubPotential.publish(output1);
        
        //ゴールの位置計算
        cout<<"getGoal"<<endl;
        vector<double>goal;
        /*if(req.multimodalPathplanning.data)//multimodalポテンシャルを考慮する場合
        {
            //机の四隅から選択する
            vector<geometry_msgs::Pose2D> goalCandidate=this->getGoalCandidate(tableNum);
            goal=this->getGoalFromCandidate(Potential,goalCandidate);
        }
        else
        {
            goal=this->getGoal(Potential,req.start.x,req.start.y);
        }*/
        goal=this->getGoal(Potential,req.start.x,req.start.y);
        //ゴール時の姿勢計算
        double goal_theta=0;
        if(sqrt(pow(req.goal.y-goal[1],2)+pow(req.goal.x-goal[0],2))>0.4)
        {
            goal_theta=atan2(req.goal.y-goal[1],req.goal.x-goal[0]);
        }
        else
        {
            goal_theta= req.goal.theta;
        }
        
        //ポテンシャルとスタート、ゴールに基づくA*による経路計画
        cout<<"A*"<<endl;
        astar Astar;
        Astar.setup(req.start.x,req.start.y,goal[0],goal[1],Potential);
        path=Astar.solve();

        //PoseArray作成:パス生成
        pathout=this->createPathPoseArray(path,goal_theta);
        pathout.header.frame_id ="map";
        res.path=pathout;
        //path長の計算
        std_msgs::Float32 Length;
        Length.data=getPathLength(path);
        res.length=Length;


        //multimodalポテンシャルを考慮する場合
        //注視点のpublish
        if(req.multimodalPathplanning.data)
        {
            pubCOG.publish(this->getCOG(req.start));
        }
        
        return true;
    }

    void getMap(const nav_msgs::OccupancyGrid sub_map)
    {
        map.resolution=sub_map.info.resolution;
        map.width=sub_map.info.width;
        map.height=sub_map.info.height;
        map.origin[0]=sub_map.info.origin.position.x;
        map.origin[1]=sub_map.info.origin.position.y;

        map.data.clear();
        int iLim=(int)(map.width);
        int jLim=(int)(map.height);
        
        for(int i=0;i<iLim;i++)
        {
            vector<double> map_w;
            for(int j=0;j<jLim;j++)
            {
                map_w.push_back(sub_map.data[i+j*iLim]);
            }
            map.data.push_back(map_w);
        }
        //cout<<"getmap"<<endl;
    }

    void getStaticObstacle(const printeps_hsr_modules::HsrObstacleArray  StaticObstacles)
    {
        staticObstacles=StaticObstacles;
        
        tables.clear();
        chairs.clear();
        for(int tableSetNum=0; tableSetNum<staticObstacles.obstacles.size(); tableSetNum++)
        {
            tables.push_back(staticObstacles.obstacles[tableSetNum].table);
            for(int chairNum=0; chairNum<staticObstacles.obstacles[tableSetNum].chairs.size(); chairNum++)
            {
                chairs.push_back(staticObstacles.obstacles[tableSetNum].chairs[chairNum]);
            }
        }
    }

    void getOpenpose(const printeps_hsr_modules::HsrOpenpose getOpenpose)
    {
        cout<<"path_generator_getPeople"<<endl;
        observedPeople = getOpenpose;
    }

    int getTableNum(double x,double y)
    {
        //最も近いテーブル番号を返す
        double distance=100000;
        int tableNum;
        for(int tablesetNum=0;tablesetNum<staticObstacles.obstacles.size();tablesetNum++)
        {
            double tempDistance  = sqrt(pow(x-staticObstacles.obstacles[tablesetNum].table.pose.x,2)+pow(y-staticObstacles.obstacles[tablesetNum].table.pose.y,2));
            if(distance > tempDistance)
            {
                distance = tempDistance;
                tableNum=tablesetNum;
            }
        }
        return tableNum;
    }

    vector<geometry_msgs::Pose2D> getGoalCandidate(int tableNum)
    {
        //最も近いテーブル番号を返す
        double distance=1.3;
        vector<geometry_msgs::Pose2D> goalCandidate;
        for(int pointNum=0;pointNum<4;pointNum++)
        {
            geometry_msgs::Pose2D point;
            point.x=staticObstacles.obstacles[tableNum].table.pose.x+distance*cos(3.14/2*pointNum+staticObstacles.obstacles[tableNum].table.pose.theta+3.14/4);
            point.y=staticObstacles.obstacles[tableNum].table.pose.y+distance*sin(3.14/2*pointNum+staticObstacles.obstacles[tableNum].table.pose.theta+3.14/4);
            goalCandidate.push_back(point);
            //cout<<point.x<<"    "<<point.y<<endl;
        }
        
        return goalCandidate;
    }

    potential setStaticObstacle(potential Potential,double param)
    {
        vector< vector <double> > tablePoses;
        for(int i=0;i<tables.size();i++)
        {
            vector<double> tablePose;
            tablePose.resize(4);   
            tablePose[0]=tables[i].pose.x/Potential.resolution+Potential.origin[0];
            tablePose[1]=tables[i].pose.y/Potential.resolution+Potential.origin[1];
            tablePose[2]=tables[i].width/Potential.resolution;
            tablePose[3]=tables[i].pose.theta;
            tablePoses.push_back(tablePose);
        }
        vector< vector <double> > chairPoses;
        for(int i=0;i<chairs.size();i++)
        {
            vector<double> chairPose;
            chairPose.resize(3);
            chairPose[0]=chairs[i].pose.x/Potential.resolution+Potential.origin[0];
            chairPose[1]=chairs[i].pose.y/Potential.resolution+Potential.origin[1];
            chairPose[2]=chairs[i].width/Potential.resolution;
            chairPoses.push_back(chairPose);
        }

        //  障害物ポテンシャルの定義
        potential ObstaclePotential;
        ObstaclePotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<ObstaclePotential.data.size();i++)
        {
            for(int j=0;j<ObstaclePotential.data[0].size();j++)
            {
                ObstaclePotential.data[i][j]=Potential.data[i][j];
            }
        }
        //障害物ポテンシャルの計算
        for (int i=0;i<ObstaclePotential.data.size();i++)
        {
            for(int j=0;j<ObstaclePotential.data[0].size();j++)
            {
                for(int k=0;k<tablePoses.size();k++)
                {
                    double distance=sqrt(pow((i-tablePoses[k][0]),2)+pow((j-tablePoses[k][1]),2));
                    double theta=atan((j-tablePoses[k][1])/(i-tablePoses[k][0]))+tablePoses[k][3];
                    
                    if (theta<0)
                    {
                        theta=-theta;
                    }
                    if (theta>3.14/4)
                    {
                        theta=-theta+3.14/2;
                    }
                    if(distance==0)
                    {
                        ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+3;
                    }
                    else
                    {
                        ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+this->func4(distance,1/cos(theta)*tablePoses[k][2]/2,param,Potential.resolution);
                    }
                }
                /*for(int k=0;k<chairPoses.size();k++)
                {
                    double distance=sqrt(pow((i-chairPoses[k][0]),2)+pow((j-chairPoses[k][1]),2));
                    
                    ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+this->func4(distance,chairPoses[k][2],param,Potential.resolution);
                }*/
            }
        }
        return ObstaclePotential;
    }
    
    potential setWagonObstacle(potential Potential,double param)
    {
        //  障害物ポテンシャルの定義
        potential ObstaclePotential;
        ObstaclePotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<ObstaclePotential.data.size();i++)
        {
            for(int j=0;j<ObstaclePotential.data[0].size();j++)
            {
                ObstaclePotential.data[i][j]=Potential.data[i][j];
            }
        }

        //ワゴンの位置姿勢取得
        vector <double>  wagonPose;
        wagonPose.resize(4);   
        double wagonWidth=0.4;
        try
        {
            tf::StampedTransform transform;
            tfListener.lookupTransform("/map", "/hsr_wagon_tf", ros::Time(0), transform);
            tf::Vector3 vec, euler;
            tf::Quaternion quat;
            double roll, pitch, yaw;
            vec = transform.getOrigin();
            quat  = transform.getRotation();
            tf::Quaternion q(quat[0], quat[1], quat[2], quat[3]);
            tf::Matrix3x3 m(q);
            m.getRPY(roll,pitch,yaw);
            
            wagonPose[0]=vec[0]/Potential.resolution+Potential.origin[0];
            wagonPose[1]=vec[1]/Potential.resolution+Potential.origin[1];
            wagonPose[2]=wagonWidth/Potential.resolution;
           
        }
        catch (tf::TransformException ex)
        {
            return ObstaclePotential;
        }

        //障害物ポテンシャルの計算
        for (int i=0;i<ObstaclePotential.data.size();i++)
        {
            for(int j=0;j<ObstaclePotential.data[0].size();j++)
            {
               
                double distance=sqrt(pow((i-wagonPose[0]),2)+pow((j-wagonPose[1]),2));
        
            
                ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+this->func4(distance,wagonPose[2],param,Potential.resolution);
            
               
            }
        }
        return ObstaclePotential;
    }

    potential setDynamicObstacle(potential Potential,geometry_msgs::PoseArray dynamicObstacle)
    {   
        double obstacleRadius=0.8;
        
        //  障害物の取得
        vector< vector <double> > obstaclePoses;
        for(int i=0;i<dynamicObstacle.poses.size();i++)
        {
            vector<double> obstaclePos;
            obstaclePos.push_back(dynamicObstacle.poses[i].position.x/Potential.resolution+Potential.origin[0]);
            obstaclePos.push_back(dynamicObstacle.poses[i].position.y/Potential.resolution+Potential.origin[1]);
            obstaclePos.push_back(obstacleRadius/Potential.resolution);
            
            obstaclePoses.push_back(obstaclePos);
        }
        //  障害物ポテンシャルの定義
        potential obstaclePotential;
        obstaclePotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<obstaclePotential.data.size();i++)
        {
            for(int j=0;j<obstaclePotential.data[0].size();j++)
            {
                obstaclePotential.data[i][j]=Potential.data[i][j];
            }
        }
        //障害物ポテンシャルの計算
        for (int i=0;i<obstaclePotential.data.size();i++)
        {
            for(int j=0;j<obstaclePotential.data[0].size();j++)
            {
                for(int k=0;k<obstaclePoses.size();k++)
                {
                    double distance=sqrt(pow((i-obstaclePoses[k][0]),2)+pow((j-obstaclePoses[k][1]),2));
                    if(distance==0)
                    {
                        obstaclePotential.data[i][j]=obstaclePotential.data[i][j]+2;
                    }
                    else
                    {
                        obstaclePotential.data[i][j]=obstaclePotential.data[i][j]+3*this->func4(distance,obstaclePoses[k][2],15,Potential.resolution);
                    }
                }
            }
        }
        return obstaclePotential;
    }

    potential setGoal(potential Potential,double goalX,double goalY)
    {
        double goalPos[2];
        goalPos[0]=goalX/Potential.resolution+Potential.origin[0];
        goalPos[1]=goalY/Potential.resolution+Potential.origin[1];
    
        //  goalポテンシャルの定義
        potential GoalPotential;
        GoalPotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<GoalPotential.data.size();i++)
        {
            for(int j=0;j<GoalPotential.data[0].size();j++)
            {
                GoalPotential.data[i][j]=Potential.data[i][j];
            }
        }
        //goalポテンシャルの計算
        for (int i=0;i<GoalPotential.data.size();i++)
        {
            for(int j=0;j<GoalPotential.data[0].size();j++)
            {
                double distance=sqrt(pow((i-goalPos[0]),2)+pow((j-goalPos[1]),2));
                if(GoalPotential.data[i][j]<0.1)
                {
                    if(distance==0)
                    {
                        GoalPotential.data[i][j]=GoalPotential.data[i][j]-3;
                    }
                    else
                    {
                        GoalPotential.data[i][j]=GoalPotential.data[i][j]-this->func5(2,distance,Potential.resolution);
                    }
                }   
            }
        }
        return GoalPotential;
    }
    potential setMultimodalPotential(potential Potential,printeps_hsr_modules::HsrOpenpose TargetPeople,double voiceImportance)
    {   
        double Func1Element[4]={0.00109,0.0316,1.94,0.0000285};
        double Func2Element[2]={-0.0036,1};

        // multimodalポテンシャルの定義
        potential multimodalPotential;
        multimodalPotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<multimodalPotential.data.size();i++)
        {
            for(int j=0;j<multimodalPotential.data[0].size();j++)
            {
                multimodalPotential.data[i][j]= Potential.data[i][j];
            }
        }

        //multimodalポテンシャルの計算
        for (int i=0;i<multimodalPotential.data.size();i++)
        {
            for(int j=0;j<multimodalPotential.data[0].size();j++)
            {
                for(int k=0;k<TargetPeople.people.size();k++)
                {
                    if(TargetPeople.people[k].confidence>0.05)
                    {
                        double personPos[2];
                        personPos[0]=TargetPeople.people[k].pose.x/Potential.resolution+Potential.origin[0];
                        personPos[1]=TargetPeople.people[k].pose.y/Potential.resolution+Potential.origin[1];
                        double distance=sqrt(pow((i-personPos[0]),2)+pow((j-personPos[1]),2))*Potential.resolution*100;
                        double theta=atan2((double)i-personPos[0],(double)j-personPos[1])/3.141592*(double)180+TargetPeople.people[k].pose.theta/3.141592*180-90;
                        //cout<<TargetPeople.people[k].confidence<<"   ";
                        if(theta>360)
                        {
                            theta=theta-360;
                        }
                        if(theta<-360)
                        {
                            theta=theta+360;
                        }
                        if(theta>180)
                        {
                            theta=360-theta;
                        }
                        if(theta<-180)
                        {
                            theta=360+theta;
                        }

                        //=======================ポテンシャル計算=================================
                        
                        //重みの計算
                        double imagePotentialWeight = 1-TargetPeople.people[k].confidence*voiceImportance;
                        double voicePotentialWeight = TargetPeople.people[k].confidence*voiceImportance;

                        //  画像ポテンシャルの考慮
                        if(distance==0)
                        {
                            multimodalPotential.data[i][j]=multimodalPotential.data[i][j]+1*imagePotentialWeight;
                        }
                        else
                        {
                            if(theta<0 && theta>-180)
                            {
                                multimodalPotential.data[i][j]=multimodalPotential.data[i][j]-imagePotentialWeight*(1-TargetPeople.people[k].confidence*0)/(1-TargetPeople.people[k].confidence)*this->func1(Func1Element[0],Func1Element[1],Func1Element[2],Func1Element[3],distance)*this->func2(Func2Element[0],Func2Element[1],-theta,TargetPeople.people[k].confidence);
                            }
                            else if(theta>=0 && theta<180)
                            {
                                multimodalPotential.data[i][j]=multimodalPotential.data[i][j]-imagePotentialWeight*(1-TargetPeople.people[k].confidence*0)/(1-TargetPeople.people[k].confidence)*this->func1(Func1Element[0],Func1Element[1],Func1Element[2],Func1Element[3],distance)*this->func2(Func2Element[0],Func2Element[1],theta,TargetPeople.people[k].confidence);
                            }
                        }
                        //  音声ポテンシャルの考慮
                        if(distance==0)
                        {
                            multimodalPotential.data[i][j]=multimodalPotential.data[i][j]-3*voicePotentialWeight;
                        }
                        else
                        {
                            multimodalPotential.data[i][j]=multimodalPotential.data[i][j]-this->func5(10,distance,Potential.resolution)*voicePotentialWeight;
                        }
                    }
                }
            }
        }
        return multimodalPotential;
    }

    vector<double> getGoal(potential Potential,double startX,double startY)
    {
        //最小値の取得
        double minimumValue=1;
        for (int i=0;i<Potential.data.size();i++)
        {
            for(int j=0;j<Potential.data[0].size();j++)
            {
                if(minimumValue>Potential.data[i][j])
                {
                    minimumValue=Potential.data[i][j];
                }
            }
        }
        cout<<"minimumValue="<<minimumValue<<endl;
        //最小値の9割以下のポイントの割り出し
        vector< vector<int> >points;
        for (int i=0;i<Potential.data.size();i++)
        {
            for(int j=0;j<Potential.data[0].size();j++)
            {
                if(minimumValue*0.97>Potential.data[i][j])
                {
                    vector<int>point;
                    point.push_back(i);
                    point.push_back(j);
                    points.push_back(point);
                }
            }
        }

        //割り出したポイントの中で最もスタートに近いものを選ぶ
        double startPos[2];
        startPos[0]=startX/Potential.resolution+Potential.origin[0];
        startPos[1]=startY/Potential.resolution+Potential.origin[1];

        double shortestDistance=10000;
        vector<double>goal;
        for(int i =0;i<points.size();i++)
        {
            double distance=sqrt(pow(startPos[0]-points[i][0],2)+pow(startPos[1]-points[i][1],2));
            if(shortestDistance>distance)
            {
                shortestDistance=distance;
                vector<double>g;
                g.push_back(points[i][0]);
                g.push_back(points[i][1]);
                goal=g;
            }
        }

        goal[0]=(goal[0]-Potential.origin[0])*Potential.resolution;
        goal[1]=(goal[1]-Potential.origin[1])*Potential.resolution;

        return goal;
    }

    vector<double> getGoalFromCandidate(potential Potential,vector<geometry_msgs::Pose2D> goalCandidate)
    {
        //ポテンシャルにおけるゴール候補点の取得
        vector<geometry_msgs::Pose2D> goalCandidateOnPotential;
        for(int goalNum=0;goalNum<goalCandidate.size();goalNum++)
        {
            geometry_msgs::Pose2D goalOnPotential;
            goalOnPotential.x=goalCandidate[goalNum].x/Potential.resolution+Potential.origin[0];
            goalOnPotential.y=goalCandidate[goalNum].y/Potential.resolution+Potential.origin[1];
            goalCandidateOnPotential.push_back(goalOnPotential);
        }

        //ゴール候補点の中でポテンシャルが最小値となる点の取得
        double minimumValue=1;
        double minimumIndex;
        for(int index=0; index<goalCandidateOnPotential.size();index++)
        {
            if(minimumValue>Potential.data[(int)goalCandidateOnPotential[index].x][(int)goalCandidateOnPotential[index].y])
            {
                minimumValue=Potential.data[(int)goalCandidateOnPotential[index].x][(int)goalCandidateOnPotential[index].y];
                minimumIndex=index;
            }
        }
        
        vector<double>goal;
        goal.resize(2);
        goal[0]=goalCandidate[minimumIndex].x;
        goal[1]=goalCandidate[minimumIndex].y;

        return goal;
    }

    potential map2potential(potential Mappotential,potential mapdata)
    {
        potential mappotential;
        mappotential.setup(Mappotential.resolution,Mappotential.width,Mappotential.height,Mappotential.origin[0],Mappotential.origin[1]);
        for(int i=0;i<Mappotential.data.size();i++)
        {
            for(int j=0;j<Mappotential.data[0].size();j++)
            {
                mappotential.data[i][j]=Mappotential.data[i][j];
            }
        }

        double potentialLimit[4];
        potentialLimit[0]=mappotential.width-mappotential.origin[0]*mappotential.resolution;
        potentialLimit[1]=-mappotential.origin[0]*mappotential.resolution;
        potentialLimit[2]=mappotential.height-mappotential.origin[1]*mappotential.resolution;
        potentialLimit[3]=-mappotential.origin[1]*mappotential.resolution;
        //cout<<potentialLimit[0]<<endl;
        int iLim=(int)(mapdata.width);
        int jLim=(int)(mapdata.height);
        /*cout<<iLim<<endl;
        cout<<jLim<<endl;
        cout<<mapdata.data.size()<<endl;
        cout<<mapdata.data[0].size()<<endl;
        cout<<mappotential.data.size()<<endl;
        cout<<mappotential.data[0].size()<<endl;
        cout<<mapdata.resolution<<endl;
        
        cout<<mapdata.origin[0]<<endl;
        cout<<mapdata.origin[1]<<endl;*/

        for(int i=0;i<iLim;i++)
        {
            for(int j=0;j<jLim;j++)
            {
                double x=(i+mapdata.origin[0]/mapdata.resolution)*mapdata.resolution;
                double y=(j+mapdata.origin[1]/mapdata.resolution)*mapdata.resolution;
                if(x<potentialLimit[0] && x>potentialLimit[1])
                {
                    if(y<potentialLimit[2] && y>potentialLimit[3])
                    {
                        int pi,pj;//ポテンシャルにおける座標
                        pi=(int)(x/mappotential.resolution)+mappotential.origin[0];
                        pj=(int)(y/mappotential.resolution)+mappotential.origin[1];
                    
                        if(mappotential.data[pi][pj]<mapdata.data[i][j])
                        {
                            mappotential.data[pi][pj]=mapdata.data[i][j]/100;
                        }
                        else if(mapdata.data[i][j]==-1)
                        {
                            mappotential.data[pi][pj]=10;
                        }
                    }
                }
            }
        }
        return mappotential;
    }
    sensor_msgs::PointCloud2 createPcd(potential Potential)
    {
        pcl::PointCloud<pcl::PointXYZ> cloud1;
        sensor_msgs::PointCloud2 cloud2;

        for(int i=0;i<(int)Potential.width/Potential.resolution;i++)
        {
            for(int j=0;j<(int)Potential.height/Potential.resolution;j++)
            {
                if(Potential.data[i][j]<5)
                {
                    pcl::PointXYZ o;
                    o.x=(double)(i-Potential.origin[0])*(double)Potential.resolution;
                    o.y=(double)(j-Potential.origin[1])*(double)Potential.resolution;
                    if(Potential.data[i][j]>1)
                    {
                        o.z=1;
                    }
                    else
                    {
                        o.z=Potential.data[i][j];
                    }
                    cloud1.push_back(o);
                }
            }
        }
        pcl::toROSMsg(cloud1,cloud2);
        return cloud2;
    }

    geometry_msgs::PoseArray createPathPoseArray(pathlist Path,double yaw)
    {
        geometry_msgs::PoseArray poseArray;
        for(int i=0;i<(int)Path.path.size();i++)
        {
            geometry_msgs::Pose pose;
            pose.position.x=(Path.path[i][0]-Path.origin[0])*Path.resolution;
            pose.position.y=(Path.path[i][1]-Path.origin[1])*Path.resolution;
            pose.position.z=0;
            tf::Quaternion quat;
            if(i!=Path.path.size()-1)
            {
                quat=tf::createQuaternionFromRPY(0,0,atan2(Path.path[i+1][1]-Path.path[i][1],Path.path[i+1][0]-Path.path[i][0]));
            }
            else
            {
                quat=tf::createQuaternionFromRPY(0,0,0);
            }
            quaternionTFToMsg(quat,pose.orientation);
            poseArray.poses.push_back(pose);  
        }
        tf::Quaternion quat=tf::createQuaternionFromRPY(0,0,yaw);
        quaternionTFToMsg(quat,poseArray.poses[poseArray.poses.size()-1].orientation);
        quat=tf::createQuaternionFromRPY(0,0,yaw);
        quaternionTFToMsg(quat,poseArray.poses[poseArray.poses.size()-2].orientation);
        return poseArray;
    }

    double getPathLength(pathlist Path)
    {
        double length=0;
        for(int i=0;i<(int)Path.path.size()-1;i++)
        {
            length+=sqrt(pow(Path.path[i][0]-Path.path[i+1][0],2)+pow(Path.path[i][1]-Path.path[i+1][1],2));
        }
        length*=Path.resolution;
        return length;
    }

    bool checkGrasp()
    {
        tf::StampedTransform transform;
        try
        {
            tfListener.lookupTransform("/base_footprint", "/hand_palm_link", ros::Time(0), transform);
            tf::Vector3 vec, euler;
            tf::Quaternion quat;
            double roll, pitch, yaw;
            vec = transform.getOrigin();
            quat  = transform.getRotation();
            tf::Quaternion q(quat[0], quat[1], quat[2], quat[3]);
            if(vec[0]>0.4)//ワゴンをつかむ姿勢
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (tf::TransformException ex)
        {
            return false;
        }
    }
    
    double func1(double A,double B,double C,double D,double x)
    {
        double f=((log(A*x)/(B*x))+C)/(1+D*pow(x,2));
        return f;
    }
    double func2(double A,double B,double x,double R)
    {
       double f=pow(R/0.3,1)*A*x+B;
       return f;
    }
    double func3(double D,double x)
    {
        double f=1/(1+D*pow(x,2));
        return f;
    }
    double func4(double x,double r,double g,double resolution)
    {
        double f=1/(1+exp(g*resolution*(x-r)));
        return f;
    }
    double func5(double E,double r,double resolution)
    {
        double f=3/(1+E*resolution*r);
        return f;
    }
};

int main(int argc, char **argv)
{
    ros::init(argc, argv, "hsr_pathGeneratorService");
    ros::start(); 
    setPotential setpotential;
    ros::spin();
}
