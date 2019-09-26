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
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
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
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <algorithm>

#include <boost/thread/thread.hpp>
#include <pcl/common/common_headers.h>
#include <pcl/features/normal_3d.h>
#include <pcl/point_types.h>


#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_broadcaster.h>

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

    potential()
    {
        
    }
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
        cout<<"start   "<<Start[0]<<"  "<<Start[1]<<endl;
        cout<<"goal   "<<Goal[0]<<"  "<<Goal[1]<<endl;
        cout<<"AstarFunc"<<endl;
        int gridnum[2]={Potential.data.size(),Potential.data[0].size()};


        // A*
        cout<<" start A*"<<endl;
        //コストの定義
        cout<<" set cost"<<endl;
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
        cout<<" set open close"<<endl;
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
        cout<<" set oparent"<<endl;
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
        cout<<" start Loop"<<endl;
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
                            double totalcost=TotalCost[n[0]][n[1]]-HCost[n[0]][n[1]]+HCost[m[0]][m[1]]+10*Cost+movementCost;
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
        cout<<Searching<<endl;;
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
    ros::NodeHandle _nh;
    tf::TransformListener tflistener;    //= new tf::TransformListener();
    tf::TransformBroadcaster br;
    tf::Transform transform;
    ros::Publisher pubO = _nh.advertise<sensor_msgs::PointCloud2> ("obstaclePotential", 1);
    ros::Publisher pubP        = _nh.advertise<geometry_msgs::PoseArray> ("path", 1);
    ros::Publisher pubC = _nh.advertise<std_msgs::String> ("/clean_up", 5);
    ros::Subscriber sub_goal, sub_map;
    potential Potential;
    potential map;
    potential mapPotential;
    potential obstaclePotential;

    pathlist path;
    sensor_msgs::PointCloud2 output1;
    geometry_msgs::PoseArray pathout;
    vector<double> RobotPos;
    
public:
    setPotential()
    {
        ROS_INFO("====================setPotential====================");
        sub_goal    = _nh.subscribe("/path_goal",1,&setPotential::getGoal,this);
        sub_map    = _nh.subscribe("/map",1,&setPotential::getMap,this);
        ROS_INFO("Listening for incoming data on topic /peopleReliability ...");
        RobotPos={2,2};
    }
    ~setPotential(){}

    void GeneratePath()
    {
        
        

        //ss << vec.x() << "," << vec.y() << "," << vec.z() << "," << roll << "," << pitch << "," << yaw << ",";
        
       
        //ROS_INFO("setPotential----Set Potential");
        //cout<<"set People"<<endl;
        //cout<<"set Potential"<<endl;
        
        //cout<<"create Pcd"<<endl;
        
        /*ROS_INFO("setPotential----Astar");
        path=this->AstarFunc(start,potential);
        ROS_INFO("setPotential----path");
        pathPCD=this->createPathPcd(path,resolution);
        pathPCD.header.frame_id ="map";
        pubP.publish(pathPCD);*/
                
    }
    void getGoal(const geometry_msgs::PoseStamped sub_goal)
    {
        Potential.setup(0.20,40,40,100,100);
        getRobotPos();
        double roll, pitch, yaw;
        tf::Quaternion q(sub_goal.pose.orientation.x, sub_goal.pose.orientation.y, sub_goal.pose.orientation.z, sub_goal.pose.orientation.w);
        tf::Matrix3x3 m(q);
        m.getRPY(roll,pitch,yaw);
        cout<<"start  "<<RobotPos[0]<<","<<RobotPos[1]<<endl;
        cout<<"goal  "<<sub_goal.pose.position.x<<","<<sub_goal.pose.position.y<<endl;
        Potential=this->map2potential(Potential,map);
        Potential=this->setObstacle(Potential);
        output1=this->createPcd(Potential);
        output1.header.frame_id ="map";
        pubO.publish(output1);
        cout<<"setPotential----Astar"<<endl;;
        astar Astar;
        Astar.setup(RobotPos[0],RobotPos[1],sub_goal.pose.position.x,sub_goal.pose.position.y,Potential);
        path=Astar.solve();
        ROS_INFO("setPotential----path");
        //PoseArray作成
        pathout=this->createPathPoseArray(path,yaw);
        pathout.header.frame_id ="map";
        pubP.publish(pathout);
        ros::Duration(2.0).sleep();
        std_msgs::String msg;
        msg.data="start";
        pubC.publish(msg);
    }

    

    void getRobotPos()
    {
        tf::StampedTransform transform;
        try
        {
          //tflistener.lookupTransform("/map", "/base_footprint", ros::Time(0), transform);
          tflistener.lookupTransform("/map", "/base_footprint", ros::Time(0), transform);
        }
        catch (tf::TransformException ex)
        {
          ROS_ERROR("%s", ex.what());
          ros::Duration(1.0).sleep();
        }

        tf::Vector3 vec, euler;
        tf::Quaternion quat;
        vec = transform.getOrigin();
        
        RobotPos[0]=(double)vec.x();
        RobotPos[1]=(double)vec.y();
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
        cout<<"getmap"<<endl;
    }

    potential setObstacle(potential Potential)
    {
        vector< vector <double> > Obstacles;//テーブルの位置[x[m],y[m],width[m],rad[deg]]
        vector< vector <double> > chairObstacles;//テーブルの位置[x[m],y[m],width[m],rad[deg]]
        vector< double >table;
        vector< double >chair;

        //table1
        table.push_back(1.5);
        table.push_back(-1.0);
        table.push_back(0.7);
        table.push_back(3.14/4);
        Obstacles.push_back(table);

        double chairDistance=0.7;
        chair.push_back(Obstacles[0][0]+chairDistance*cos(Obstacles[0][3]));
        chair.push_back(Obstacles[0][1]+chairDistance*sin(Obstacles[0][3]));
        chair.push_back(0.4);
        chairObstacles.push_back(chair);
        for(int i=0;i<3;i++)
        {
            chair[0]=Obstacles[0][0]+chairDistance*cos(3.14/2*(i+1)+Obstacles[0][3]);
            chair[1]=Obstacles[0][1]+chairDistance*sin(3.14/2*(i+1)+Obstacles[0][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }

        //table2
        table[0]=4.5;
        table[1]=-1.0;
        table[2]=0.9;
        table[3]=3.14/4;
        Obstacles.push_back(table);
        for(int i=0;i<4;i++)
        {
            chair[0]=Obstacles[1][0]+chairDistance*cos(3.14/2*i+Obstacles[1][3]);
            chair[1]=Obstacles[1][1]+chairDistance*sin(3.14/2*i+Obstacles[1][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }

        //table3
        table[0]=7.5;
        table[1]=-1.0;
        table[2]=0.9;
        table[3]=3.14/4;
        Obstacles.push_back(table);
        for(int i=0;i<4;i++)
        {
            chair[0]=Obstacles[2][0]+chairDistance*cos(3.14/2*i+Obstacles[2][3]);
            chair[1]=Obstacles[2][1]+chairDistance*sin(3.14/2*i+Obstacles[2][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }

        //table4
        table[0]=10.5;
        table[1]=-1.0;
        table[2]=0.9;
        table[3]=3.14/4;
        Obstacles.push_back(table);
        for(int i=0;i<4;i++)
        {
            chair[0]=Obstacles[3][0]+chairDistance*cos(3.14/2*i+Obstacles[3][3]);
            chair[1]=Obstacles[3][1]+chairDistance*sin(3.14/2*i+Obstacles[3][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }

        //table5
        table[0]=4.0;
        table[1]=-3.5;
        table[2]=0.9;
        table[3]=0;
        Obstacles.push_back(table);
        for(int i=0;i<2;i++)
        {
            chair[0]=Obstacles[4][0]+chairDistance*cos(3.14*i+Obstacles[4][3]);
            chair[1]=Obstacles[4][1]+chairDistance*sin(3.14*i+Obstacles[4][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }

        //table6
        table[0]=7.5;
        table[1]=-3.5;
        table[2]=0.9;
        table[3]=0;
        Obstacles.push_back(table);
        for(int i=0;i<2;i++)
        {
            chair[0]=Obstacles[5][0]+chairDistance*cos(3.14*i+Obstacles[5][3]);
            chair[1]=Obstacles[5][1]+chairDistance*sin(3.14*i+Obstacles[5][3]);
            chair[2]=0.4;
            chairObstacles.push_back(chair);
        }
        
        vector< vector <double> > ObstaclePoses;
        for(int i=0;i<Obstacles.size();i++)
        {
            vector<double> ObstaclePos;
            ObstaclePos=Obstacles[i];
            
        
            ObstaclePos[0]=ObstaclePos[0]/Potential.resolution+Potential.origin[0];
            ObstaclePos[1]=ObstaclePos[1]/Potential.resolution+Potential.origin[1];
            ObstaclePos[2]=ObstaclePos[2]/Potential.resolution;
            
            ObstaclePoses.push_back(ObstaclePos);
        }

        vector< vector <double> > chairObstaclePoses;
        for(int i=0;i<chairObstacles.size();i++)
        {
            vector<double> chairObstaclePos;
            chairObstaclePos=chairObstacles[i];
            
        
            chairObstaclePos[0]=chairObstaclePos[0]/Potential.resolution+Potential.origin[0];
            chairObstaclePos[1]=chairObstaclePos[1]/Potential.resolution+Potential.origin[1];
            chairObstaclePos[2]=chairObstaclePos[2]/Potential.resolution;
            
            chairObstaclePoses.push_back(chairObstaclePos);
        }

        //  障害物ポテンシャルの定義
        potential ObstaclePotential;
        ObstaclePotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);

        //統合ポテンシャル
        potential IntegrationPotential;
        IntegrationPotential.setup(Potential.resolution,Potential.width,Potential.height,Potential.origin[0],Potential.origin[1]);
        for(int i=0;i<IntegrationPotential.data.size();i++)
        {
            for(int j=0;j<IntegrationPotential.data[0].size();j++)
            {
                IntegrationPotential.data[i][j]=Potential.data[i][j];
            }
        }

        //障害物ポテンシャルの計算
        for (int i=0;i<ObstaclePotential.data.size();i++)
        {
            for(int j=0;j<ObstaclePotential.data[0].size();j++)
            {
                for(int k=0;k<Obstacles.size();k++)
                {
                    double distance=sqrt(pow((i-ObstaclePoses[k][0]),2)+pow((j-ObstaclePoses[k][1]),2));
                    double theta=atan((j-ObstaclePoses[k][1])/(i-ObstaclePoses[k][0]))+ObstaclePoses[k][3];
                    
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
                        ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+1;
                    }
                    else
                    {
                        ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+this->func4(distance,1/cos(theta)*ObstaclePoses[k][2]/2,Potential.resolution);
                    }
                }
                for(int k=0;k<chairObstacles.size();k++)
                {
                    double distance=sqrt(pow((i-chairObstaclePoses[k][0]),2)+pow((j-chairObstaclePoses[k][1]),2));
                    
                    ObstaclePotential.data[i][j]=ObstaclePotential.data[i][j]+this->func4(distance,chairObstaclePoses[k][2],Potential.resolution);
                }
            }
        }
        //統合
        for (int i=0;i<IntegrationPotential.data.size();i++)
        {
            for (int j=0;j<IntegrationPotential.data[0].size();j++)
            {
                IntegrationPotential.data[i][j]+=ObstaclePotential.data[i][j];
            }
        }
        return IntegrationPotential;
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
        cout<<potentialLimit[0]<<endl;
        int iLim=(int)(mapdata.width);
        int jLim=(int)(mapdata.height);
        cout<<iLim<<endl;
        cout<<jLim<<endl;
        cout<<mapdata.data.size()<<endl;
        cout<<mapdata.data[0].size()<<endl;
        cout<<mappotential.data.size()<<endl;
        cout<<mappotential.data[0].size()<<endl;
        cout<<mapdata.resolution<<endl;
        
        cout<<mapdata.origin[0]<<endl;
        cout<<mapdata.origin[1]<<endl;

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
                pcl::PointXYZ o;
                o.x=(double)(i-Potential.origin[0])*(double)Potential.resolution;
                o.y=(double)(j-Potential.origin[1])*(double)Potential.resolution;
                o.z=Potential.data[i][j];
                cloud1.push_back(o);
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
            
            if(i==Path.path.size()-1)
            {
                tf::Quaternion quat=tf::createQuaternionFromRPY(0,0,yaw);
                quaternionTFToMsg(quat,pose.orientation);
            }
            else
            {
                tf::Quaternion quat=tf::createQuaternionFromRPY(0,0,atan2(Path.path[i+1][1]-Path.path[i][1],Path.path[i+1][0]-Path.path[i][0]));
                quaternionTFToMsg(quat,pose.orientation);
                
            }

            poseArray.poses.push_back(pose);   
            
        }
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
    
    double func1(double A,double B,double C,double D,double x)
    {
        double f=((log(A*x)/(B*x))+C)/(1+D*pow(x,2));
        return f;
    }
    double func2(double A,double B,double x,double R)
    {
       double f=(R/0.5)*(R/0.5)*A*x+B;
       return f;
    }
    double func3(double D,double x)
    {
        double f=1/(1+D*pow(x,2));
        return f;
    }
    double func4(double x,double r,double resolution)
    {
        double f=1/(1+exp(10*resolution*(x-r)));
        return f;
    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "pathGenerator");
  ros::start(); 
  setPotential setpotential;
  ros::spin();
}
