#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

class lrfPoseServer {
   private:
    ros::NodeHandle _nh;
    tf::TransformBroadcaster _br;
    ros::Timer timer = _nh.createTimer(ros::Duration(0.1),
                                       &lrfPoseServer::timerCallback, this);
    std::vector<tf::Transform> lrfPoses;
    std::stringstream lrfLinkName;
    std::string fileName;
    std::vector<double> lrfIndexes;

   public:
    lrfPoseServer() {
        fileName = "/catkin_ws/src/lrfpose_server/lrfPose.csv";
        std::ifstream readingCSV(fileName.c_str());
        std::string oneLine;
        int lineIndex = 0;
        while (std::getline(readingCSV, oneLine)) {
            std::string tmp;
            tf::Vector3 position;
            double quaternionValue[4];
            double rpyValue[3];
            std::istringstream stream(oneLine);
            int valueIndex = 0;
            while (std::getline(stream, tmp, ',')) {
                switch (valueIndex) {
                    case 0:
                        lrfIndexes.push_back(std::stod(tmp));

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

                    case 8:
                        rpyValue[0] = std::stod(tmp);
                    case 9:
                        rpyValue[1] = std::stod(tmp);
                    case 10:
                        rpyValue[2] = std::stod(tmp);

                        std::cout << std::stod(tmp) << std::endl;
                }
                valueIndex++;
            }
            if (valueIndex > 0) {
                // tf::Vector3
                // axis(quaternionValue[0],quaternionValue[1],quaternionValue[2]);
                // tf::Quaternion quaternion(axis,quaternionValue[3]);
                tf::Quaternion quaternion(rpyValue[0], rpyValue[1],
                                          rpyValue[2]);
                tf::Transform lrfPose;
                lrfPose.setOrigin(position);
                lrfPose.setRotation(quaternion.normalize());
                lrfPoses.push_back(lrfPose);
                std::cout << "quaternion    x:" << quaternionValue[0]
                          << " y:" << quaternionValue[1]
                          << " z:" << quaternionValue[2]
                          << " w:" << quaternionValue[3] << std::endl;
                std::cout << "quaternion    x:" << quaternion.getAxis().x()
                          << " y:" << quaternion.getAxis().y()
                          << " z:" << quaternion.getAxis().z()
                          << " w:" << quaternion.getW() << std::endl;
                std::cout << "lrfPoses    x:"
                          << lrfPose.getRotation().getAxis().x()
                          << " y:" << lrfPose.getRotation().getAxis().y()
                          << " z:" << lrfPose.getRotation().getAxis().z()
                          << " w:" << lrfPose.getRotation().getW() << std::endl;
                lineIndex++;
            }
        }
        for (int tfIndex = 0; tfIndex < lrfPoses.size(); tfIndex++) {
            std::cout << "lrf:" << lrfIndexes[tfIndex] << std::endl;
            std::cout << "    Position" << std::endl;
            std::cout << "        x:" << lrfPoses[tfIndex].getOrigin().getX()
                      << " y:" << lrfPoses[tfIndex].getOrigin().getY()
                      << " z:" << lrfPoses[tfIndex].getOrigin().getZ()
                      << std::endl;
            std::cout << "        x:"
                      << lrfPoses[tfIndex].getRotation().getAxis().x()
                      << " y:" << lrfPoses[tfIndex].getRotation().getAxis().y()
                      << " z:" << lrfPoses[tfIndex].getRotation().getAxis().z()
                      << " w:" << lrfPoses[tfIndex].getRotation().getW()
                      << std::endl;
            double roll, pitch, yaw;
            tf::Matrix3x3(lrfPoses[tfIndex].getRotation())
                .getRPY(roll, pitch, yaw);
            std::cout << "    Yaw:" << yaw << std::endl;
            std::cout << std::endl;
        }
    }
    void timerCallback(const ros::TimerEvent &) {
        for (int lrfPoseIndex = 0; lrfPoseIndex < lrfPoses.size();
             lrfPoseIndex++) {
            this->broadcastLrfPose(lrfPoses[lrfPoseIndex], lrfPoseIndex);
        }
    }
    void broadcastLrfPose(tf::Transform lrfPose, int lrfPoseIndex) {
        lrfLinkName.str("");
        lrfLinkName.clear(std::stringstream::goodbit);
        lrfLinkName << "/env_lrf0" << lrfIndexes[lrfPoseIndex] << "_link";
        _br.sendTransform(tf::StampedTransform(lrfPose, ros::Time::now(), "map",
                                               lrfLinkName.str()));
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "lrfPose_Server");

    lrfPoseServer _clrfPoseServer;

    ros::spin();
}