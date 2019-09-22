#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <message_filters/subscriber.h>
#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <stdio.h>
#include <tf/message_filter.h>
#include <tf/tf.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <algorithm>
#include <array>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

class lrfPoseInfo {
   public:
    lrfPoseInfo(){

    };
    bool received = false;
    tf::StampedTransform TF;
    std::array<double, 3> Variances;
};
class lrfPoseSaver {
   private:
    ros::NodeHandle _nh;
    tf::TransformListener _ls;

    ros::Subscriber laser00_scan_sub;
    ros::Subscriber laser01_scan_sub;
    ros::Subscriber laser02_scan_sub;
    ros::Subscriber laser03_scan_sub;

    ros::Subscriber laser00_pose_sub;
    ros::Subscriber laser01_pose_sub;
    ros::Subscriber laser02_pose_sub;
    ros::Subscriber laser03_pose_sub;
    ros::Timer timer;

    std::array<lrfPoseInfo, 4> lrfPoseInfos;
    tf::Transform lrfPose;
    std::vector<std::vector<tf::Transform> > lrfPoseSamples;
    std::vector<int> sampleCounters;
    std::vector<tf::Transform> averageLrfPoses;

    std::array<sensor_msgs::LaserScan, 4> laserScanDatas;
    std::array<std::vector<double>, 4> laserScanMaxDatas;
    int scanDataLength = 1081;

    bool lrf_enables[4] = {false, false, false, false};
    double enableVar[3] = {0, 0, 0};
    int lrfNum = 4;
    int sampleNum = 100;
    double samplingTime = 0.3;
    std::string lrfName;
    std::string lrfScanTopicPrefix;
    std::string lrfPoseTopicPrefix;
    std::string lrfTFPrefix;
    std::string poseFileName;
    std::string scanFileName;

   public:
    lrfPoseSaver() {
        _nh.getParam("/lrfpose_saver/lrf_name", lrfName);
        _nh.getParam("/lrfpose_saver/lrf_scan_topic_prefix",
                     lrfScanTopicPrefix);
        _nh.getParam("/lrfpose_saver/lrf_pose_topic_prefix",
                     lrfPoseTopicPrefix);
        _nh.getParam("/lrfpose_saver/lrf_tf_prefix", lrfTFPrefix);
        _nh.getParam("/lrfpose_saver/lrf00_enable", lrf_enables[0]);
        _nh.getParam("/lrfpose_saver/lrf01_enable", lrf_enables[1]);
        _nh.getParam("/lrfpose_saver/lrf02_enable", lrf_enables[2]);
        _nh.getParam("/lrfpose_saver/lrf03_enable", lrf_enables[3]);
        _nh.getParam("/lrfpose_saver/sampleNum", sampleNum);
        _nh.getParam("/lrfpose_saver/samplingTime", samplingTime);
        _nh.getParam("/lrfpose_saver/enableVarX", enableVar[0]);
        _nh.getParam("/lrfpose_saver/enableVarY", enableVar[1]);
        _nh.getParam("/lrfpose_saver/enableVarT", enableVar[2]);

        averageLrfPoses.resize(lrfNum);
        sampleCounters.resize(lrfNum);
        lrfPoseSamples.resize(lrfNum);

        laser00_scan_sub =
            _nh.subscribe(lrfName + "00/" + lrfScanTopicPrefix, 10,
                          &lrfPoseSaver::_scan00Recieved, this);
        laser01_scan_sub =
            _nh.subscribe(lrfName + "01/" + lrfScanTopicPrefix, 10,
                          &lrfPoseSaver::_scan01Recieved, this);
        laser02_scan_sub =
            _nh.subscribe(lrfName + "02/" + lrfScanTopicPrefix, 10,
                          &lrfPoseSaver::_scan02Recieved, this);
        laser03_scan_sub =
            _nh.subscribe(lrfName + "03/" + lrfScanTopicPrefix, 10,
                          &lrfPoseSaver::_scan03Recieved, this);

        laser00_pose_sub =
            _nh.subscribe(lrfName + "00/" + lrfPoseTopicPrefix, 10,
                          &lrfPoseSaver::_pose00Recieved, this);
        laser01_pose_sub =
            _nh.subscribe(lrfName + "01/" + lrfPoseTopicPrefix, 10,
                          &lrfPoseSaver::_pose01Recieved, this);
        laser02_pose_sub =
            _nh.subscribe(lrfName + "02/" + lrfPoseTopicPrefix, 10,
                          &lrfPoseSaver::_pose02Recieved, this);
        laser03_pose_sub =
            _nh.subscribe(lrfName + "03/" + lrfPoseTopicPrefix, 10,
                          &lrfPoseSaver::_pose03Recieved, this);

        poseFileName = "/catkin_ws/src/lrfpose_server/lrfPose.csv";
        scanFileName = "/catkin_ws/src/lrfpose_server/lrfMaxScan.csv";
        timer = _nh.createTimer(ros::Duration(samplingTime),
                                &lrfPoseSaver::timerCallback, this);

        for (int laserIndex = 0; laserIndex < 4; laserIndex++) {
            std::vector<double> initialVector(scanDataLength);
            laserScanMaxDatas[laserIndex] = initialVector;
        }
    }
    void timerCallback(const ros::TimerEvent &) {
        for (int lrfIndex = 0; lrfIndex < lrfNum; lrfIndex++) {
            if (lrf_enables[lrfIndex]) {
                if (this->getLrfPose(lrfIndex)) {
                    this->updateAverage(lrfIndex);
                    this->updateMaxData(lrfIndex);
                    sampleCounters[lrfIndex]++;
                }
            }
        }

        int minCount = sampleNum + 1;
        for (int lrfIndex = 0; lrfIndex < lrfNum; lrfIndex++) {
            if (lrf_enables[lrfIndex]) {
                if (minCount > sampleCounters[lrfIndex]) {
                    minCount = sampleCounters[lrfIndex];
                }
            }
        }
        if (minCount == sampleNum) {
            this->savePoses();
            this->saveRanges();
        } else if (minCount < sampleNum) {
            std::cout << "calibrating now! sample:" << minCount << "/"
                      << sampleNum << std::endl;
        }
    }

    // #################################################
    // ############ scan callback functions ############
    // #################################################
    void _scan00Recieved(const sensor_msgs::LaserScan::ConstPtr &laser_scan) {
        laserScanDatas[0] = *laser_scan;
    }
    void _scan01Recieved(const sensor_msgs::LaserScan::ConstPtr &laser_scan) {
        laserScanDatas[1] = *laser_scan;
    }
    void _scan02Recieved(const sensor_msgs::LaserScan::ConstPtr &laser_scan) {
        laserScanDatas[2] = *laser_scan;
    }
    void _scan03Recieved(const sensor_msgs::LaserScan::ConstPtr &laser_scan) {
        laserScanDatas[3] = *laser_scan;
    }

    // #################################################
    // ############ pose callback functions ############
    // #################################################
    void _pose00Recieved(
        const geometry_msgs::PoseWithCovarianceStampedConstPtr &laser_pose) {
        int infoIndex = 0;
        if (this->getTF(infoIndex, lrfPoseInfos[infoIndex].TF)) {
            lrfPoseInfos[infoIndex].Variances[0] =
                (double)laser_pose->pose.covariance[0];  // pos X
            lrfPoseInfos[infoIndex].Variances[1] =
                (double)laser_pose->pose.covariance[7];  // pos Y  6+1
            lrfPoseInfos[infoIndex].Variances[2] =
                (double)laser_pose->pose.covariance[35];  // rot Z 6*5+5
            lrfPoseInfos[infoIndex].received = true;
            // ROS_INFO("variances posX:%f ,posY:%f ,
            // rotZ:%f",lrfPoseInfos[infoIndex].Variances[0],lrfPoseInfos[infoIndex].Variances[1],lrfPoseInfos[infoIndex].Variances[2]);
        }
    }
    void _pose01Recieved(
        const geometry_msgs::PoseWithCovarianceStampedConstPtr &laser_pose) {
        int infoIndex = 1;
        if (this->getTF(infoIndex, lrfPoseInfos[infoIndex].TF)) {
            lrfPoseInfos[infoIndex].Variances[0] =
                (double)laser_pose->pose.covariance[0];  // pos X
            lrfPoseInfos[infoIndex].Variances[1] =
                (double)laser_pose->pose.covariance[7];  // pos Y  6+1
            lrfPoseInfos[infoIndex].Variances[2] =
                (double)laser_pose->pose.covariance[35];  // rot Z 6*5+5
            lrfPoseInfos[infoIndex].received = true;
            // ROS_INFO("variances posX:%f ,posY:%f ,
            // rotZ:%f",lrfPoseInfos[infoIndex].Variances[0],lrfPoseInfos[infoIndex].Variances[1],lrfPoseInfos[infoIndex].Variances[2]);
        }
    }
    void _pose02Recieved(
        const geometry_msgs::PoseWithCovarianceStampedConstPtr &laser_pose) {
        int infoIndex = 2;
        if (this->getTF(infoIndex, lrfPoseInfos[infoIndex].TF)) {
            lrfPoseInfos[infoIndex].Variances[0] =
                (double)laser_pose->pose.covariance[0];  // pos X
            lrfPoseInfos[infoIndex].Variances[1] =
                (double)laser_pose->pose.covariance[7];  // pos Y  6+1
            lrfPoseInfos[infoIndex].Variances[2] =
                (double)laser_pose->pose.covariance[35];  // rot Z 6*5+5
            lrfPoseInfos[infoIndex].received = true;
            // ROS_INFO("variances posX:%f ,posY:%f ,
            // rotZ:%f",lrfPoseInfos[infoIndex].Variances[0],lrfPoseInfos[infoIndex].Variances[1],lrfPoseInfos[infoIndex].Variances[2]);
        }
    }
    void _pose03Recieved(
        const geometry_msgs::PoseWithCovarianceStampedConstPtr &laser_pose) {
        int infoIndex = 3;
        if (this->getTF(infoIndex, lrfPoseInfos[infoIndex].TF)) {
            lrfPoseInfos[infoIndex].Variances[0] =
                (double)laser_pose->pose.covariance[0];  // pos X
            lrfPoseInfos[infoIndex].Variances[1] =
                (double)laser_pose->pose.covariance[7];  // pos Y  6+1
            lrfPoseInfos[infoIndex].Variances[2] =
                (double)laser_pose->pose.covariance[35];  // rot Z 6*5+5
            lrfPoseInfos[infoIndex].received = true;
            // ROS_INFO("variances posX:%f ,posY:%f ,
            // rotZ:%f",lrfPoseInfos[infoIndex].Variances[0],lrfPoseInfos[infoIndex].Variances[1],lrfPoseInfos[infoIndex].Variances[2]);
        }
    }

    bool getLrfPose(int lrfIndex) {
        tf::StampedTransform obtainedTF;
        std::array<double, 3> obtainedVariances;
        if (lrfPoseInfos[lrfIndex].received) {
            obtainedTF = lrfPoseInfos[lrfIndex].TF;
            obtainedVariances = lrfPoseInfos[lrfIndex].Variances;
            bool enable = true;
            for (int varianceIndex = 0; varianceIndex < 3; varianceIndex++) {
                if (obtainedVariances[varianceIndex] >
                    enableVar[varianceIndex]) {
                    enable = false;
                }
            }
            if (enable) {
                lrfPose.setOrigin(obtainedTF.getOrigin());
                lrfPose.setRotation(obtainedTF.getRotation());
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    bool getTF(int lrfId, tf::StampedTransform &tfFromMapToLRF) {
        std::stringstream ssTfName;
        ssTfName << lrfName << "0" << lrfId << lrfTFPrefix;
        try {
            _ls.lookupTransform("map", ssTfName.str(), ros::Time(0),
                                tfFromMapToLRF);
            return true;
        } catch (tf::TransformException ex) {
            // ROS_ERROR("%s",ex.what());
            return false;
        }
    }
    void savePoses() {
        std::string data;
        for (int lrfIndex = 0; lrfIndex < lrfNum; lrfIndex++) {
            if (lrf_enables[lrfIndex]) {
                std::stringstream ssData;

                tf::Transform averagePose = averageLrfPoses[lrfIndex];
                tf::Vector3 averagePosition = averagePose.getOrigin();
                tf::Quaternion averageQuaternion = averagePose.getRotation();
                double roll, pitch, yaw;
                tf::Matrix3x3(averagePose.getRotation())
                    .getRPY(roll, pitch, yaw);

                // CameraNum
                ssData << lrfIndex << ",";
                // Position
                ssData << averagePosition.getX() << ","
                       << averagePosition.getY() << ","
                       << averagePosition.getZ() << ",";
                // Quaternion
                ssData << averageQuaternion.getAxis().x() << ","
                       << averageQuaternion.getAxis().y() << ","
                       << averageQuaternion.getAxis().z() << ","
                       << averageQuaternion.getW() << ",";
                // RPY
                ssData << roll << "," << pitch << "," << yaw << std::endl;

                // add Data
                data += ssData.str();
            }
        }
        if (!remove(poseFileName.c_str())) {
            std::cout << "Succeed to delete pose file" << std::endl;
        } else {
            std::cout << "Failed to delete pose file" << std::endl;
        }
        std::ofstream writingCSV;
        writingCSV.open(poseFileName.c_str(), std::ios::out);
        writingCSV << data << std::endl;

        ROS_INFO("===complete pose calibration===");
    }
    void saveRanges() {
        std::string data;
        for (int lrfIndex = 0; lrfIndex < lrfNum; lrfIndex++) {
            if (lrf_enables[lrfIndex]) {
                std::stringstream ssData;
                // lrf index
                ssData << lrfIndex << ",";

                for (int rangeDataIndex = 0;
                     rangeDataIndex < laserScanMaxDatas[lrfIndex].size();
                     rangeDataIndex++) {
                    ssData << laserScanMaxDatas[lrfIndex][rangeDataIndex]
                           << ",";
                }

                // return
                ssData << std::endl;

                // add Data
                data += ssData.str();
            }
        }
        if (!remove(scanFileName.c_str())) {
            std::cout << "Succeed to delete scan file" << std::endl;
        } else {
            std::cout << "Failed to delete scan file" << std::endl;
        }
        std::ofstream writingCSV;
        writingCSV.open(scanFileName.c_str(), std::ios::out);
        writingCSV << data << std::endl;

        ROS_INFO("===complete get max scan datas===");
    }
    void updateAverage(int lrfIndex) {
        if (sampleCounters[lrfIndex] < sampleNum) {
            tf::Transform averagePose = averageLrfPoses[lrfIndex];
            tf::Transform inputPose = lrfPose;
            lrfPoseSamples[lrfIndex].push_back(lrfPose);
            // weighted average

            tf::Vector3 averagePosition = averagePose.getOrigin();
            tf::Vector3 inputPosition = inputPose.getOrigin();
            averagePosition =
                averagePosition * (sampleCounters[lrfIndex] /
                                   (sampleCounters[lrfIndex] + 1.0)) +
                inputPosition * (1.0 / (sampleCounters[lrfIndex] + 1));

            tf::Quaternion averageQuaternion = averagePose.getRotation();
            tf::Quaternion inputQuaternion = inputPose.getRotation();
            averageQuaternion = averageQuaternion
                                    .slerp(inputQuaternion,
                                           1.0 / (sampleCounters[lrfIndex] + 1))
                                    .normalize();

            std::cout << "LRF:" << lrfIndex << std::endl;
            std::cout << "    input" << std::endl;
            std::cout << "        x:" << inputPosition.getX()
                      << " y:" << inputPosition.getY()
                      << " z:" << inputPosition.getZ() << std::endl;
            double roll, pitch, yaw;
            tf::Matrix3x3(inputQuaternion).getRPY(roll, pitch, yaw);
            std::cout << "    Yaw:" << yaw << std::endl;

            std::cout << "    average" << std::endl;
            std::cout << "        x:" << averagePosition.getX()
                      << " y:" << averagePosition.getY()
                      << " z:" << averagePosition.getZ() << std::endl;
            std::cout << "        x:" << averageQuaternion.getAxis().x()
                      << " y:" << averageQuaternion.getAxis().y()
                      << " z:" << averageQuaternion.getAxis().z()
                      << " w:" << averageQuaternion.getW() << std::endl;
            tf::Matrix3x3(averageQuaternion).getRPY(roll, pitch, yaw);
            std::cout << "    Yaw:" << yaw << std::endl;
            averageLrfPoses[lrfIndex].setOrigin(averagePosition);
            averageLrfPoses[lrfIndex].setRotation(averageQuaternion);
        }
    }
    void updateMaxData(int lrfIndex) {
        //std::cout << laserScanDatas[lrfIndex].ranges.size() << std::endl;
        //std::cout << laserScanMaxDatas[lrfIndex].size() << std::endl;
        for (int rangeIndex = 0;
             rangeIndex < laserScanDatas[lrfIndex].ranges.size();
             rangeIndex++) {
            if (laserScanDatas[lrfIndex].ranges[rangeIndex] >
                    laserScanDatas[lrfIndex].range_max ||
                std::isnan(laserScanDatas[lrfIndex].ranges[rangeIndex])) {
                laserScanDatas[lrfIndex].ranges[rangeIndex] =
                    laserScanDatas[lrfIndex].range_max;
            }
            if (laserScanDatas[lrfIndex].ranges[rangeIndex] >
                laserScanMaxDatas[lrfIndex][rangeIndex]) {
                laserScanMaxDatas[lrfIndex][rangeIndex] =
                    laserScanDatas[lrfIndex].ranges[rangeIndex];
            }
            // std::cout<<laserScanDatas[lrfIndex].ranges[rangeIndex]<<std::endl;
        }
    }
};
int main(int argc, char **argv) {
    ros::init(argc, argv, "lrfPose_saver");

    lrfPoseSaver _lrfPoseSaver;

    ros::spin();
}