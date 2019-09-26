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
#include <geometry_msgs/Vector3.h>

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

#include "printeps_hsr_modules/HsrObstacle.h"
#include "printeps_hsr_modules/HsrObstacleArray.h"
#include "printeps_hsr_modules/HsrTableset.h"

#include "printeps_hsr_modules/HsrPerson.h"
#include "printeps_hsr_modules/HsrOpenpose.h"

using namespace Eigen;
using namespace std;

class kalmanfilter
{
private:
	MatrixXd I;//=cv::Mat_<double>(2,2);
	//=cv::Mat_<double>(2,2);
	MatrixXd y1;//=cv::Mat_<double>(2,1);
	MatrixXd yb;//=cv::Mat_<double>(2,1);
	MatrixXd xb;//=cv::Mat_<double>(1,2);
	MatrixXd p1;//=cv::Mat_<double>(2,2);
	
	MatrixXd g;//=cv::Mat_<double>(1,2);
	MatrixXd A;//=cv::Mat_<double>(2,2);
	MatrixXd b;//=cv::Mat_<double>(1,2);
	MatrixXd c;//=cv::Mat_<double>(2,1);

	MatrixXd R;
	MatrixXd Q;


	double sigmaV, sigmaW;
	double time = 0;
    MatrixXd pb;//=cv::Mat_<double>(2,2);
	MatrixXd x1;

public:
	kalmanfilter()
    {
        I = MatrixXd::Identity(6, 6);
        x1.resize(6, 1);

        double sigmaV2, sigmaW2;
        sigmaV2 = 50;//秒速0.2mくらいは加減速できる
        sigmaW2 = 10;//10センチくらいは計測誤差がある
        sigmaV = sigmaV2*sigmaV2;
        sigmaW = sigmaW2*sigmaW2;
        double sdVt = (double)(80.0 / 180.0) * 3.14;
        double sigmaVt = sdVt*sdVt;
        double sdWt = (double)(10.0 / 180.0) * 3.14;
        double sigmaWt = sdWt*sdWt;
        p1.resize(6, 6);

        y1.resize(3, 1);
        yb.resize(3, 1);

        A.resize(6, 6);
        R.resize(3, 3);
        Q.resize(3, 3);
        b.resize(6, 3);
        c.resize(3, 6);	

        c << 1, 0, 0, 0, 0, 0,
             0, 1, 0, 0, 0, 0,
             0, 0, 1, 0, 0, 0;

        Q << sigmaV, 0, 0,
            0, sigmaV, 0,
            0, 0, sigmaVt;
        R << sigmaW, 0, 0,
            0, sigmaW, 0,
            0, 0, sigmaWt;

        p1 << 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0;
    };
	~kalmanfilter()
    {

    };

	void initialize(geometry_msgs::Pose2D initPose,double nowtime)
    {
        y1 << initPose.x, initPose.y, initPose.theta;
        x1  <<  y1(0, 0),
                y1(1, 0),
                y1(2, 0),
                0,
                0,
                0;
        xb=x1;
        //cout<<"xb	"<<xb<<endl;
        time = nowtime;
        //cout<<"xb	"<<y1<<endl;
    }
	void predictionStep(double nowtime)
    {
        //cout<<"prediction"<<endl;
        //cout<<RobotMat<<endl;
        //cout << "pridict	" << endl;
        double dt = (nowtime - time);
        //cout << "	dt	" << dt << endl;
        time = nowtime;
        //cout<<"1"<<endl;
       
       //静止モデル
        x1(3,0)=0;
        x1(4,0)=0;
        x1(5,0)=0;
        A << 1, 0, 0, dt, 0, 0,
            0, 1, 0, 0, dt, 0,
            0, 0, 1, 0, 0, dt,
            0, 0, 0, 1, 0, 0,
            0, 0, 0, 0, 1, 0,
            0, 0, 0, 0, 0, 1;
        
        b << 0, 0, 0,
            0, 0, 0,
            0, 0, 0,
            dt, 0, 0,
            0, dt, 0,
            0, 0, dt;

        //cout<<"3"<<y1<<endl;
        xb = A*x1;//絶対座標系
        pb = A*p1*(A.transpose()) + b*sigmaV*(b.transpose());
        g = pb*c.transpose()*((c*pb*c.transpose() + R).inverse());

        yb=c*xb;

        //cout<<x1<<endl;
    };
	void filteringStep(geometry_msgs::Pose2D observePose)
    {
        //cout<<"filtering"<<endl;
        //cout << "filtering	" << endl;
        //cout << "observe1  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
        int count = 0;
        while (1)
        {
            if (observePose.theta - xb(2,0) > 6.28*0.9)//360くらいの差が出ているとき
            {
                observePose.theta -= 3.14 * 2;
            }
            else if (observePose.theta - xb(2,0) < -6.28*0.9)//360度くらい差が出ているとき
            {
                observePose.theta += 3.14 * 2;
            }
            else
            {
                break;
            }
            //cout << "observe2  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
        }

        //cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
        if(abs((observePose.theta-3.14)-xb(2,0))<abs((observePose.theta)-xb(2,0)))
        {
            observePose.theta-=3.14;
        }
        else if(abs((observePose.theta+3.14)-xb(2,0))<abs((observePose.theta)-xb(2,0)))
        {
            observePose.theta+=3.14;
        }
        //cout << "observe3  " << observe.pos.x << "  " << observe.pos.y << "  " << observe.pos.z << endl;
        y1 << observePose.x, observePose.y, observePose.theta;
        
        x1 = xb + g*(y1 - c*xb);
        p1 = (I - g*c)*pb;

        yb=c*x1;
    };
    void nodata()
    {
        x1 = xb;
        p1 = (I - g*c)*pb;
    };

    MatrixXd getX()
    {
        return x1;
    }
};
class person {
private:
    double reliability;
    kalmanfilter KF;
    double time = 0;

    //一秒あたりに減衰する信頼度の量
    double kp   = 0.1;

public:
	person(geometry_msgs::Pose2D initPose, double nowtime)
    {
        reliability = 0;
        KF.initialize(initPose, nowtime);
    };
    
    //観測値がない場合の更新
    void update(double nowtime)
    {
        reliability -= kp*(nowtime - time);
        if(reliability < 0)
        {
            reliability = 0;
        }
        KF.predictionStep(nowtime);
        KF.nodata();
        time        = nowtime;
    }
    //観測値がある場合の更新
    void update(geometry_msgs::Pose2D obsPose, double nowtime, double obsReliability)
    {
        reliability = obsReliability;
        KF.predictionStep(nowtime);
        KF.filteringStep(obsPose);
        time        = nowtime;
    }
	
    geometry_msgs::Pose2D getPose()
    {
        geometry_msgs::Pose2D pose;
        MatrixXd x  = KF.getX();
        pose.x      = x(0,0);
        pose.y      = x(1,0);
        pose.theta  = x(2,0);

        return pose;
    } 
    double getReliability()
    {
        return reliability;
    }
};

class hsrOpenposeKF
{
private:
    ros::NodeHandle     _nh;
    
    ros::Publisher      pubPeople;
    ros::Publisher      pubHumanPos;
    
    ros::Subscriber     subTarget;
    ros::Subscriber     subObservePeople;
    ros::Subscriber     subStaticObstacle;

    ros::Timer          timer;

    vector<person> filteringPeople;
    printeps_hsr_modules::HsrObstacleArray staticObstacles;

    printeps_hsr_modules::HsrOpenpose observedPeople; 
    printeps_hsr_modules::HsrOpenpose filterdPeople; 

    geometry_msgs::Pose2D tablePos;
    vector< geometry_msgs::Pose2D > chairPoses;

    //二次元ベクトルの内積
    double dotProduct(geometry_msgs::Pose2D a, geometry_msgs::Pose2D b)
    {
        return a.x*b.x+a.y*b.y;
    }

    //二次元ベクトルの長さ
    double getLength(geometry_msgs::Pose2D a)
    {
        return sqrt(pow(a.x,2)+pow(a.y,2));
    }

    int getTableNum(double x,double y)
    {
        //最も近いテーブル番号を返す
        double distance=100000;
        int tableNum;
        for(int tablesetNum=0;tablesetNum<staticObstacles.obstacles.size();tablesetNum++)
        {
            double tempDistance = sqrt(pow(x-staticObstacles.obstacles[tablesetNum].table.pose.x,2)+pow(y-staticObstacles.obstacles[tablesetNum].table.pose.y,2));
            if(distance > tempDistance)
            {
                distance    = tempDistance;
                tableNum    = tablesetNum;
            }
        }
        return tableNum;
    }

    printeps_hsr_modules::HsrOpenpose extractPeople(printeps_hsr_modules::HsrOpenpose ObservedPeople)
    {
        //  観測したそれぞれの人がどこの椅子に該当するか確認
        //  同じ椅子に複数人該当する場合はその中で最も信頼度が高い人を採用する
        //  存在しない場合は信頼度0にする

        //椅子分の信頼度0の人を確保
        printeps_hsr_modules::HsrOpenpose extractedPeople;
        for(int i=0;i<chairPoses.size();i++)
        {
            printeps_hsr_modules::HsrPerson tempPerson;
            tempPerson.confidence   = -1;
            extractedPeople.people.push_back(tempPerson);
        }

        // それぞれの観測した人がどの椅子に該当するかを判別
        // 信頼度が高ければその人をその椅子の人として採用
        for(int peopleNum=0; peopleNum<ObservedPeople.people.size();peopleNum++)
        {
            geometry_msgs::Pose2D a,b;
            a.x = ObservedPeople.people[peopleNum].pose.x - tablePos.x;
            a.y = ObservedPeople.people[peopleNum].pose.y - tablePos.y;

            //ある程度机から近いかチェック
            if(getLength(a)<1.5)
            {
                for(int chairNum=0; chairNum<chairPoses.size();chairNum++)
                {
                    b.x = chairPoses[chairNum].x - tablePos.x;
                    b.y = chairPoses[chairNum].y - tablePos.y;

                    double theta = acos(dotProduct(a,b)/(getLength(a)*getLength(b)));
                    //この椅子に該当するかチェック
                    if(theta < 3.14/4)
                    {
                        //この椅子に該当した場合、信頼度をチェック
                        //高い場合は採用
                        if(ObservedPeople.people[peopleNum].confidence>extractedPeople.people[chairNum].confidence)
                        {
                            extractedPeople.people[chairNum] = ObservedPeople.people[peopleNum];
                        }
                    }
                }
            }
        }

        return extractedPeople;
    }

    void getTarget(const geometry_msgs::Pose2D goal)
    {
        //cout<<"getTarget"<<endl;
        //ロボットが向かうテーブル番号の取得
        int tableNum = getTableNum(goal.x,goal.y);
        //cout<<"tableNum:"<<tableNum<<endl;
        tablePos = staticObstacles.obstacles[tableNum].table.pose;

        //テーブル番号に基づき各人の初期値の初期化
        filteringPeople.clear();
        chairPoses.clear();
        for(int chairNum=0;chairNum<staticObstacles.obstacles[tableNum].chairs.size();chairNum++)
        {
            geometry_msgs::Pose2D pose;
            geometry_msgs::Pose2D tempChairPos    = staticObstacles.obstacles[tableNum].chairs[chairNum].pose;
            pose.x      = tempChairPos.x;
            pose.y      = tempChairPos.y;
            pose.theta  = atan2( staticObstacles.obstacles[tableNum].table.pose.y-tempChairPos.y, staticObstacles.obstacles[tableNum].table.pose.x-tempChairPos.x);
            person tempPerson(pose, ros::Time::now().toSec());
            filteringPeople.push_back(tempPerson);
            chairPoses.push_back(tempChairPos);
        }

        //cout<<"initialized KF"<<tableNum<<endl;
    }

    void getStaticObstacle(const printeps_hsr_modules::HsrObstacleArray  StaticObstacles)
    {
        //cout<<"getStaticObstacle"<<endl;
        staticObstacles=StaticObstacles;
    }

    void getObservedPeople(const printeps_hsr_modules::HsrOpenpose getOpenpose)
    {
        observedPeople = getOpenpose;
    }
    void timerCallback(const ros::TimerEvent&)
    {
        //  まず観測した人がいるかどうか確認
        if(observedPeople.people.size()>0)
        {
            //  観測した人がいる場合
            //  観測した人の整理
            observedPeople=extractPeople(observedPeople);
            for(int i=0;i<filteringPeople.size();i++)
            {
                //  信頼度が高い場合は更新
                if(observedPeople.people[i].confidence > filteringPeople[i].getReliability())
                {
                    geometry_msgs::Pose2D pose;
                    pose.x      = observedPeople.people[i].pose.x;
                    pose.y      = observedPeople.people[i].pose.y;
                    pose.theta  = filteringPeople[i].getPose().theta;
                    filteringPeople[i].update(pose,ros::Time::now().toSec(),observedPeople.people[i].confidence);
                }
                //  信頼度が低い場合は採用しない
                else
                {
                    filteringPeople[i].update(ros::Time::now().toSec());
                }
            }
        }
        else
        {
            //　観測した人がいない場合
            for(int i=0;i<filteringPeople.size();i++)
            {
                filteringPeople[i].update(ros::Time::now().toSec());
            }
        }

        //信頼度が0の席は初期値を椅子にしておく
        for(int i=0;i<filteringPeople.size();i++)
        {
            if(filteringPeople[i].getReliability()==0)
            {
                person tempPerson(chairPoses[i], ros::Time::now().toSec());
                filteringPeople[i] = tempPerson;
            }
        }

        //現在認識している人を描画する
        for(int i=0;i<filteringPeople.size();i++)
        {
            if(filteringPeople[i].getReliability()>0)
            {
                visualization_msgs::Marker peoplePos;

                peoplePos.header.frame_id="map";
                peoplePos.header.stamp=ros::Time::now();
                peoplePos.pose.position.x=filteringPeople[i].getPose().x;
                peoplePos.pose.position.y=filteringPeople[i].getPose().y;
                peoplePos.pose.position.z=filteringPeople[i].getReliability()*2;

                peoplePos.ns = "filterdPeople";
                peoplePos.id = i;
                peoplePos.type = visualization_msgs::Marker::CYLINDER;
                peoplePos.action = visualization_msgs::Marker::ADD;

                peoplePos.scale.x = 0.4;
                peoplePos.scale.y = 0.4;
                peoplePos.scale.z = 1.6;

                peoplePos.color.r = 0;
                peoplePos.color.g = (float)1;
                peoplePos.color.b = 0;
                peoplePos.color.a = 1.0;
                
                peoplePos.lifetime = ros::Duration(0.3);

                pubHumanPos.publish(peoplePos);
            }
        }

        //現在認識している人をpublishする   
        filterdPeople.people.clear();
        for(int i=0;i<filteringPeople.size();i++)
        {
            if(filteringPeople[i].getReliability()>0)
            {
                printeps_hsr_modules::HsrPerson tempPerson;
                tempPerson.pose.x       = filteringPeople[i].getPose().x;
                tempPerson.pose.y       = filteringPeople[i].getPose().y;
                tempPerson.pose.theta   = filteringPeople[i].getPose().theta;
                tempPerson.confidence   = filteringPeople[i].getReliability();

                filterdPeople.people.push_back(tempPerson);
            }
        }
        if(filterdPeople.people.size()>0)
        {
            pubPeople.publish(filterdPeople);
        }
    }

public:
    hsrOpenposeKF()
    {
        //initializing
        ROS_INFO("====================hsr_openpose_kalmanfilter====================");
        
        pubPeople           = _nh.advertise<printeps_hsr_modules::HsrOpenpose> ("/hsr_filtered_people", 5);
        pubHumanPos         = _nh.advertise<visualization_msgs::Marker>("hsr_filterd_people_marker",4);
        
        subTarget           = _nh.subscribe("/hsr_openpose_kf_target",1,&hsrOpenposeKF::getTarget,this);
        subObservePeople    = _nh.subscribe("/hsr_observed_people",1,&hsrOpenposeKF::getObservedPeople,this);
        subStaticObstacle   = _nh.subscribe("/hsr_obstacles",1,&hsrOpenposeKF::getStaticObstacle,this);

        timer               = _nh.createTimer(ros::Duration(0.1), &hsrOpenposeKF::timerCallback,this);
        ROS_INFO("Initializing End");
    }

};
int main(int argc, char **argv)
{
    ros::init(argc, argv, "hsr_openpose_kalmanfilter");
    ros::start(); 
    hsrOpenposeKF HsrOpenposeKF;
    ros::spin();
}