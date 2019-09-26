#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <pcl_ros/io/pcd_io.h>

#include "std_msgs/String.h"
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

using namespace std;

static struct termios init_tio;
int pcdshow = 1;
//pcl::visualization::CloudViewer viewer1("Cloud Viewer1");
pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud11(new pcl::PointCloud<pcl::PointXYZRGB>);

//pcl::visualization::CloudViewer viewer2("Cloud Viewer2");
pcl::PointCloud<pcl::PointXYZRGB>::Ptr cloud21(new pcl::PointCloud<pcl::PointXYZRGB>);


vector<string> split(const string &str, char sep)
{
	vector<string> v;
	stringstream ss(str);
	string buffer;
	while (getline(ss, buffer, sep)) {
		v.push_back(buffer);
	}
	return v;
}
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

class JetsonPcdLogging
{
private:
  ros::NodeHandle _nh;
  ros::Subscriber _sub_pcd1,_sub_pcd2,_sub_im1,_sub_im2,_sub_loghandover;
  ros::ServiceServer service;
  pcl::PointCloud<pcl::PointXYZRGB>input_cloud0, input_cloud1;
  pcl::PointCloud<pcl::PointXYZRGB> cloudview;
  
  bool LogPCD;
  
  std::string LogMode;

  //struct timeval start, end;
  //int now;
  double start, end;
  int now;

  bool logging=false;
  int frame=0;


  stringstream AbsolutePath,DateName,FolderName,Pcd1Path,Pcd2Path,FileName1,FileName2;
  string SerialFolderName;
  ros::Timer timerR = _nh.createTimer(ros::Duration(0.066), &JetsonPcdLogging::Writing, this);
  // pcl::visualization::CloudViewer viewer("aaa");
  
  sensor_msgs::ImageConstPtr Image_ptr1,Image_ptr2;
public:
  
  JetsonPcdLogging()
  {
    //setting path
    AbsolutePath<<"/home/ytnpc2017c/walk_pcd_data";

    // subscribe ROS topics
    _sub_pcd1         =   _nh.subscribe("/camera1/depth_registered/points", 1, &JetsonPcdLogging::savePCD1, this);
    ROS_INFO("Listening for incoming data on topic /camera1/depth_registered/points ...");

    _sub_pcd2         =   _nh.subscribe("/camera2/depth_registered/points", 1, &JetsonPcdLogging::savePCD2, this);
    ROS_INFO("Listening for incoming data on topic /camera2/depth_registered/points ...");

    _sub_im1          =   _nh.subscribe ("/camera1/rgb/image_color", 1,  &JetsonPcdLogging::saveIMAGE1, this);
    ROS_INFO ("Listening for incoming data on topic /camera1/rgb/image_color ..." );

    _sub_im2          =   _nh.subscribe ("/camera2/rgb/image_color", 1,  &JetsonPcdLogging::saveIMAGE2, this);
    ROS_INFO ("Listening for incoming data on topic /camera2/rgb/image_color ..." );
    
	  _sub_loghandover  =   _nh.subscribe("/handover", 1000, &JetsonPcdLogging::handoverCallback , this);
	  ROS_INFO("Listening for incoming data on topic /handover ...");
   
    

    start = ros::Time::now().toSec()*1000;

    LogPCD    = false;
   
  }
  ~JetsonPcdLogging() {}
  
  

  // get points//とりあえず格納
  void savePCD1(const sensor_msgs::PointCloud2ConstPtr &cloud1)
  {
    if(logging)
    {
      if ((cloud1->width * cloud1->height) == 0)
        return;
      pcl::fromROSMsg(*cloud1, *cloud11);
      *cloud11 = rotation_z(cloud11, 180.0); //回転
      *cloud11 = rotation_y(cloud11, 180.0); //回転
    }
  }
  void savePCD2(const sensor_msgs::PointCloud2ConstPtr &cloud1)
  {
    if(logging)
    {
      if ((cloud1->width * cloud1->height) == 0)
        return;

      pcl::fromROSMsg(*cloud1, *cloud21);
      *cloud21 = rotation_z(cloud21, 180.0); //回転
      *cloud21 = rotation_y(cloud21, 180.0); //回転
    }
  }

  // get image//とりあえず格納
  void saveIMAGE1( const sensor_msgs::ImageConstPtr &msg )
  {
    if(logging)
    {
      Image_ptr1=msg;
      /*cv::Mat color_img1;
      cv_ptr1 = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);*/
      //* show color img
      //color_img1 = cv_ptr->image;

    }
  }
  void saveIMAGE2( const sensor_msgs::ImageConstPtr &msg )
  {
    if(logging)
    {
      Image_ptr2=msg;
      /*cv::Mat color_img2;
      cv_ptr2 = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);*/
      //* show color img
      //color_img2 = cv_ptr->image;
    }
  }
  


  void handoverCallback(const std_msgs::String::ConstPtr &msg)
  {
	  string receiveData = msg->data;
	  vector<string>receiveDatas = split(receiveData, ',');//0:start or stop /1:pick or place /2:parameterMode /3 
	  if (receiveDatas[0] == "start")
	  {
      cout<<"start"<<endl;
      logging = true;
      //バッファクリア
      FolderName.str("");                           // バッファをクリアする。
      FolderName.clear(std::stringstream::goodbit); // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      DateName.str("");                             // バッファをクリアする。
		  DateName.clear(std::stringstream::goodbit);   // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      Pcd1Path.str("");                             // バッファをクリアする。
      Pcd1Path.clear(std::stringstream::goodbit);   // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      Pcd2Path.str("");                             // バッファをクリアする。
		  Pcd2Path.clear(std::stringstream::goodbit);   // ストリームの状態をクリアする。この行がないと意図通りに動作しない
      
      //folder作成
      cout<<"open folder"<<endl;
      //まず日にちのフォルダ作成
		  time_t now = time(NULL);
      struct tm *pnow = localtime(&now);
		  DateName <<"/"<< std::setfill('0') << std::setw(2) << pnow->tm_mon + 1 << "_" << std::setfill('0') << std::setw(2) << pnow->tm_mday << "_" << std::setfill('0') << std::setw(2) << pnow->tm_hour << "_" << std::setfill('0') << std::setw(2) << pnow->tm_min << "_" << std::setfill('0') << std::setw(2) << pnow->tm_sec;
		  FolderName << AbsolutePath.str() << DateName.str();
      mkdir(FolderName.str().c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IXOTH | S_IXOTH);
      //次にPCD1,PCD2のフォルダ作成
      cout<<"open PCD1,PCD2"<<endl;
      Pcd1Path << FolderName.str()<<"/PCD1";
      mkdir(Pcd1Path.str().c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IXOTH | S_IXOTH);
      Pcd2Path << FolderName.str()<<"/PCD2";
      mkdir(Pcd2Path.str().c_str(), S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IXOTH | S_IXOTH);
      
      //folderinfo書き込み
      cout<<"open folderlist"<<endl;
		  ofstream writingInfo;
		  stringstream filename;
      filename << AbsolutePath.str() << "/folderlist.csv";
      ofstream writingCSV;
		  writingCSV.open(filename.str().c_str(), std::ios::app);
      writingCSV << DateName.str()<<endl;//<<receiveDatas[1]<<receiveDatas[2] << endl;

      //frame数の初期化
      frame=0;
      //timerの初期化
		  start = ros::Time::now().toSec()*1000;
	  }
	  else
	  {
		  logging = false;
	  }
  }
  void Writing(const ros::TimerEvent &event)
  {
    
	  if (logging)
	  {
      if(cloud11->size()>0&&cloud21->size()>0)
      {
        //cout<<"writing"<<endl;
        //cout<<cloud11->size()<<endl;
        //cout<<cloud21->size()<<endl;
        
        //バッファクリア
        FileName1.str("");                             // バッファをクリアする。
        FileName1.clear(std::stringstream::goodbit);   // ストリームの状態をクリアする。この行がないと意図通りに動作しない
        FileName2.str("");                             // バッファをクリアする。
		    FileName2.clear(std::stringstream::goodbit);   // ストリームの状態をクリアする。この行がないと意図通りに動作しない

        //時刻の計算
		    end = ros::Time::now().toSec() * 1000;
		    now = end - start;
		    stringstream timename;
		    timename << (int)now;

        //PCDの書き出し
		    stringstream FileName1, FileName2;
		    FileName1 << Pcd1Path.str()   << "/"<< std::setfill('0') << std::setw(4) << frame << ".pcd";
		    pcl::io::savePCDFileBinary(FileName1.str(), *cloud11);
		    FileName2 << Pcd2Path.str()   << "/"<< std::setfill('0') << std::setw(4) << frame << ".pcd";
        pcl::io::savePCDFileBinary(FileName2.str(), *cloud21);

        //PCDの書き出し
        //cv::Mat color_img1,color_img2;
        /*stringstream ImageName1, ImageName2;
        cv_bridge::CvImagePtr cv_ptr1,cv_ptr2;

        cv_ptr1 = cv_bridge::toCvCopy(Image_ptr1);
        cv_ptr2 = cv_bridge::toCvCopy(Image_ptr2);
    

        /*ImageName1 << Pcd1Path.str()   << "/"<< std::setfill('0') << std::setw(4) << frame << ".pcd";
        cv::imwrite( ImageNamme1.str(), cv_ptr1->image );
        ImageName2 << Pcd2Path.str()   << "/"<< std::setfill('0') << std::setw(4) << frame << ".pcd";
        cv::imwrite( ImageName2.str(), cv_ptr2->image );*/

        //timedataの書き込み
        ofstream writingCSV;
        stringstream filename;
        filename << FolderName.str() << "/timedata.csv";
		    writingCSV.open(filename.str().c_str(), ios::app);
		    writingCSV << timename.str() << endl;
		    frame++;
      }

    }
  }
};



int main(int argc, char **argv)
{
  ros::init(argc, argv, "jetson_pcd_logging");
 
  JetsonPcdLogging jetsonpcdlogging;
  
  ros::spin();
}