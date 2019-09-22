#include <geometry_msgs/Pose.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <message_filters/subscriber.h>
#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <std_msgs/Header.h>
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

// global variable

double LRF_ID;
std::string LRF_NAME;
std::string LRF_SCAN_TOPIC_NAME;
std::string LRF_DETECT_TOPIC_NAME;
std::string LRF_SCAN_LIMIT_FILE_NAME;

double MARGIN_LENGTH;
double MIN_LENGTH;
double MAX_DIFFERENCE;

double MAX_OBJECT_WIDTH;
double MIN_OBJECT_WIDTH;

class scanedObjectIndexInfo {
   public:
    int minIndex = 0;
    int maxIndex = 0;
};
class scanedObject {
   public:
    geometry_msgs::Pose pose;
    double width;
};

class objectDetector {
   private:
    ros::NodeHandle _nh;
    ros::Publisher _detect_pub;
    ros::Subscriber _scan_sub;
    ros::Timer timer;

    std::vector<double> laserScanMaxDatas;
    double lrfRangeLength = 1081;

   public:
    objectDetector() {
        _detect_pub =
            _nh.advertise<geometry_msgs::PoseArray>(LRF_DETECT_TOPIC_NAME, 1);
        _scan_sub = _nh.subscribe(LRF_SCAN_TOPIC_NAME, 10,
                                  &objectDetector::_scanRecieved, this);
        ROS_INFO("=========NODE INIT COMPLETE===========");
        laserScanMaxDatas.resize(lrfRangeLength);
        this->_loadRangeLimit(LRF_SCAN_LIMIT_FILE_NAME);
        ROS_INFO("======LOADING SCANLIMIT COMPLETE======");
    }

    // #################################################
    // ############  initialize functions ############
    // #################################################
    //--------------------------------------------------------------
    /**
    load laser range limit
    *argument: tf::Transform output, std::string from, std::string to
    *return: bool
    */
    void _loadRangeLimit(std::string fileName) {
        std::ifstream readingCSV(fileName.c_str());
        std::string oneLine;
        int lineIndex = 0;
        while (std::getline(readingCSV, oneLine)) {
            std::string tmp;
            std::istringstream stream(oneLine);
            double valueIndex = 0;
            while (std::getline(stream, tmp, ',')) {
                ROS_DEBUG("valueIndex:%f", valueIndex);
                ROS_DEBUG("value:%s", tmp.c_str());
                if (valueIndex == 0) {
                    // get data of correct laser num
                    if (std::stoi(tmp) != LRF_ID) {
                        ROS_DEBUG("wrong lrf");
                        break;
                    } else {
                        ROS_DEBUG("correct lrf");
                    }

                } else {
                    laserScanMaxDatas[valueIndex - 1] = std::stod(tmp);
                }
                valueIndex = valueIndex + 1;
                ROS_DEBUG("loop end valueIndex:%f", valueIndex);
            }
        }
    }

    // #################################################
    // ############ scan callback functions ############
    // #################################################
    void _scanRecieved(const sensor_msgs::LaserScan::ConstPtr &laser_scan) {
        std::vector<geometry_msgs::Pose> objects;
        std::vector<float> ranges = laser_scan->ranges;
        double angle_min = laser_scan->angle_min;
        double angle_increment = laser_scan->angle_increment;
        std_msgs::Header header = laser_scan->header;

        objects = this->_searchObjects(ranges, angle_min, angle_increment);
        ROS_DEBUG("Object Num:%i", objects.size());
        this->pubObjects(objects, header);
    }

    // #################################################
    // ################ main functions #################
    // #################################################

    //--------------------------------------------------------------
    /**
    detect objects
    *argument: const sensor_msgs::LaserScan::ConstPtr &laser_scan
    *return: none
    */
    std::vector<geometry_msgs::Pose> _searchObjects(std::vector<float> &ranges,
                                                    double angle_min,
                                                    double angle_increment) {
        bool findingFlag = false;
        std::vector<scanedObjectIndexInfo> objectInfos;
        // search the object from each range data
        for (int rangeIndex = 0; rangeIndex < ranges.size(); rangeIndex++) {
            if (ranges[rangeIndex] > laserScanMaxDatas[rangeIndex] ||
                std::isnan(ranges[rangeIndex]) ||
                ranges[rangeIndex] < MIN_LENGTH)  // utilize values
            {
                ranges[rangeIndex] = laserScanMaxDatas[rangeIndex];
            }

            if (!findingFlag &&
                ranges[rangeIndex] < laserScanMaxDatas[rangeIndex] -
                                         MARGIN_LENGTH)  // object start
            {
                findingFlag = true;
                scanedObjectIndexInfo tempObjectInfo;
                tempObjectInfo.minIndex = rangeIndex;
                objectInfos.push_back(tempObjectInfo);
            } else if (findingFlag) {
                float diffrence = (float)std::abs(ranges[rangeIndex] -
                                                  ranges[rangeIndex - 1]);
                if (diffrence > MAX_DIFFERENCE ||
                    ranges[rangeIndex] > laserScanMaxDatas[rangeIndex] -
                                             MARGIN_LENGTH)  // object end
                {
                    objectInfos[objectInfos.size() - 1].maxIndex = rangeIndex;
                    findingFlag = false;
                }
            }
        }
        if (findingFlag)  // not find object end
        {
            objectInfos[objectInfos.size() - 1].maxIndex = ranges.size() - 1;
        }
        // ROS_DEBUG("ObjectInfos Num:%i", objectInfos.size());
        // convert objectInfos to objectPoses
        std::vector<geometry_msgs::Pose> objectPoses;
        for (int objectIndex = 0; objectIndex < objectInfos.size();
             objectIndex++) {
            scanedObject object = this->_getObjectFromObjectInfo(
                objectInfos[objectIndex], ranges, angle_min, angle_increment);
            if (object.width > MIN_OBJECT_WIDTH &&
                object.width < MAX_OBJECT_WIDTH) {
                objectPoses.push_back(object.pose);
            }
        }

        return objectPoses;
    }
    //--------------------------------------------------------------
    /**
    convert ObjectInfo to geometry_msgs::Pose
    *argument: scanedObjectInfo objectInfo,const
    sensor_msgs::LaserScan::ConstPtr &laser_scan *return: geometry_msgs::Pose
    */
    void pubObjects(std::vector<geometry_msgs::Pose> objects,
                    std_msgs::Header header) {
        geometry_msgs::PoseArray detectedObjects;
        detectedObjects.header = header;
        detectedObjects.poses = objects;
        _detect_pub.publish(detectedObjects);
    }

    //--------------------------------------------------------------
    /**
    convert ObjectInfo to scanedObject
    *argument: scanedObjectInfo objectInfo,const
    sensor_msgs::LaserScan::ConstPtr &laser_scan *return: geometry_msgs::Pose
    */
    scanedObject _getObjectFromObjectInfo(scanedObjectIndexInfo objectInfo,
                                          std::vector<float> &ranges,
                                          double angle_min,
                                          double angle_increment) {
        double centerIndex =
            (double)(objectInfo.minIndex + objectInfo.maxIndex) / 2.0;
        // ROS_DEBUG("centerIndex:%f", centerIndex);
        float averageLength = 0;
        for (int rangeIndex = objectInfo.minIndex;
             rangeIndex <= objectInfo.maxIndex; rangeIndex++) {
            averageLength +=
                ranges[rangeIndex] /
                (float)(objectInfo.maxIndex - objectInfo.minIndex + 1);
        }
        // ROS_DEBUG("averageLength:%f", averageLength);
        double objectWidth = averageLength * angle_increment *
                             (objectInfo.maxIndex - objectInfo.minIndex);

        double objectDistance = averageLength + objectWidth / 2.0;
        double objectDirection = angle_min + centerIndex * angle_increment;

        scanedObject object;
        object.pose.position.x = objectDistance * cos(objectDirection);
        object.pose.position.y = objectDistance * sin(objectDirection);
        object.width = objectWidth;
        return object;
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "object_detector");
    ros::NodeHandle _pnh("~");
    if (ros::console::set_logger_level(ROSCONSOLE_DEFAULT_NAME,
                                       ros::console::levels::Debug)) {
        ros::console::notifyLoggerLevelsChanged();
    }
    _pnh.getParam("lrf_id", LRF_ID);
    _pnh.getParam("lrf_name", LRF_NAME);
    _pnh.getParam("lrf_scan_topic_name", LRF_SCAN_TOPIC_NAME);
    ROS_INFO("LRF_SCAN_TOPIC_NAME:%s", LRF_SCAN_TOPIC_NAME.c_str());
    _pnh.getParam("lrf_detect_topic_name", LRF_DETECT_TOPIC_NAME);
    ROS_INFO("LRF_DETECT_TOPIC_NAME:%s", LRF_DETECT_TOPIC_NAME.c_str());
    _pnh.getParam("lrf_scan_limit_file_name", LRF_SCAN_LIMIT_FILE_NAME);
    ROS_INFO("LRF_SCAN_LIMIT_FILE_NAME:%s", LRF_SCAN_LIMIT_FILE_NAME.c_str());

    _pnh.getParam("margin_length", MARGIN_LENGTH);
    _pnh.getParam("min_length", MIN_LENGTH);
    _pnh.getParam("max_difference", MAX_DIFFERENCE);

    _pnh.getParam("max_object_width", MAX_OBJECT_WIDTH);
    _pnh.getParam("min_object_width", MIN_OBJECT_WIDTH);
    objectDetector _objectDetector;

    ros::spin();
}