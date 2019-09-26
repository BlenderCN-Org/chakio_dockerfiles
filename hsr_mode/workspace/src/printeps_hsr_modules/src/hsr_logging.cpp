#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <pcl_ros/io/pcd_io.h>

#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/WrenchStamped.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/JointState.h>



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



#include <boost/thread/thread.hpp>
#include <pcl/common/common_headers.h>
#include <pcl/features/normal_3d.h>
#include <pcl/point_types.h>

#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>

#include "printeps_hsr_modules/HsrLog.h"


static struct termios init_tio;



std::stringstream foldername;



class HsrLogging
{
private:
  ros::NodeHandle _nh;
  ros::Subscriber  _sub_scan, _sub_wrist, _sub_imu, _sub_joint;
  ros::ServiceServer service;
  pcl::PointCloud<pcl::PointXYZRGB>
      input_cloud0, input_cloud1;
  pcl::PointCloud<pcl::PointXYZRGB> cloudview;
  tf::TransformListener tflistener;
  int save_count;

  bool LogIMU;
  bool LogLRF;
  bool LogWrist;
  bool LogJoint;
  bool LogTF;
  std::string LogMode;

  //struct timeval start, end;
  //int now;
  double start, end;
  int now;
  // pcl::visualization::CloudViewer viewer("aaa");
public:
  HsrLogging()
  {
    // subscribe ROS topics
    _sub_scan  = _nh.subscribe("/hsrb/base_scan", 5, &HsrLogging::saveLaser, this);
    ROS_INFO("Listening for incoming data on topic /hsrb/base_scan ...");
    _sub_wrist = _nh.subscribe("/hsrb/wrist_wrench/compensated", 5, &HsrLogging::saveWrist, this);
    ROS_INFO("Listening for incoming data on topic /hsrb/wrist_wrench/compensated ...");
    _sub_imu = _nh.subscribe("/hsrb/base_imu/data", 5, &HsrLogging::saveIMU, this);
    ROS_INFO("Listening for incoming data on topic /hsrb/base_imu/data ...");
    _sub_joint = _nh.subscribe("/hsrb/robot_state/joint_states", 5, &HsrLogging::saveJoint, this);
    ROS_INFO("Listening for incoming data on topic / hsrb / robot_state / joint_states ...");

    service = _nh.advertiseService("hsr_log", &HsrLogging::hsrlog,this);

    

    LogIMU    = false;
    LogLRF    = false;
    LogWrist  = false;
    LogJoint  = false;
    LogTF     = false;
  }
  ~HsrLogging() {}
  
  

 
  void saveLaser(const sensor_msgs::LaserScan::ConstPtr &msg)
  {
    if(LogLRF)
    {
      std::string data;

      std::stringstream ss;
      
     

      std::stringstream timename;
      //gettimeofday(&end, NULL);
      //now = (end.tv_sec - start.tv_sec) * 1000+(end.tv_usec - start.tv_usec) / 1000;
      end = ros::Time::now().toSec() * 1000;
      now = end - start;

      timename << now;
      data += timename.str();
      data+=(",");

      for (int i = 0; i < msg->ranges.size(); i++)
      {
        std::stringstream ss;
        ss << msg->ranges[i];
        std::string data2;
        data2 = ss.str();
        data += data2;
        //data.push_back('a');
        data += (",");
      }
      std::ofstream writingCSV;
      
      std::stringstream filename;
      filename << foldername.str() << "/Laser.csv";
      writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << data << std::endl;

      saveTF();
    }
  }

  void saveWrist(const geometry_msgs::WrenchStamped::ConstPtr &msg)
  {
    if (LogWrist)
    {
      std::string data;
      
      std::stringstream ss;
      std::stringstream timename;
      //gettimeofday(&end, NULL);
      //now = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000;
      end = ros::Time::now().toSec() * 1000;
      now = end - start;

      timename << now;
      data += timename.str();
      data += (",");

      ss << msg->wrench.force.x << "," << msg->wrench.force.y << "," << msg->wrench.force.z << "," << msg->wrench.torque.x << "," << msg->wrench.torque.y << "," << msg->wrench.torque.z;
      std::string data2;
      data += ss.str();
     
      std::ofstream writingCSV;
      std::stringstream filename;
      filename << foldername.str() << "/wrist.csv";
      writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << data << std::endl;
    }
  }
  void saveIMU(const sensor_msgs::Imu::ConstPtr & msg)
  {
    if (LogIMU)
    {
      std::string data;

      std::stringstream ss;
      std::stringstream timename;
      //gettimeofday(&end, NULL);
      //now = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000;
      end = ros::Time::now().toSec() * 1000;
      now = end - start;

      timename << now;
      data += timename.str();
      data += (",");

      ss << msg->orientation.x << "," << msg->orientation.y << "," << msg->orientation.z << "," << msg->orientation.w << "," << msg->angular_velocity.x << "," << msg->angular_velocity.y << "," << msg->angular_velocity.z << "," << msg->linear_acceleration.x << "," << msg->linear_acceleration.y << "," << msg->linear_acceleration.z;
      data += ss.str();
     
      std::ofstream writingCSV;
      
      std::stringstream filename;
      filename << foldername.str() << "/IMU.csv";
      writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << data << std::endl;
    }
  }

  void saveJoint(const sensor_msgs::JointState::ConstPtr &msg)
  {
    if (LogJoint)
    {
      
      std::string data;

      
      std::stringstream timename;
      //gettimeofday(&end, NULL);
      //now = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000;
      end = ros::Time::now().toSec() * 1000;
      now = end - start;

      timename << now;
      data += timename.str();
      data += (",");
      //base_roll_joint,base_r_drive_wheel_joint,base_l_drive_wheel_joint,base_r_passive_wheel_x_frame_joint,base_r_passive_wheel_y_frame_joint,base_r_passive_wheel_z_joint,base_l_passive_wheel_x_frame_joint,base_l_passive_wheel_y_frame_joint,base_l_passive_wheel_z_joint,torso_lift_joint,head_pan_joint,head_tilt_joint,arm_lift_joint,arm_flex_joint,arm_roll_joint,wrist_flex_joint,wrist_roll_joint,hand_motor_joint,hand_l_proximal_joint,hand_l_spring_proximal_joint,hand_l_mimic_distal_joint,hand_l_distal_joint,hand_r_proximal_joint,hand_r_spring_proximal_joint,hand_r_mimic_distal_joint,hand_r_distal_joint

      for (int j = 0; j < msg->name.size(); j++)
      {
        std::stringstream ss;
        ss << msg->position[j] << "," << msg->velocity[j] << "," << msg->effort[j]<<",";
        data += ss.str();
      }

      std::ofstream writingCSV;

      std::stringstream filename;
      filename << foldername.str() << "/Joint.csv";
      writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << data << std::endl;
      
    }
  }

  void saveTF()
  {
    int tflistNum = 6;
	  std::string tflist[tflistNum];
	  tflist[0] ="/base_footprint";
	  tflist[1] ="/arm_flex_link";
	  tflist[2] ="/arm_lift_link";
	  tflist[3] ="/arm_roll_link";
	  tflist[4] ="/hand_palm_link";
	  tflist[5] ="/head_rgbd_sensor_gazebo_frame";
    if (LogTF)
    {
        std::string data;

      std::stringstream ss;
      std::stringstream timename;
      //gettimeofday(&end, NULL);
      //now = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000;
      end = ros::Time::now().toSec() * 1000;
      now = end - start;

      timename << now;
      data += timename.str();
      data += (",");

      for (int i = 0; i < tflistNum;i++)
      {

        tf::StampedTransform transform;
        try
        {
          //tflistener.lookupTransform("/map", "/base_footprint", ros::Time(0), transform);
          tflistener.lookupTransform("/map", tflist[i], ros::Time(0), transform);
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
        ss << vec.x() << "," << vec.y() << "," << vec.z() << "," << roll << "," << pitch << "," << yaw << ",";

        data += ss.str();
      }
      std::ofstream writingCSV;

      std::stringstream filename;
      filename << foldername.str() << "/TF.csv";
      writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << data << std::endl;
    }
    
  }

  bool hsrlog(printeps_hsr_modules::HsrLog::Request& req,
              printeps_hsr_modules::HsrLog::Response& res)
  {
    if (req.log)
    {
      LogMode = req.mode;

      foldername.str("");                           // バッファをクリアする。
      foldername.clear(std::stringstream::goodbit); // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      time_t now = time(NULL);
      
      struct tm *pnow = localtime(&now);
      foldername << LogMode << "(" << pnow->tm_mon + 1 << "_" << pnow->tm_mday << "_" << pnow->tm_hour << "_" << pnow->tm_min << ")";
      mkdir(foldername.str().c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IXOTH | S_IXOTH);

      LogIMU = req.IMU;
      LogLRF = req.LRF;
      LogWrist = req.Wrist;
      LogJoint = req.Joint;
      LogTF = req.TF;
      //gettimeofday(&start, NULL);
      start = ros::Time::now().toSec() * 1000;
      std::cout << "start" << std::endl;
    }
    else
    {
      LogIMU = false;
      LogLRF = false;
      LogWrist = false;
      LogJoint = false;


      LogTF = false;
      std::cout << "end" << std::endl;
    }
    
    res.success = true;
    return true;
  }
};



int main(int argc, char **argv)
{
  ros::init(argc, argv, "hsr_logging");
 
  HsrLogging hsrlogging;
  
  ros::spin();
}
