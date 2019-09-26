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

#include "printeps_hsr_modules/HsrLogP.h"


static struct termios init_tio;
int pcdshow = 1;
pcl::visualization::CloudViewer viewer0("Cloud Viewer0");
pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud10(new pcl::PointCloud<pcl::PointXYZRGB>);
pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud11(new pcl::PointCloud<pcl::PointXYZRGB>);




std::stringstream foldername;
void centroid(pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud)
{
  Eigen::Vector4f xyz_centroid;
  pcl::compute3DCentroid(*cloud, xyz_centroid); //重心を計算

  for (size_t i = 0; i < cloud->points.size(); i++)
  {
    cloud->points[i].x = cloud->points[i].x - xyz_centroid[0]; //X座標の移動
    cloud->points[i].y = cloud->points[i].y - xyz_centroid[1]; //Y座標の移動
    cloud->points[i].z = cloud->points[i].z - xyz_centroid[2]; //Z座標の移動
  }
}
pcl::PointCloud<pcl::PointXYZRGB> rotation_x(pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud, double theta) ///rotate point cloud by Y axiz
{

  pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud_centroid(new pcl::PointCloud<pcl::PointXYZRGB>);
  cloud_centroid = cloud;

  //centroid(cloud_centroid);//点群の重心位置求めを（0,0,0）に移動する

  Eigen::Matrix4f rot_x;
  pcl::PointCloud<pcl::PointXYZRGB> cloud_out;
  cloud_out = *cloud;
  double theta_x = theta * 3.1415926 / 180.0; //角度の変換
  rot_x(0, 0) = 1.0;
  rot_x(1, 0) = 0.0;
  rot_x(2, 0) = 0.0;
  rot_x(3, 0) = 0.0;
  rot_x(0, 1) = 0.0;
  rot_x(1, 1) = cos(theta_x);
  rot_x(2, 1) = -sin(theta_x);
  rot_x(3, 1) = 0.0;
  rot_x(0, 2) = 0.0;
  rot_x(1, 2) = sin(theta_x);
  rot_x(2, 2) = cos(theta_x);
  rot_x(3, 2) = 0.0;
  rot_x(0, 3) = 0.0;
  rot_x(1, 3) = 0.0;
  rot_x(2, 3) = 0.0;
  rot_x(3, 3) = 1.0;

  for (size_t i = 0; i < cloud->points.size(); ++i)
  {
    cloud_out.points[i].x = rot_x(0, 0) * cloud->points[i].x + rot_x(0, 1) * cloud->points[i].y + rot_x(0, 2) * cloud->points[i].z + rot_x(0, 3) * 1;
    cloud_out.points[i].y = rot_x(1, 0) * cloud->points[i].x + rot_x(1, 1) * cloud->points[i].y + rot_x(1, 2) * cloud->points[i].z + rot_x(1, 3) * 1;
    cloud_out.points[i].z = rot_x(2, 0) * cloud->points[i].x + rot_x(2, 1) * cloud->points[i].y + rot_x(2, 2) * cloud->points[i].z + rot_x(2, 3) * 1;
  }

  return cloud_out;
}

pcl::PointCloud<pcl::PointXYZRGB> rotation_y(pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud, double theta) ///rotate point cloud by Y axiz
{

  pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud_centroid(new pcl::PointCloud<pcl::PointXYZRGB>);
  cloud_centroid = cloud;

  //centroid(cloud_centroid);//点群の重心位置求めを（0,0,0）に移動する

  Eigen::Matrix4f rot_y;
  pcl::PointCloud<pcl::PointXYZRGB> cloud_out;
  cloud_out = *cloud;
  double theta_y = theta * 3.1415926 / 180.0; //角度の変換
  rot_y(0, 0) = cos(theta_y);
  rot_y(1, 0) = 0.0;
  rot_y(2, 0) = sin(theta_y);
  rot_y(3, 0) = 0.0;
  rot_y(0, 1) = 0.0;
  rot_y(1, 1) = 1.0;
  rot_y(2, 1) = 0.0;
  rot_y(3, 1) = 0.0;
  rot_y(0, 2) = -sin(theta_y);
  rot_y(1, 2) = 0.0;
  rot_y(2, 2) = cos(theta_y);
  rot_y(3, 2) = 0.0;
  rot_y(0, 3) = 0.0;
  rot_y(1, 3) = 0.0;
  rot_y(2, 3) = 0.0;
  rot_y(3, 3) = 1.0;

  for (size_t i = 0; i < cloud->points.size(); ++i)
  {
    cloud_out.points[i].x = rot_y(0, 0) * cloud->points[i].x + rot_y(0, 1) * cloud->points[i].y + rot_y(0, 2) * cloud->points[i].z + rot_y(0, 3) * 1;
    cloud_out.points[i].y = rot_y(1, 0) * cloud->points[i].x + rot_y(1, 1) * cloud->points[i].y + rot_y(1, 2) * cloud->points[i].z + rot_y(1, 3) * 1;
    cloud_out.points[i].z = rot_y(2, 0) * cloud->points[i].x + rot_y(2, 1) * cloud->points[i].y + rot_y(2, 2) * cloud->points[i].z + rot_y(2, 3) * 1;
  }

  return cloud_out;
}

pcl::PointCloud<pcl::PointXYZRGB> rotation_z(pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud, double theta) ///rotate point cloud by Y axiz
{

  pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud_centroid(new pcl::PointCloud<pcl::PointXYZRGB>);
  cloud_centroid = cloud;

  // centroid(cloud_centroid);//点群の重心位置求めを（0,0,0）に移動する

  Eigen::Matrix4f rot_z;
  pcl::PointCloud<pcl::PointXYZRGB> cloud_out;
  cloud_out = *cloud;
  double theta_z = theta * 3.1415926 / 180.0; //角度の変換
  rot_z(0, 0) = cos(theta_z);
  rot_z(1, 0) = -sin(theta_z);
  rot_z(2, 0) = 0.0;
  rot_z(3, 0) = 0.0;
  rot_z(0, 1) = sin(theta_z);
  rot_z(1, 1) = cos(theta_z);
  rot_z(2, 1) = 0.0;
  rot_z(3, 1) = 0.0;
  rot_z(0, 2) = 0.0;
  rot_z(1, 2) = 0.0;
  rot_z(2, 2) = 1.0;
  rot_z(3, 2) = 0.0;
  rot_z(0, 3) = 0.0;
  rot_z(1, 3) = 0.0;
  rot_z(2, 3) = 0.0;
  rot_z(3, 3) = 1.0;

  for (size_t i = 0; i < cloud->points.size(); ++i)
  {
    cloud_out.points[i].x = rot_z(0, 0) * cloud->points[i].x + rot_z(0, 1) * cloud->points[i].y + rot_z(0, 2) * cloud->points[i].z + rot_z(0, 3) * 1;
    cloud_out.points[i].y = rot_z(1, 0) * cloud->points[i].x + rot_z(1, 1) * cloud->points[i].y + rot_z(1, 2) * cloud->points[i].z + rot_z(1, 3) * 1;
    cloud_out.points[i].z = rot_z(2, 0) * cloud->points[i].x + rot_z(2, 1) * cloud->points[i].y + rot_z(2, 2) * cloud->points[i].z + rot_z(2, 3) * 1;
  }

  return cloud_out;
}

class HsrLoggingP
{
private:
  ros::NodeHandle _nh;
  ros::Subscriber _sub_pcd;
  ros::ServiceServer service;
  pcl::PointCloud<pcl::PointXYZRGB>
      input_cloud0, input_cloud1;
  pcl::PointCloud<pcl::PointXYZRGB> cloudview;
  
  bool LogPCD;
  
  std::string LogMode;

  //struct timeval start, end;
  //int now;
  double start, end;
  int now;
  // pcl::visualization::CloudViewer viewer("aaa");
public:
  HsrLoggingP()
  {
    // subscribe ROS topics

    _sub_pcd   = _nh.subscribe("/hsrb/head_rgbd_sensor/depth_registered/rectified_points", 1, &HsrLoggingP::savePCD, this);
    ROS_INFO("Listening for incoming data on topic /hsrb/head_rgbd_sensor/depth_registered/rectified_points ...");
   
    service = _nh.advertiseService("hsr_log_p", &HsrLoggingP::hsrlog,this);

    

    LogPCD    = false;
   
  }
  ~HsrLoggingP() {}
  
  

  // get points
  void savePCD(const sensor_msgs::PointCloud2ConstPtr &cloud1)
  {
    if(LogPCD)
    {
      if ((cloud1->width * cloud1->height) == 0)
        return;
      pcl::fromROSMsg(*cloud1, input_cloud1);

      pcl::fromROSMsg(*cloud1, *cloud11);
      *cloud11 = rotation_z(cloud11, 180.0); //回転
      *cloud11 = rotation_y(cloud11, 180.0); //回転
  
      viewer0.showCloud(cloud11);
    

      std::stringstream timename;
      //gettimeofday(&end, NULL);
      end = ros::Time::now().toSec()*1000;
      now = end - start;
      timename << now;

      std::stringstream filename3;
      filename3 << "/" << timename.str() 
                << ".pcd";

      std::stringstream filename;
      filename << foldername.str() << filename3.str();
      
      pcl::io::savePCDFileBinary(filename.str(), *cloud11);
    }
  }
  

  bool hsrlog(printeps_hsr_modules::HsrLogP::Request& req,
              printeps_hsr_modules::HsrLogP::Response& res)
  {
    if (req.log)
    {
      LogMode = req.mode;

      foldername.str("");                           // バッファをクリアする。
      foldername.clear(std::stringstream::goodbit); // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      time_t now = time(NULL);
      
      struct tm *pnow = localtime(&now);
      foldername << LogMode << "(" << pnow->tm_mon + 1 << "_" << pnow->tm_mday << "_" << pnow->tm_hour << "_" << pnow->tm_min << ")_PCD";
      mkdir(foldername.str().c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IXOTH | S_IXOTH);

      LogPCD = req.PCD;
      
      //gettimeofday(&start, NULL);
      start = ros::Time::now().toSec() * 1000;
      std::cout << "start" << std::endl;
    }
    else
    {
      LogPCD = false;
     
      std::cout << "end" << std::endl;
    }
    
    res.success = true;
    return true;
  }
};



int main(int argc, char **argv)
{
  ros::init(argc, argv, "hsr_logging_p");
 
  HsrLoggingP hsrloggingp;
  
  ros::spin();
}