#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <pcl_ros/io/pcd_io.h>

#include "std_msgs/String.h"
#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/WrenchStamped.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseArray.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/JointState.h>

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
pcl::PointCloud<pcl::PointXYZ>::Ptr cloud11(new pcl::PointCloud<pcl::PointXYZ>);
class SetTarget
{
private:
    ros::NodeHandle _nh;
    tf::TransformListener tflistener;    //= new tf::TransformListener();
    ros::Publisher pubT = _nh.advertise<geometry_msgs::PoseStamped> ("pepper_target", 1);
    ros::Subscriber sub_path;
    vector< vector<double> >potential;
    vector< vector<double> >path;
    sensor_msgs::PointCloud2 TargetPCD,output2,pathPCD;//robot座標系の元となるロボットの位置姿勢情報格納用変数の作成
    double SearchRadius=1.2;
public:
    SetTarget()
    {
        sub_path = _nh.subscribe("/pepper_path",1,&SetTarget::getPath,this);
        ROS_INFO("Listening for incoming data on topic /path ...");

    }
    ~SetTarget(){}
    void getPath(const geometry_msgs::PoseArray &msg)
    {
        for (size_t i = 0; i < msg.poses.size(); i++)
        {
            vector<double> point;
            point.push_back(msg.poses[i].position.x); //X座標の移動
            point.push_back(msg.poses[i].position.y);
            point.push_back(msg.poses[i].orientation.x);
            point.push_back(msg.poses[i].orientation.y);
            point.push_back(msg.poses[i].orientation.z);
            point.push_back(msg.poses[i].orientation.w);
            path.push_back(point);

        }
        ROS_INFO("setTarget----Get New Path");
    }
    void searchTarget()
    {
        tf::StampedTransform transform;
        try
        {
          //tflistener.lookupTransform("/map", "/base_footprint", ros::Time(0), transform);
          tflistener.lookupTransform("/pepper01/map", "pepper01/base_footprint", ros::Time(0), transform);
        }
        catch (tf::TransformException ex)
        {
          ROS_ERROR("%s", ex.what());
          ros::Duration(1.0).sleep();
        }

        tf::Vector3 vec, euler;
        tf::Quaternion quat;
        double roll, pitch, yaw;
        vec = transform.getOrigin();
        quat  = transform.getRotation();
        tf::Quaternion q(quat[0], quat[1], quat[2], quat[3]);
        tf::Matrix3x3 m(q);
        m.getRPY(roll,pitch,yaw);
        double pos[2];
        pos[0]=vec.x();
        pos[1]=vec.y();
        //cout<<pos[0]<<"  "<<pos[1]<<endl;
        double Target[6];
        if(path.size()==0)
        {
            //cout<<"No Path"<<endl;
        }
        else
        {
            double maxRadius=0;
            double maxnum=-1;
            for (int i = 0; i < path.size(); i++)
            {
                double distance=sqrt(pow((pos[0]-path[i][0]),2)+pow((pos[1]-path[i][1]),2));
                if(distance<=SearchRadius)
                {
                    if(maxnum<i)
                    {
                        for(int j=0;j<6;j++)
                        {
                            Target[j]=path[i][j];
                        }
                        maxnum=i;
                    }
                }
            }
            if(maxnum==-1)
            {
                //cout<<"No Target"<<endl;
            }
            else
            {
                //cout<<"Target:"<<Target[0]<<"  "<<Target[1]<<endl;
                
                geometry_msgs::PoseStamped targetpose;
                targetpose.pose.position.x=Target[0];
                targetpose.pose.position.y=Target[1];
                targetpose.pose.position.z=0;
                targetpose.pose.orientation.x=Target[2];
                targetpose.pose.orientation.y=Target[3];
                targetpose.pose.orientation.z=Target[4];
                targetpose.pose.orientation.w=Target[5];

                targetpose.header.frame_id ="pepper01/map";
                pubT.publish(targetpose);
            }
            
        }

    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "setTarget");
 
  SetTarget settarget;
  ros::Rate loop_rate(100);
  
  while (ros::ok())
  {
    settarget.searchTarget();
    
    ros::spinOnce();
    loop_rate.sleep();
    
  }
  
}