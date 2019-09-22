#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include "tf/transform_datatypes.h"
#include <tf_conversions/tf_eigen.h>
#include <vector>
#include <sstream>
#include <string>

#include <pcl_conversions/pcl_conversions.h>
#include <pcl/visualization/cloud_viewer.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/io/pcd_io.h>
#include <pcl_ros/io/pcd_io.h>
#include <pcl_ros/transforms.h>
#include <pcl/common/angles.h>
#include <pcl/common/common.h>
#include <pcl/common/common_headers.h>
#include <pcl/common/transforms.h>
#include <pcl/ros/conversions.h>
#include <pcl/features/normal_3d.h>
#include <pcl/filters/voxel_grid.h>
#include <pcl/segmentation/sac_segmentation.h>
#include <pcl/sample_consensus/model_types.h>
#include <pcl/sample_consensus/method_types.h>
#include <pcl/ModelCoefficients.h>
#include <pcl/registration/transformation_estimation_svd.h>



class cameraPoseEstimater
{
private:
    ros::NodeHandle                     _nh;
    ros::Subscriber                     _sub_ar_cloud;
    ros::Timer                          _timer;
    tf::TransformListener               _ls;
    tf::TransformBroadcaster            _br;

    tf::Transform aveCameraPoseFromMap;

    std::string _cam_name = "";
    std::string frameName = "";
    std::stringstream cameraLinkName;
    int _markerNum = 1;
    double _planeDetectionDistanceTh = 0.001;
    bool _image_enable = false;
    bool _pcd_enable = false;
    bool _calTF = false;

public:
    cameraPoseEstimater()
    {
        ros::NodeHandle _pnh("~");
        _pnh.getParam("cameraName", _cam_name);
        _pnh.getParam("markerNum", _markerNum);
        _pnh.getParam("image_enable", _image_enable);
        _pnh.getParam("pcd_enable", _pcd_enable);
        _pnh.getParam("output_frame", frameName);
        std::cout<<"cam_name:"<<_cam_name<<std::endl;
        std::cout<<"markerNum:"<<_markerNum<<std::endl;

        cameraLinkName << _cam_name <<frameName;

        _sub_ar_cloud = _nh.subscribe( (_cam_name+"/ar_marker_cloud").c_str(), 1, &cameraPoseEstimater::arCloudCallback, this);
        _timer = _nh.createTimer(ros::Duration(0.1), &cameraPoseEstimater::timerCallback,this);
        
    }
    //--------------------------------------------------------------
    void arCloudCallback(const sensor_msgs::PointCloud2ConstPtr &input_cloud)
    {
        this->updateTransform();
    }
    //--------------------------------------------------------------
    void updateTransform()
    {
        //std::cout<<"update"<<std::endl;
        std::vector< tf::StampedTransform >cameraPoses;

        std::vector< double >arIndexs;
        std::vector< tf::StampedTransform >arPoses;
        std::vector< tf::StampedTransform >arPosesFromCamera;

        for(int markerIndex=0;markerIndex<_markerNum;markerIndex++)
        {
            std::stringstream arMarkerName;
            std::stringstream arMarkerWithCameraName;
    
            arMarkerName << "ar_marker_"<<markerIndex;
            arMarkerWithCameraName << _cam_name<<"_ar_marker_"<<markerIndex;
            
   
            tf::StampedTransform cameraPoseCandidateFromAR;

            if(this->getCameraPoseFromAR(cameraPoseCandidateFromAR,cameraLinkName.str(),arMarkerWithCameraName.str(),_pcd_enable, _image_enable))
            {
                //std::cout<<"get camerapose"<<std::endl;
                tf::StampedTransform arPoseFromCamera;
                tf::StampedTransform arPoseCandidateFromMap;
                if(  this->getARPoseFromMap(arPoseCandidateFromMap, arMarkerName.str()))
                {
                    //this->getARPoseFromCamera(arPoseFromCamera,arMarkerWithCameraName.str(),cameraLinkName.str()) 
                    //push_back camera pose
                    cameraPoses.push_back(cameraPoseCandidateFromAR);
                    //push_back ar pose from camera
                    arPosesFromCamera.push_back(arPoseFromCamera);
                    //push_back ar pose
                    arIndexs.push_back(markerIndex);
                    arPoses.push_back(arPoseCandidateFromMap);
                }
            }
           
        }
        //std::cout<<cameraPoses.size()<<std::endl;
        if(cameraPoses.size()>0)
        {
            tf::Transform aveCameraPoseFromAR  = this->getAveragePose(cameraPoses);
            tf::Transform aveARPoseFromMap = this->getAveragePose(arPoses);
            aveCameraPoseFromMap = this->getCombinedTransform(aveARPoseFromMap, aveCameraPoseFromAR);
            std::vector<tf::Transform> arPosesFromMapUsingCamera;
            for(int arIndex=0;arIndex<cameraPoses.size();arIndex++)
            {
                //std::cout<<"broadcast"<<std::endl;
                //std::stringstream arMarkerUsingCamera;
                //arMarkerUsingCamera << _cam_name<<"/ar_marker_"<<arIndexs[arIndex]<<"_use_cam";
                tf::Transform arPoseFromMapUsingCamera;
                //arPoseFromMapUsingCamera = this->getCombinedTransform(aveCameraPoseFromMap, arPosesFromCamera[arIndex]);
                arPoseFromMapUsingCamera = this->getCombinedTransform(aveCameraPoseFromMap, this->getInversePose(cameraPoses[arIndex]));
                //this->broadcastPose(arPoseFromMapUsingCamera, "map", arMarkerUsingCamera.str());
                arPosesFromMapUsingCamera.push_back(arPoseFromMapUsingCamera);
            }
            
            if(cameraPoses.size()>2)
            {
                tf::Transform detailAlignment = this->estimateTransformBetweenPointSet(arPosesFromMapUsingCamera,arPoses);
                aveCameraPoseFromMap = this->getCombinedTransform(detailAlignment, aveCameraPoseFromMap);
                _calTF = true;
            }
            
        }
        
    }
    //--------------------------------------------------------------
    void timerCallback(const ros::TimerEvent&)
    {
        if(_calTF)
        {
            this->broadcastPose(aveCameraPoseFromMap, "map", cameraLinkName.str());
        }
    }
    //--------------------------------------------------------------
    bool getCameraPoseFromAR(tf::StampedTransform &camPose, std::string cameraLinkName, std::string arMarkerWithCameraName, bool pcdEnable, bool imageEnable)
    {
        std::string tfName;
        tf::StampedTransform poseFromPcd;
        tf::StampedTransform poseFromImage;
        if(pcdEnable && this->getTransform(poseFromPcd,arMarkerWithCameraName+"_pcd", cameraLinkName))
        {
            if(imageEnable && this->getTransform(poseFromImage,arMarkerWithCameraName, cameraLinkName))
            {
                if(this->getTransformsDistance(poseFromPcd,poseFromImage)<0.3)
                {
                    camPose = poseFromPcd;
                    return true;
                }
                else
                {
                    camPose = poseFromImage;
                    return false;
                }
            }
            else
            {
                camPose = poseFromPcd;
                return true;
            }
        }
        else
        {
            return false;
        }
    }
    double getTransformsDistance(tf::Transform tf1,tf::Transform tf2)
    {
        return tf1.getOrigin().distance(tf2.getOrigin());
    }
    //--------------------------------------------------------------
    bool getARPoseFromMap(tf::StampedTransform &arPose, std::string arMarkerName)
    {
        return this->getTransform(arPose,"map",arMarkerName);
    }
    //--------------------------------------------------------------
    /**
    *get transform
    *argument: tf::Transform output, std::string from, std::string to
    *return: bool
    */
    bool getTransform(tf::StampedTransform &output, std::string from, std::string to)
    {
        //std::cout<<"from: "<<from<<std::endl;
        //std::cout<<"to: "<<to<<std::endl;
        try{
            //get tf FromArMarkerToCamera
            _ls.lookupTransform( from, to, ros::Time(0), output);            
            return true;
        }
        catch (tf::TransformException ex){
            //ROS_ERROR("%s",ex.what());
            return false;
        }
    }
    //--------------------------------------------------------------
    void broadcastPose(tf::Transform pose, std::string from, std::string to)
    {
        //std::cout<<"broadcast"<<std::endl;
        _br.sendTransform(tf::StampedTransform(pose, ros::Time::now(),from,to));
    }
    //--------------------------------------------------------------
    void broadcastCameraPoseCandidate(tf::Transform cameraPose, std::string cameraLinkName, std::string arMarkerName)
    {
        std::stringstream totalCameraLinkName;
        totalCameraLinkName << cameraLinkName<<"_from_" << arMarkerName;
        _br.sendTransform(tf::StampedTransform(cameraPose, ros::Time::now(),"map",totalCameraLinkName.str()));
    }
    //--------------------------------------------------------------
    tf::Transform getInversePose(tf::StampedTransform pose)
    {
        tf::Transform inversePose = pose.inverse();
        return inversePose;
    }
    //--------------------------------------------------------------
    tf::Transform getInversePose(tf::Transform pose)
    {
        tf::Transform inversePose = pose.inverse();
        return inversePose;
    }
    //--------------------------------------------------------------
    tf::Transform getAveragePose(std::vector< tf::StampedTransform >poses)
    {
        tf::Transform averagePose;
        tf::Vector3 averagePosition;
        tf::Quaternion averageQuaternion;
        averageQuaternion =poses[0].getRotation();
        //std::cout<<"cameraPositions.size()"<<cameraPositions.size()<<std::endl;
        for(int poseIndex=0;poseIndex<poses.size();poseIndex++)
        {
            //std::cout<<"    Position"<<std::endl;
            //std::cout<<"        x:"<<cameraPositions[positionIndex].getX()<<" y:"<<cameraPositions[positionIndex].getY()<<" z:"<<cameraPositions[positionIndex].getZ()<<std::endl;
            averagePosition = (averagePosition*(double)poseIndex + poses[poseIndex].getOrigin())/(double)(poseIndex+1);
            averageQuaternion.slerp(poses[poseIndex].getRotation(),1/(poseIndex+1));
        }

        averagePose.setOrigin(averagePosition);
        averagePose.setRotation(averageQuaternion);

        return averagePose;
    }
    //--------------------------------------------------------------
    /**
    *get combined transform
    *argument: tf::Trasform from, tf::Trasform to
    *return: bool
    */
    tf::Transform getCombinedTransform(tf::Transform from, tf::Transform to)
    {
        tf::Transform combinedTransform;
        combinedTransform.setOrigin((from*to).getOrigin());
        combinedTransform.setRotation((from*to).getRotation());
        return combinedTransform;
    }
    //--------------------------------------------------------------
    /**
    *print transform
    *argument: tf::Trasform pose
    *return: none
    */
    void printTransform(tf::Transform pose)
    {
        std::cout<<"position x:"<<pose.getOrigin().getX()<<", y:"<<pose.getOrigin().getY()<<", z:"<<pose.getOrigin().getZ()<<std::endl;
        std::cout<<"orientation x:"<<pose.getRotation().getAxis().x()<<", y:"<<pose.getRotation().getAxis().y()<<", z:"<<pose.getRotation().getAxis().z()<<", w:"<<pose.getRotation().getW()<<std::endl;
    }

    //--------------------------------------------------------------
    tf::Transform estimateTransformBetweenPointSet(std::vector< tf::Transform > inPose, std::vector< tf::StampedTransform > outPose)
    {
        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_in (new pcl::PointCloud<pcl::PointXYZ> ());
        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_out (new pcl::PointCloud<pcl::PointXYZ> ());

        cloud_in->width = inPose.size();
        cloud_in->height = 1;
        cloud_in->is_dense = false;
        cloud_in->resize(cloud_in->width * cloud_in->height);

        cloud_out->width = outPose.size();
        cloud_out->height = 1;
        cloud_out->is_dense = false;
        cloud_out->resize(cloud_out->width * cloud_out->height);

        for(int poseIndex=0;poseIndex<inPose.size();poseIndex++)
        {
            cloud_in->points[poseIndex].x = inPose[poseIndex].getOrigin().getX();
            cloud_in->points[poseIndex].y = inPose[poseIndex].getOrigin().getY();
            cloud_in->points[poseIndex].z = inPose[poseIndex].getOrigin().getZ();

            cloud_out->points[poseIndex].x = outPose[poseIndex].getOrigin().getX();
            cloud_out->points[poseIndex].y = outPose[poseIndex].getOrigin().getY();
            cloud_out->points[poseIndex].z = outPose[poseIndex].getOrigin().getZ();
        }
        pcl::registration::TransformationEstimationSVD<pcl::PointXYZ,pcl::PointXYZ> TESVD;
        pcl::registration::TransformationEstimationSVD<pcl::PointXYZ,pcl::PointXYZ>::Matrix4 transformation2;
        TESVD.estimateRigidTransformation (*cloud_in,*cloud_out,transformation2);
        
        /*std::cout << "The Estimated Rotation and translation matrices (using getTransformation function) are : \n" << std::endl;
        printf ("\n");
        printf ("| %6.3f %6.3f %6.3f | \n", transformation2 (0,0), transformation2 (0,1), transformation2 (0,2));
        printf ("R = | %6.3f %6.3f %6.3f | \n", transformation2 (1,0), transformation2 (1,1), transformation2 (1,2));
        printf ("    | %6.3f %6.3f %6.3f | \n", transformation2 (2,0), transformation2 (2,1), transformation2 (2,2));
        printf ("\n");
        printf ("t = < %0.3f, %0.3f, %0.3f >\n", transformation2 (0,3), transformation2 (1,3), transformation2 (2,3));*/
        
        tf::Transform estimatedTransform;
        Eigen::Matrix4d md(transformation2.cast<double>());
        Eigen::Affine3d affine(md);
        tf::transformEigenToTF(affine, estimatedTransform);

        return estimatedTransform;
    }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "cameraPoseEstimater");
 
  cameraPoseEstimater _cameraPoseEstimater;
  
  ros::spin();
}