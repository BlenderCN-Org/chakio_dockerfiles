#include  <ros/ros.h>
#include  <tf/transform_broadcaster.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "pepper_tf_broadcaster");
  ros::NodeHandle n;

  ros::Rate r(100);

  tf::TransformBroadcaster  map2_broadcaster;
  tf::TransformBroadcaster  odom2_broadcaster;
  tf::TransformBroadcaster  base_scan_broadcaster;

  while(n.ok()){
    map2_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, 0, 1),
          tf::Vector3(0.0, 0.0, 0.0)),        // map2 = odom
            ros::Time::now(),"odom", "map2"));

    odom2_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, 0, 1),
          tf::Vector3(0.0, 0.0, 0.0)),        // odom2 = base_footprint
            ros::Time::now(),"base_footprint", "odom2"));

    base_scan_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, 0, 1),
          tf::Vector3(0.18, 0.0, 0.0)),//0.4273)),  // Front_LRS position
            ros::Time::now(),"base_footprint", "base_scan"));
    r.sleep();
  }
}
