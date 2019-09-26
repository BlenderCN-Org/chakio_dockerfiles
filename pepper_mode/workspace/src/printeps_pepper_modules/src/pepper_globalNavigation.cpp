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

#include "printeps_pepper_modules/PepperNav.h"
#include "printeps_pepper_modules/PathGenerator.h"

class pepperGlobalNavigation
{
private:
    ros::NodeHandle       _nh;
    tf::TransformListener tfListener;
    ros::ServiceServer    globalNav;
    ros::ServiceClient    pathGene;
    ros::Publisher        pubPotential;
    ros::Publisher        pubPath;
    ros::Publisher        pubTraceControl;
    ros::Publisher        goal_pub;
    ros::Subscriber       subTraceStatus;
    ros::Subscriber       subWayPoint;
    

    geometry_msgs::Pose2D RobotPos;
    std::string RobotStatus;
    geometry_msgs::Pose wayPoint;
    geometry_msgs::Pose2D goal_pose;

public:
    pepperGlobalNavigation()
    {
        //initializing
        ROS_INFO("====================pepper_globalNavigation====================");
        globalNav       = _nh.advertiseService("pepper01/pepper_navigation",&pepperGlobalNavigation::globalNavigation,this);
        pathGene        = _nh.serviceClient<printeps_pepper_modules::PathGenerator>("pepper_pathGenerator");
        pubPotential    = _nh.advertise<sensor_msgs::PointCloud2> ("/pepper_obstaclePotential", 1);
        pubPath         = _nh.advertise<geometry_msgs::PoseArray> ("/pepper_path", 1);
        pubTraceControl = _nh.advertise<std_msgs::String> ("/pepper_traceControl", 5);
        goal_pub        = _nh.advertise<geometry_msgs::Pose2D> ("/goal_pose",2);
        subTraceStatus  = _nh.subscribe("/pepper_traceStatus",1,&pepperGlobalNavigation::getStatus,this);
        subWayPoint     = _nh.subscribe("/pepper_target",1,&pepperGlobalNavigation::getWayPoint,this);
        ROS_INFO("Initializing End");
    }
    bool globalNavigation(printeps_pepper_modules::PepperNav::Request  &req,
                          printeps_pepper_modules::PepperNav::Response &res)
    {
        //スタート地点の取得
        getRobotPos();

        //パス取得の準備
        printeps_pepper_modules::PathGenerator pathGeneSrv;
        pathGeneSrv.request.start = RobotPos;
        pathGeneSrv.request.goal  = req.pose;
        pathGeneSrv.request.dynamicObstacle.poses.clear();
        pathGeneSrv.request.dynamicObstacle.header.frame_id ="map";
        cout<<"パスの準備なの？"<<RobotPos.x<<","<<RobotPos.y<<endl;
        cout<< "ゴールの位置"<<req.pose.x << req.pose.y << req.pose.theta<< endl;
        goal_pose.x = req.pose.x;
        goal_pose.y = req.pose.y;
        goal_pose.theta = req.pose.theta;
        goal_pub.publish(goal_pose);

        //パスの取得とパブリッシュ
        if(pathGene.call(pathGeneSrv))
        {

            ROS_INFO("Successed to get path");
            //取得したpathのパブリッシュ
            pubPath.publish(pathGeneSrv.response.path);
            ros::Duration(0.3).sleep();
            
            
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
                    if(movementDistance>0.5)
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
                        printeps_pepper_modules::PathGenerator pathGeneSrv;
                        pathGeneSrv.request.start = RobotPos;
                        pathGeneSrv.request.goal  = req.pose;

                        /*
                        goal_pose.x = req.pose.x;
                        goal_pose.y = req.pose.y;
                        goal_pose.theta = req.pose.theta;
                        cout<< 'ゴールの位置'<<goal_pose.x << goal_pose.y << goal_pose.theta<< endl;
                        goal_pub.publish(goal_pose);
                        */
                       


                        pathGeneSrv.request.dynamicObstacle.poses.push_back(wayPoint);
                        pathGeneSrv.request.dynamicObstacle.header.frame_id ="pepper01/map";

                        //パスの取得とパブリッシュ
                        if(pathGene.call(pathGeneSrv))
                        {
                            ROS_INFO("Successed to get path");
                            //取得したpathのパブリッシュ
                            pubPath.publish(pathGeneSrv.response.path);
                            ros::Duration(0.3).sleep();
            
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
                else if(secs-beforetime>3)
                {
                    //2秒通れなかったら問いかけ
                    //ロボットの移動距離の計算
                    getRobotPos();
                    double movementDistance=sqrt(pow((RobotPos.x-beforePos.x),2)+pow((RobotPos.y-beforePos.y),2));
                    if(movementDistance<0.3)
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

    void getStatus(const std_msgs::String msg)
    {
        RobotStatus=msg.data;
    }

    void getRobotPos()
    {
        tf::StampedTransform transform;
        try
        {
          tfListener.lookupTransform("/map", "/pepper01/base_footprint", ros::Time(0), transform);
        }
        catch (tf::TransformException ex)
        {
          ROS_ERROR("%s", ex.what());
          ros::Duration(1.0).sleep();
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
    ros::init(argc, argv, "pepperGlobalNavigation");
    ros::start(); 
    pepperGlobalNavigation pepperGlobalNavigation;
    ros::spin();
}