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
#include <geometry_msgs/Point.h>

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

#include "printeps_hsr_modules/HsrGlbNav.h"
#include "printeps_hsr_modules/HsrMMNav.h"
#include "printeps_hsr_modules/PathGenerator.h"

class hsrGlobalNavigation
{
private:
    ros::NodeHandle       _nh;
    tf::TransformListener tfListener;
    ros::ServiceServer    globalNav;
    ros::ServiceServer    multimodalNav;
    ros::ServiceClient    pathGene;
    ros::Publisher        pubPotential;
    ros::Publisher        pubPath;
    ros::Publisher        pubTraceControl;
    ros::Publisher        pubGoal;
    ros::Publisher        pubOpenposeStart;
    ros::Publisher        pubOpenposeFilterStart;
    ros::Subscriber       subTraceStatus;
    ros::Subscriber       subWayPoint;

    geometry_msgs::Pose2D RobotPos;
    std::string RobotStatus;
    geometry_msgs::Pose wayPoint;
    
public:
    hsrGlobalNavigation()
    {
        //initializing
        ROS_INFO("====================hsr_globalNavigation====================");
        globalNav               = _nh.advertiseService("hsr_global_navigation",&hsrGlobalNavigation::globalNavigation,this);
        multimodalNav           = _nh.advertiseService("hsr_multimodal_navigation",&hsrGlobalNavigation::multimodalNavigation,this);
        pathGene                = _nh.serviceClient<printeps_hsr_modules::PathGenerator>("hsr_path_generator");
        pubPath                 = _nh.advertise<geometry_msgs::PoseArray> ("/hsr_path", 1);
        pubTraceControl         = _nh.advertise<std_msgs::String> ("/hsr_trace_control", 5);
        pubGoal                 = _nh.advertise<geometry_msgs::Pose2D> ("/hsr_goal", 5);
        pubOpenposeStart        = _nh.advertise<std_msgs::String> ("/hsr_openpose_start", 20);
        pubOpenposeFilterStart  = _nh.advertise<geometry_msgs::Pose2D> ("/hsr_openpose_kf_target", 20);
        subTraceStatus          = _nh.subscribe("/hsr_trace_status",1,&hsrGlobalNavigation::getStatus,this);
        subWayPoint             = _nh.subscribe("/hsr_target",1,&hsrGlobalNavigation::getWayPoint,this);
        ROS_INFO("Initializing End");
    
    }
    bool globalNavigation(printeps_hsr_modules::HsrGlbNav::Request  &req,
                          printeps_hsr_modules::HsrGlbNav::Response &res)
    {
        //スタート地点の取得
        getRobotPos();

        //パス取得の準備
        printeps_hsr_modules::PathGenerator pathGeneSrv;
        pathGeneSrv.request.start = RobotPos;
        pathGeneSrv.request.goal  = req.pose;
        pathGeneSrv.request.dynamicObstacle.poses.clear();
        pathGeneSrv.request.dynamicObstacle.header.frame_id ="map";
        pathGeneSrv.request.multimodalPathplanning.data =false;
        pathGeneSrv.request.voiceImportance.data                 = 0;

        geometry_msgs::Pose2D goalPoint;
        goalPoint.x=req.pose.x;
        goalPoint.y=req.pose.y;
        goalPoint.y=req.pose.theta;
        pubGoal.publish(goalPoint);

        //パスの取得とパブリッシュ
        if(pathGene.call(pathGeneSrv))
        {

            ROS_INFO("Successed to get path");
            //取得したpathのパブリッシュ
            pubPath.publish(pathGeneSrv.response.path);
            geometry_msgs::Pose2D goalPoint;
            goalPoint.x=req.pose.x;
            goalPoint.y=req.pose.y;
            goalPoint.theta=req.pose.theta;
            pubGoal.publish(goalPoint);
            ros::Duration(0.8).sleep();
            
            //ロボットに動作開始の命令
            std_msgs::String controlCommand;
            controlCommand.data="start";
            pubTraceControl.publish(controlCommand);
            RobotStatus="start";

            //ロボットの動作の監視
            bool please=false;
            ros::Rate loop_rate(10);//10hz
            double beforetime=ros::Time::now().toSec();
            geometry_msgs::Pose2D beforePos;
            while(RobotStatus!="end")
            {
                double secs =ros::Time::now().toSec();
                if(secs-beforetime>6)//2秒ごとに移動量のチェック
                {
                    //ロボットの移動距離の計算
                    getRobotPos();
                    double movementDistance=sqrt(pow((RobotPos.x-beforePos.x),2)+pow((RobotPos.y-beforePos.y),2));
                    if(movementDistance>1.4)
                    {
                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                    }
                    else
                    {
                        //通れなかった場合はストップ命令
                        controlCommand.data="stop";
                        pubTraceControl.publish(controlCommand);

                        //パス取得の準備
                        printeps_hsr_modules::PathGenerator pathGeneSrv;
                        pathGeneSrv.request.start = RobotPos;
                        pathGeneSrv.request.goal  = req.pose;
                        pathGeneSrv.request.dynamicObstacle.poses.push_back(wayPoint);
                        pathGeneSrv.request.dynamicObstacle.header.frame_id ="map";

                        //パスの取得とパブリッシュ
                        if(pathGene.call(pathGeneSrv))
                        {
                            ROS_INFO("Successed to get path");
                            //取得したpathのパブリッシュ
                            pubPath.publish(pathGeneSrv.response.path);
                            ros::Duration(0.3).sleep();
                            goalPoint.x     =req.pose.x;
                            goalPoint.y     =req.pose.y;
                            goalPoint.theta =req.pose.theta;
                            pubGoal.publish(goalPoint);     
            
                            //ロボットに動作開始の命令
                            std_msgs::String controlCommand;
                            controlCommand.data="restart";
                            pubTraceControl.publish(controlCommand);
                        }
                        else
                        {
                            ROS_ERROR("Failed to get path");
                            res.success=false;
                            return true;
                        }

                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                        please=false;
                    }   
                }
                else if(secs-beforetime>4)
                {
                    //2秒通れなかったら問いかけ
                    //ロボットの移動距離の計算
                    getRobotPos();
                    double movementDistance=sqrt(pow((RobotPos.x-beforePos.x),2)+pow((RobotPos.y-beforePos.y),2));

                    //cout<<movementDistance<<endl;
                    if(movementDistance<0.8)
                    {
                        if(please!=true)
                        {
                            //通れなかった場合は問いかけ
                            controlCommand.data="please";
                            pubTraceControl.publish(controlCommand);
                            please=true;
                        }
                    }
                    else
                    {
                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                        please=false;
                    }
                }
                ros::spinOnce();
                loop_rate.sleep();
            }
            
            res.success=true;
            return true;
        }
        else
        {
            ROS_ERROR("Failed to get path");
            res.success=false;
            return true;
        }
    }
    bool multimodalNavigation(printeps_hsr_modules::HsrMMNav::Request  &req,
                          printeps_hsr_modules::HsrMMNav::Response &res)
    {
        cout<<"=========multimodalPathPlanning Start========="<<endl;
        //openpose_Start
        std_msgs::String openposeCommand;
        openposeCommand.data="start";
        pubOpenposeStart.publish(openposeCommand);

        //openpose_kalmanfilter start
        geometry_msgs::Pose2D openposeFilterTarget;
        openposeFilterTarget = req.pose;
        pubOpenposeFilterStart.publish(openposeFilterTarget);

        //パス取得の準備
        printeps_hsr_modules::PathGenerator pathGeneSrv;
        pathGeneSrv.request.goal                            = req.pose;
        pathGeneSrv.request.dynamicObstacle.poses.clear();
        pathGeneSrv.request.dynamicObstacle.header.frame_id = "map";
        pathGeneSrv.request.multimodalPathplanning.data     = true;
        pathGeneSrv.request.voiceImportance                 = req.voiceImportance;
        //スタート地点の取得
        getRobotPos();
        
        pathGeneSrv.request.start = RobotPos;
        if(pathGene.call(pathGeneSrv))
        {
            pubPath.publish(pathGeneSrv.response.path);
            geometry_msgs::Pose2D goalPoint;
            goalPoint.x     =req.pose.x;
            goalPoint.y     =req.pose.y;
            goalPoint.theta =req.pose.theta;
            pubGoal.publish(goalPoint);
        }
        
        RobotStatus = "start";

        ros::Rate loop_rate(10);//10hz
        double beforetime           = ros::Time::now().toSec();
        double openposeStartTime    = ros::Time::now().toSec();
        bool please                 = false;
        bool replanning             = true;//パスの長さが短くなるまでは再計画を繰り返す
        bool avoidDynamicObstacle   = false;

        std_msgs::String controlCommand;
        controlCommand.data="start";
        pubTraceControl.publish(controlCommand);

        //ロボットの動作の監視
        geometry_msgs::Pose2D beforePos;
        beforePos=RobotPos;

        while(RobotStatus!="end")//パスの長さがみじかくなるまで
        {
            double secs =ros::Time::now().toSec();
            if(replanning)
            {
                //スタート地点の取得
                getRobotPos();
                pathGeneSrv.request.start = RobotPos;
                
                //パスの取得とパブリッシュ
                if(pathGene.call(pathGeneSrv))
                {
                    
                    ROS_INFO("Successed to get path");
                    //取得したpathのパブリッシュ
                    pubPath.publish(pathGeneSrv.response.path);
                    
                    double pathLength=pathGeneSrv.response.length.data;

                    //経路長の確認
                    if(pathLength<1)
                    {
                        cout<<"Replanning Stop"<<endl;
                        replanning=false;
                    }
                }
            }

            if(avoidDynamicObstacle)
            {
                if(secs-beforetime>6)//2秒ごとに移動量のチェック
                {
                    //ロボットの移動距離の計算
                    getRobotPos();
                    double movementDistance=sqrt(pow((RobotPos.x-beforePos.x),2)+pow((RobotPos.y-beforePos.y),2));
                    if(movementDistance>1.2)
                    {
                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                    }
                    else
                    {
                        //障害物の追加
                        pathGeneSrv.request.dynamicObstacle.poses.clear();
                        pathGeneSrv.request.dynamicObstacle.poses.push_back(wayPoint);
                        pathGeneSrv.request.dynamicObstacle.header.frame_id ="map";
                        std_msgs::String controlCommand;
                        controlCommand.data="restart";
                        pubTraceControl.publish(controlCommand);

                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                        please=false;
                    }   
                }
                else if(secs-beforetime>4)
                {
                    //2秒通れなかったら問いかけ
                    //ロボットの移動距離の計算
                    getRobotPos();
                    double movementDistance=sqrt(pow((RobotPos.x-beforePos.x),2)+pow((RobotPos.y-beforePos.y),2));
                    cout<<"Distance:"<<movementDistance<<endl;
                    if(movementDistance<0.8)
                    {
                        if(please!=true)
                        {
                            //通れなかった場合は問いかけ
                            std_msgs::String controlCommand;
                            controlCommand.data="please";
                            pubTraceControl.publish(controlCommand);
                            please=true;
                            cout<<"please"<<endl;
                        }
                    }
                    else
                    {
                        beforePos=RobotPos;
                        beforetime=ros::Time::now().toSec();
                        please=false;
                    }
                }
            }
            //cout<<"time:"<<secs-beforetime<<endl;
            ros::spinOnce();
            loop_rate.sleep();
        }

        cout<<"=========multimodalPathPlanning End========="<<endl;
        openposeCommand.data="end";
        pubOpenposeStart.publish(openposeCommand);
        res.success=true;
        return true;
    }

    void getStatus(const std_msgs::String msg)
    {
        RobotStatus=msg.data;
        cout<<"Received RobotStatus:"<< RobotStatus<<endl;
    }

    void getRobotPos()
    {
        tf::StampedTransform transform;
        try
        {
          tfListener.lookupTransform("/map", "/base_footprint", ros::Time(0), transform);
        }
        catch (tf::TransformException ex)
        {
          //ROS_ERROR("%s", ex.what());
        }

        double roll, pitch, yaw;
        tf::Vector3 vec, euler;
        tf::Quaternion quat;
        tf::Quaternion q(quat[0], quat[1], quat[2], quat[3]);
        tf::Matrix3x3 m(q);
        m.getRPY(roll,pitch,yaw);

        quat  = transform.getRotation();
        vec = transform.getOrigin();

        RobotPos.x     = (double)vec.x();
        RobotPos.y     = (double)vec.y();
        RobotPos.theta = yaw;
    }

    void getWayPoint(const geometry_msgs::PoseStamped msg)
    {
        wayPoint=msg.pose;
    }

};
int main(int argc, char **argv)
{
    ros::init(argc, argv, "hsrGlobalNavigation");
    ros::start(); 
    hsrGlobalNavigation hsrGlobalNavigation;
    ros::spin();
}