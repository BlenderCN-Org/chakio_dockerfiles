#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <vector>
#include <sstream>
#include <string>

class arPoseServer
{
private:
    ros::NodeHandle                     _nh;
    tf::TransformBroadcaster            _br;
    ros::Timer timer                    = _nh.createTimer(ros::Duration(0.1), &arPoseServer::timerCallback,this);
    std::vector<tf::Vector3> armarker_positions;
    int markerNum = 1;

public:
    arPoseServer()
    {
        _nh.getParam("/arpose_server/markerNum", markerNum);
        armarker_positions.resize(markerNum);

        for(int markerIndex=0; markerIndex<markerNum; markerIndex++)
        {
            std::stringstream ssParamXName;
            std::stringstream ssParamYName;
            std::stringstream ssParamZName;
            ssParamXName << "/arpose_server/marker" << markerIndex << "_pos_x";
            ssParamYName << "/arpose_server/marker" << markerIndex << "_pos_y";
            ssParamZName << "/arpose_server/marker" << markerIndex << "_pos_z";
            double markerPosX=0;
            double markerPosY=0;
            double markerPosZ=0;

            _nh.getParam(ssParamXName.str(), markerPosX);
            _nh.getParam(ssParamYName.str(), markerPosY);
            _nh.getParam(ssParamZName.str(), markerPosZ);
            armarker_positions[markerIndex].setValue(markerPosX,markerPosY,markerPosZ);
            std::cout<<"x:"<<markerPosX<<", y:"<<markerPosY<<", z:"<<markerPosZ<<std::endl;
        }
    }
    void timerCallback(const ros::TimerEvent&)
    {
        this->broadcastPoses();
    }
    void broadcastPoses()
    {
        for(int armarkerIndex=0;armarkerIndex<armarker_positions.size();armarkerIndex++)
        {
            std::stringstream ssArmarkerName;
            ssArmarkerName << "ar_marker_" << armarkerIndex;
            tf::Transform transform;
            transform.setOrigin(armarker_positions[armarkerIndex]);
            tf::Quaternion q;
            q.setRPY(0, 0, 0);
            transform.setRotation(q);
            _br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "map",ssArmarkerName.str() ));
            ros::Duration(0.01).sleep();
        }
    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "arPose_server");
 
  arPoseServer _arPoseServer;
  
  ros::spin();
}