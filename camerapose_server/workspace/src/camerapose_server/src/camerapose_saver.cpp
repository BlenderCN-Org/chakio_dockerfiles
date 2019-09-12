#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <vector>
#include <algorithm>
#include <fstream>
#include <sstream>
#include <string>
#include <stdio.h>
class cameraPoseSaver
{
private:
    ros::NodeHandle                     _nh;
    tf::TransformListener               _ls;
    tf::Transform cameraPose;
    std::vector< std::vector < tf::Transform > > cameraPoseSamples;
    std::vector< std::vector < tf::Transform > > availableCameraPoseSamples;
    ros::Timer timer;
    std::vector< int >sampleCounters;
    std::vector< tf::Transform >averageCameraPoses;
    std::vector< tf::Transform >improvedAverageCameraPoses;
    int cameraNum = 1;
    int sampleNum = 100;
    double samplingTime = 0.3;
    double distanceThreshold = 0.5;
    std::string fileName;
public:
    cameraPoseSaver()
    {
        _nh.getParam("/camerapose_saver/cameraNum", cameraNum);
        _nh.getParam("/camerapose_saver/sampleNum", sampleNum);
        _nh.getParam("/camerapose_saver/samplingTime", samplingTime);
        _nh.getParam("/camerapose_saver/distanceThreshold", distanceThreshold);

        averageCameraPoses.resize(cameraNum);
        improvedAverageCameraPoses.resize(cameraNum);
        sampleCounters.resize(cameraNum);
        cameraPoseSamples.resize(cameraNum);
        availableCameraPoseSamples.resize(cameraNum);
        
        fileName ="/catkin_ws/src/camerapose_server/cameraPose.csv";
        timer = _nh.createTimer(ros::Duration(samplingTime), &cameraPoseSaver::timerCallback,this);
        
    }
    void getValidPose()
    {
        for(int cameraIndex=0;cameraIndex<cameraNum;cameraIndex++)
        {
            for(int poseIndex=0; poseIndex<cameraPoseSamples[cameraIndex].size(); poseIndex++)
            {
                //std::cout<<"getValidPose cam:"<<cameraIndex<<"poseIndex:"<<poseIndex<<std::endl;
                if(this->getTransformsDistance(averageCameraPoses[cameraIndex], cameraPoseSamples[cameraIndex][poseIndex])<distanceThreshold)
                {
                    availableCameraPoseSamples[cameraIndex].push_back(cameraPoseSamples[cameraIndex][poseIndex]);
                }
            }
        }
    }
    void timerCallback(const ros::TimerEvent&)
    {
        for(int cameraIndex=0;cameraIndex<cameraNum;cameraIndex++)
        {
            if(this->getCameraPose(cameraIndex))
            {
                this->updateAverage(cameraIndex);
                sampleCounters[cameraIndex]++;
            }
        }
        if(*std::min_element(sampleCounters.begin(),sampleCounters.end())==sampleNum)
        {
            this->getValidPose();
            this->getAverages();
            this->savePoses();
        }
        else if (*std::min_element(sampleCounters.begin(),sampleCounters.end())<sampleNum)
        {
            std::cout<<"calibrating now! sample:"<<*std::min_element(sampleCounters.begin(),sampleCounters.end())<<"/"<<sampleNum<<std::endl;
        }
        
    }
    bool getCameraPose(int cameraIndex)
    {
        std::stringstream cameraLinkName;
        cameraLinkName << "/env_cam0"<<cameraIndex<<"/camera_link";

        tf::StampedTransform tfFromMapToCamera;
        try{
            _ls.lookupTransform( "map",  cameraLinkName.str(),ros::Time(0), tfFromMapToCamera);
            cameraPose.setOrigin(tfFromMapToCamera.getOrigin());
            cameraPose.setRotation(tfFromMapToCamera.getRotation());
            return true;
        }
        catch (tf::TransformException ex){
            //ROS_ERROR("%s",ex.what());
            return false;
        }
    }
    double getTransformsDistance(tf::Transform tf1,tf::Transform tf2)
    {
        return tf1.getOrigin().distance(tf2.getOrigin());
    }
    void getAverages()
    {
        for(int cameraIndex=0;cameraIndex<cameraNum;cameraIndex++)
        {
            improvedAverageCameraPoses[cameraIndex] = averageCameraPoses[cameraIndex];
            for(int poseIndex=0; poseIndex<availableCameraPoseSamples[cameraIndex].size(); poseIndex++)
            {
                //std::cout<<"getAverages cam:"<<cameraIndex<<"poseIndex:"<<poseIndex<<std::endl;
                tf::Transform averagePose = improvedAverageCameraPoses[cameraIndex];
                tf::Transform inputPose = availableCameraPoseSamples[cameraIndex][poseIndex];
                //weighted average
                
                tf::Vector3 averagePosition = averagePose.getOrigin();
                tf::Vector3 inputPosition = inputPose.getOrigin();
                averagePosition = averagePosition * (poseIndex/(poseIndex+1.0)) + inputPosition * (1.0/(poseIndex+1));
                
                tf::Quaternion averageQuaternion = averagePose.getRotation();
                tf::Quaternion inputQuaternion = inputPose.getRotation();
                averageQuaternion = averageQuaternion.slerp(inputQuaternion,1.0/(poseIndex+1));

                improvedAverageCameraPoses[cameraIndex].setOrigin(averagePosition);
                improvedAverageCameraPoses[cameraIndex].setRotation(averageQuaternion);
            }
        }
    }
    void updateAverage(int cameraIndex)
    {
        if(sampleCounters[cameraIndex]<sampleNum)
        {
            tf::Transform averagePose = averageCameraPoses[cameraIndex];
            tf::Transform inputPose = cameraPose;
            cameraPoseSamples[cameraIndex].push_back(cameraPose);
            //weighted average
            
            tf::Vector3 averagePosition = averagePose.getOrigin();
            tf::Vector3 inputPosition = inputPose.getOrigin();
            averagePosition = averagePosition * (sampleCounters[cameraIndex]/(sampleCounters[cameraIndex]+1.0)) + inputPosition * (1.0/(sampleCounters[cameraIndex]+1));
            
            tf::Quaternion averageQuaternion = averagePose.getRotation();
            tf::Quaternion inputQuaternion = inputPose.getRotation();
            averageQuaternion = averageQuaternion.slerp(inputQuaternion,1.0/(sampleCounters[cameraIndex]+1));

            /*
            std::cout<<"Camera:"<<cameraIndex<<std::endl;
            std::cout<<"    input"<<std::endl;
            std::cout<<"        x:"<<inputPosition.getX()<<" y:"<<inputPosition.getY()<<" z:"<<inputPosition.getZ()<<std::endl;
            std::cout<<"        x:"<< inputQuaternion.getAxis().x()<<" y:"<< inputQuaternion.getAxis().y()<<" z:"<< inputQuaternion.getAxis().z()<<" w:"<< inputQuaternion.getW()<<std::endl;


            std::cout<<"    average"<<std::endl;
            std::cout<<"        x:"<<averagePosition.getX()<<" y:"<<averagePosition.getY()<<" z:"<<averagePosition.getZ()<<std::endl;
            std::cout<<"        x:"<< averageQuaternion.getAxis().x()<<" y:"<< averageQuaternion.getAxis().y()<<" z:"<< averageQuaternion.getAxis().z()<<" w:"<< averageQuaternion.getW()<<std::endl;
            */
            averageCameraPoses[cameraIndex].setOrigin(averagePosition);
            averageCameraPoses[cameraIndex].setRotation(averageQuaternion);
        }
    }
    void savePoses()
    {
        std::string data;
        for(int cameraIndex=0;cameraIndex<cameraNum;cameraIndex++)
        {
            std::stringstream ssData;

            tf::Transform averagePose = improvedAverageCameraPoses[cameraIndex];
            tf::Vector3 averagePosition = averagePose.getOrigin();
            tf::Quaternion averageQuaternion = averagePose.getRotation();

            // CameraNum
            ssData << cameraIndex<<",";
            // Position
            ssData << averagePosition.getX()<<","<<averagePosition.getY()<<","<<averagePosition.getZ()<<",";
            //Quaternion
            ssData << averageQuaternion.getAxis().x()<<","<< averageQuaternion.getAxis().y()<<","<< averageQuaternion.getAxis().z()<<","<< averageQuaternion.getW()<<std::endl;

            //add Data
            data += ssData.str();
        }
        if(!remove(fileName.c_str()))
        {
            std::cout<<"Succeed to delete file"<<std::endl;
        }
        else
        {
            std::cout<<"Failed to delete file"<<std::endl;
        }
        std::ofstream writingCSV;
        writingCSV.open(fileName.c_str(), std::ios::out);
        writingCSV << data << std::endl;

        ROS_INFO("===complete calibration===");
    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "cameraPose_broadcaster");
 
  cameraPoseSaver _cameraPoseSaver;
  
  ros::spin();
}