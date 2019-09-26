#include  <ros/ros.h>
#include  <tf/transform_broadcaster.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "pepper_tf_broadcaster");
  ros::NodeHandle n;

  ros::Rate r(100);

  tf::TransformBroadcaster broadcaster;

  while(n.ok()){
    broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(0, 0, 0, 1),
          tf::Vector3(0.18, 0.0, 0.0)),//0.4273)),  // Front_LRS position
            ros::Time::now(),"base_footprint", "base_scan"));
    r.sleep();
  }
}
