#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

class cameraPoseServer
{
private:
    ros::NodeHandle                     _nh;
    tf::TransformBroadcaster            _br;
    ros::Timer timer                    = _nh.createTimer(ros::Duration(0.1), &cameraPoseServer::timerCallback,this);
    std::vector< tf::Transform > cameraPoses;
    std::stringstream cameraLinkName;
    std::string output_frame;
    std::string fileName;
    std::vector<double> cameraIndexes;
public:
    cameraPoseServer()
    {
        ros::NodeHandle _pnh("~");
        _pnh.getParam("output_frame", output_frame);
        fileName ="/catkin_ws/src/camerapose_server/cameraPose.csv";
        std::ifstream readingCSV(fileName.c_str());
        std::string oneLine;
        int lineIndex=0;
        while(std::getline(readingCSV,oneLine))
        {

            std::string tmp;
            tf::Vector3 position;
            double quaternionValue[4];
            std::istringstream stream(oneLine);
            int valueIndex=0;
            while(std::getline(stream,tmp,','))
            {
                switch(valueIndex)
                {
                    case 0:
                        cameraIndexes.push_back(std::stod(tmp));

                    case 1:
                        position.setX(std::stod(tmp));
                    case 2:
                        position.setY(std::stod(tmp));
                    case 3:
                        position.setZ(std::stod(tmp));

                    case 4:
                        quaternionValue[0] = std::stod(tmp);
                    case 5:
                        quaternionValue[1] = std::stod(tmp);
                    case 6:
                        quaternionValue[2] = std::stod(tmp);
                    case 7:
                        quaternionValue[3] = std::stod(tmp);
                }
                valueIndex++;
            }
            if(valueIndex>0)
            {
                tf::Quaternion quaternion(quaternionValue[0],quaternionValue[1],quaternionValue[2],quaternionValue[3]);
                tf::Transform cameraPose;
                cameraPose.setOrigin(position);
                cameraPose.setRotation(quaternion);
                cameraPoses.push_back(cameraPose);
                lineIndex++;
            }
        }
        for(int tfIndex=0;tfIndex<cameraPoses.size();tfIndex++)
        {
            std::cout<<"camera:"<<cameraIndexes[tfIndex]<<std::endl;
            std::cout<<"    Position"<<std::endl;
            std::cout<<"        x:"<<cameraPoses[tfIndex].getOrigin().getX()<<" y:"<<cameraPoses[tfIndex].getOrigin().getY()<<" z:"<<cameraPoses[tfIndex].getOrigin().getZ()<<std::endl;
            std::cout<<"    Quaternion"<<std::endl;
            std::cout<<"        x:"<<cameraPoses[tfIndex].getRotation().getAxis().x()<<" y:"<<cameraPoses[tfIndex].getRotation().getAxis().y()<<" z:"<< cameraPoses[tfIndex].getRotation().getAxis().z()<<" w:"<<cameraPoses[tfIndex].getRotation().getW()<<std::endl;
            std::cout<<std::endl;
        }
    }
    void timerCallback(const ros::TimerEvent&)
    {
        for(int cameraPoseIndex=0;cameraPoseIndex<cameraPoses.size();cameraPoseIndex++)
        {
            this->broadcastCameraPose(cameraPoses[cameraPoseIndex],cameraPoseIndex);
        }
    }
    void broadcastCameraPose(tf::Transform cameraPose,int cameraPoseIndex)
    {
        cameraLinkName.str("");
        cameraLinkName.clear(std::stringstream::goodbit);
        cameraLinkName << "/env_cam0"<<cameraIndexes[cameraPoseIndex]<<output_frame;
        _br.sendTransform(tf::StampedTransform(cameraPose, ros::Time::now(),"map",cameraLinkName.str()));
    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "cameraPose_Server");
 
  cameraPoseServer _cameraPoseServer;
  
  ros::spin();
}