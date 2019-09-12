#include <string>
#include "ros/ros.h"
#include "sensor_msgs/PointCloud2.h"
#include "tf/transform_listener.h"
#include "pcl_ros/transforms.h"

//==========================================================================================================//
//                                                   Class                                                  //
//==========================================================================================================//
class Pcd_transformer
{
private:
  ros::NodeHandle nh;

public:
  // メンバ関数のプロトタイプ宣言
  Pcd_transformer();
  sensor_msgs::PointCloud2 pcd_receive(const sensor_msgs::PointCloud2 &);
  void pcd_publish(const sensor_msgs::PointCloud2 &);
  void callback(const sensor_msgs::PointCloud2 &);

  // メンバ変数
  tf::StampedTransform transform;
  tf::TransformListener listener;
  ros::Publisher pub;
  ros::Subscriber sub;
  std::string camera_index;
};
// メンバ関数の定義
Pcd_transformer::Pcd_transformer()
{
  ros::NodeHandle pnh("~");
  pnh.getParam("camera_name", camera_index);
  pub = nh.advertise<sensor_msgs::PointCloud2>("/" + camera_index + "/depth_registered/transformed_points", 1);
  sub = nh.subscribe("/" + camera_index + "/depth_registered/points", 1, &Pcd_transformer::callback, this);
}

sensor_msgs::PointCloud2 Pcd_transformer::pcd_receive(const sensor_msgs::PointCloud2 &_msg)
{
  sensor_msgs::PointCloud2 transformed_msg;
  pcl_ros::transformPointCloud("/map", transform, _msg, transformed_msg);
  return transformed_msg;
}

void Pcd_transformer::pcd_publish(const sensor_msgs::PointCloud2 &_msg)
{
  pub.publish(_msg);
}

void Pcd_transformer::callback(const sensor_msgs::PointCloud2 &_msg)
{
  pcd_publish(pcd_receive(_msg));
}

//===========================================================================================================//
//                                               Main Function                                               //
//===========================================================================================================//
int main(int argc, char **argv)
{
  ros::init(argc, argv, "icp_matching_client");

  Pcd_transformer _pcd_transformer; 
  
  while (ros::ok())
  {
    try
    {
      _pcd_transformer.listener.lookupTransform("/map", "/" + _pcd_transformer.camera_index + "/camera_link", ros::Time(0), _pcd_transformer.transform);
      ROS_INFO("I got a transform!");
      break;
    }
    catch (tf::TransformException ex)
    {
      ROS_ERROR("%s", ex.what());
      ros::Duration(1.0).sleep();
    }
  }

  ros::spin();

  return 0;
}