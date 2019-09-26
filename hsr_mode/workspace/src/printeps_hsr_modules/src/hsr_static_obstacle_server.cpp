#include <cv_bridge/cv_bridge.h>
#include <pcl_ros/io/pcd_io.h>
#include <ros/ros.h>
#include <opencv2/highgui/highgui.hpp>

#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/WrenchStamped.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/JointState.h>
#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/image_encodings.h>

#include <fcntl.h>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <pcl/visualization/cloud_viewer.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>
#include <algorithm>
#include <fstream>
#include <iostream>
#include <limits>
#include <sstream>
#include <string>
#include <vector>

#include <sensor_msgs/point_cloud2_iterator.h>
#include <visualization_msgs/MarkerArray.h>

#include <pcl/common/common_headers.h>
#include <pcl/features/normal_3d.h>
#include <pcl/point_types.h>
#include <boost/thread/thread.hpp>

#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>

#include "printeps_hsr_modules/HsrObstacle.h"
#include "printeps_hsr_modules/HsrObstacleArray.h"
#include "printeps_hsr_modules/HsrTableset.h"

using namespace std;

class HsrStaticObstacleServer {
   private:
    ros::NodeHandle _nh;
    ros::Publisher pubObstacles =
        _nh.advertise<printeps_hsr_modules::HsrObstacleArray>("hsr_obstacles",
                                                              4);
    ros::Publisher pubObstacleMarker =
        _nh.advertise<visualization_msgs::MarkerArray>(
            "collision_environment_marker_array", 4);
    ros::Timer timer = _nh.createTimer(
        ros::Duration(5), &HsrStaticObstacleServer::timerCallback, this);
    tf::TransformListener tflistener;

    printeps_hsr_modules::HsrObstacleArray obstacleArray;

   public:
    HsrStaticObstacleServer() {}
    void timerCallback(const ros::TimerEvent &) {
        this->defineStaticObstacle();
    }
    void defineStaticObstacle() {
        cout << "pubMarker" << endl;
        visualization_msgs::MarkerArray obstacleMarker;

        obstacleArray.obstacles.clear();

        printeps_hsr_modules::HsrObstacle table;
        printeps_hsr_modules::HsrObstacle chair;

        double tableWidth = 1.0;
        double chairDistance = 0.6;
        double chairRadius = 0.5;

        bool rounge2019 = true;
        bool gazebo = false;
        bool journal = false;
        if (journal) {
            /*
            //table1
            printeps_hsr_modules::HsrTableset tableSet1;
            //テーブルの定義
            table.pose.x        =4.0; //x
            table.pose.y        =0.0;//y
            table.pose.theta    =3.14/4;//姿勢
            table.width         =tableWidth;//テーブルの幅
            tableSet1.table     =table;
            // 椅子の定義
            for(int i=0;i<4;i++)
            {
                chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                chair.width=chairRadius;
                tableSet1.chairs.push_back(chair);
            }
            //obstacleArrayに追加
            obstacleArray.obstacles.push_back(tableSet1);
            */
        } else {
            if (rounge2019) {
                // table1
                printeps_hsr_modules::HsrTableset tableSet1;
                //テーブルの定義
                table.pose.x = 1.0;           // x
                table.pose.y = 1.25;          // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet1.table = table;
                // 椅子の定義
                for (int i = 0; i < 4; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14/2 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14/2 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet1.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet1);

                // table2
                printeps_hsr_modules::HsrTableset tableSet2;
                //テーブルの定義
                table.pose.x = 1.0;           // x
                table.pose.y = -1.25;             // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet2.table = table;
                // 椅子の定義
                for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    tableSet2.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet2);

                // table3
                printeps_hsr_modules::HsrTableset tableSet3;
                //テーブルの定義
                table.pose.x = 3.5;           // x
                table.pose.y = 1.25;             // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet3.table = table;
                // 椅子の定義
                for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet3.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet3);

                // table4
                printeps_hsr_modules::HsrTableset tableSet4;
                //テーブルの定義
                table.pose.x = 3.5;           // x
                table.pose.y = -1.25;             // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet4.table = table;
                // 椅子の定義
                for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet4.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet4);

                // table5
                printeps_hsr_modules::HsrTableset tableSet5;
                //テーブルの定義
                table.pose.x = 4.0;        // x
                table.pose.y = -3.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet5.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet5);

                // table6
                printeps_hsr_modules::HsrTableset tableSet6;
                //テーブルの定義
                table.pose.x = 7.5;        // x
                table.pose.y = -3.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet6.table = table;
                // 椅子の定義
                /*for(int i=0;i<2;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet6.chairs.push_back(chair);
                }*/
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet6);

                // table7
                printeps_hsr_modules::HsrTableset tableSet7;
                //テーブルの定義
                table.pose.x =7.5;       // x
                table.pose.y = -2.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet7.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet7);
            }
            else if (gazebo) {
                // table1
                printeps_hsr_modules::HsrTableset tableSet1;
                //テーブルの定義
                table.pose.x = 2.7;           // x
                table.pose.y = -2.8;          // y
                table.pose.theta = 3.14 / 2;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet1.table = table;
                // 椅子の定義
                for (int i = 0; i < 2; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet1.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet1);

                // table2
                printeps_hsr_modules::HsrTableset tableSet2;
                //テーブルの定義
                table.pose.x = 4.0;           // x
                table.pose.y = 3;             // y
                table.pose.theta = 3.14 / 2;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet2.table = table;
                // 椅子の定義
                /*for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet2.chairs.push_back(chair);
                }*/
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet2);

                // table3
                printeps_hsr_modules::HsrTableset tableSet3;
                //テーブルの定義
                table.pose.x = 3.0;           // x
                table.pose.y = 3;             // y
                table.pose.theta = 3.14 / 2;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet3.table = table;
                // 椅子の定義
                /*for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet3.chairs.push_back(chair);
                }*/
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet3);

                // table4
                printeps_hsr_modules::HsrTableset tableSet4;
                //テーブルの定義
                table.pose.x = 2.0;           // x
                table.pose.y = 3;             // y
                table.pose.theta = 3.14 / 2;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet4.table = table;
                // 椅子の定義
                /*for(int i=0;i<4;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14/2*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14/2*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet4.chairs.push_back(chair);
                }*/
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet4);

                // table5
                printeps_hsr_modules::HsrTableset tableSet5;
                //テーブルの定義
                table.pose.x = 1.0;        // x
                table.pose.y = 3.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet5.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet5);

                // table6
                printeps_hsr_modules::HsrTableset tableSet6;
                //テーブルの定義
                table.pose.x = 0.0;        // x
                table.pose.y = 3.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet6.table = table;
                // 椅子の定義
                /*for(int i=0;i<2;i++)
                {
                    chair.pose.x=table.pose.x+chairDistance*cos(3.14*i+table.pose.theta);
                    chair.pose.y=table.pose.y+chairDistance*sin(3.14*i+table.pose.theta);
                    chair.width=chairRadius;
                    tableSet6.chairs.push_back(chair);
                }*/
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet6);

                // table7
                printeps_hsr_modules::HsrTableset tableSet7;
                //テーブルの定義
                table.pose.x = -1.0;       // x
                table.pose.y = 3.0;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet7.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet7);

                // table8
                printeps_hsr_modules::HsrTableset tableSet8;
                //テーブルの定義
                table.pose.x = -0.3;       // x
                table.pose.y = 2.8;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet8.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet8);

                // table9
                printeps_hsr_modules::HsrTableset tableSet9;
                //テーブルの定義
                table.pose.x = 0.0;        // x
                table.pose.y = -3.0;       // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet9.table = table;
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet9);

            } else {
                // table1
                printeps_hsr_modules::HsrTableset tableSet1;
                //テーブルの定義
                table.pose.x = 2.0;           // x
                table.pose.y = -1.0;          // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet1.table = table;
                // 椅子の定義
                for (int i = 0; i < 4; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 / 2 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 / 2 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet1.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet1);

                // table2
                printeps_hsr_modules::HsrTableset tableSet2;
                //テーブルの定義
                table.pose.x = 5.0;           // x
                table.pose.y = -1.0;          // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet2.table = table;
                // 椅子の定義
                for (int i = 0; i < 4; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 / 2 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 / 2 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet2.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet2);

                // table3
                printeps_hsr_modules::HsrTableset tableSet3;
                //テーブルの定義
                table.pose.x = 8.0;           // x
                table.pose.y = -1.0;          // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet3.table = table;
                // 椅子の定義
                for (int i = 0; i < 4; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 / 2 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 / 2 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet3.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet3);

                // table4
                printeps_hsr_modules::HsrTableset tableSet4;
                //テーブルの定義
                table.pose.x = 11.0;          // x
                table.pose.y = -1.0;          // y
                table.pose.theta = 3.14 / 4;  //姿勢
                table.width = tableWidth;     //テーブルの幅
                tableSet4.table = table;
                // 椅子の定義
                for (int i = 0; i < 4; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 / 2 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 / 2 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet4.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet4);

                // table5
                printeps_hsr_modules::HsrTableset tableSet5;
                //テーブルの定義
                table.pose.x = 4.5;       // x
                table.pose.y = -3.5;      // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet5.table = table;
                // 椅子の定義
                for (int i = 0; i < 2; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet5.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet5);

                // table6
                printeps_hsr_modules::HsrTableset tableSet6;
                //テーブルの定義
                table.pose.x = 8;       // x
                table.pose.y = -3.5;      // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet6.table = table;
                // 椅子の定義
                for (int i = 0; i < 2; i++) {
                    chair.pose.x =
                        table.pose.x +
                        chairDistance * cos(3.14 * i + table.pose.theta);
                    chair.pose.y =
                        table.pose.y +
                        chairDistance * sin(3.14 * i + table.pose.theta);
                    chair.width = chairRadius;
                    tableSet6.chairs.push_back(chair);
                }
                // obstacleArrayに追加
                obstacleArray.obstacles.push_back(tableSet6);

                // table7 PET
                printeps_hsr_modules::HsrTableset tableSet71;
                //テーブルの定義
                table.pose.x = 8.5;        // x
                table.pose.y = 2.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet71.table = table;
                obstacleArray.obstacles.push_back(tableSet71);

                printeps_hsr_modules::HsrTableset tableSet72;
                //テーブルの定義 Trush
                table.pose.x = 7.5;        // x
                table.pose.y = 1.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet72.table = table;
                obstacleArray.obstacles.push_back(tableSet72);

                printeps_hsr_modules::HsrTableset tableSet73;

                // table8

                printeps_hsr_modules::HsrTableset tableSet82;
                //テーブルの定義
                table.pose.x = 3.5;        // x
                table.pose.y = 1.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet82.table = table;
                obstacleArray.obstacles.push_back(tableSet82);
                // cout << "table82作成完了" << endl;

                printeps_hsr_modules::HsrTableset tableSet83;

                //テーブルの定義
                table.pose.x = 4.5;        // x
                table.pose.y = 1.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet83.table = table;
                obstacleArray.obstacles.push_back(tableSet83);
                // cout << "table83作成完了" << endl;

                printeps_hsr_modules::HsrTableset tableSet84;

                //テーブルの定義 擬似テーブル（もとくら待機場所：配線エリア）
                table.pose.x = 3.5;        // x
                table.pose.y = 2.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet84.table = table;
                obstacleArray.obstacles.push_back(tableSet84);

                printeps_hsr_modules::HsrTableset tableSet85;

                table.pose.x = 8.5;        // x
                table.pose.y = 1.5;        // y
                table.pose.theta = 0;      //姿勢
                table.width = tableWidth;  //テーブルの幅
                tableSet85.table = table;
                obstacleArray.obstacles.push_back(tableSet85);               
                // cout << "table84作成完了" << endl;
            }
        }

        // publish
        pubObstacles.publish(obstacleArray);
        //障害物情報の確認
        // cout << obstacleArray << endl;
        visualization_msgs::MarkerArray obstacleMarkers =
            this->getObstacleMarker(obstacleArray);
        pubObstacleMarker.publish(obstacleMarkers);
    }
    visualization_msgs::MarkerArray getObstacleMarker(
        printeps_hsr_modules::HsrObstacleArray ObstacleArray) {
        visualization_msgs::MarkerArray obstacleMarkers;
        for (int tableSetNum = 0; tableSetNum < ObstacleArray.obstacles.size();
             tableSetNum++) {
            // tableのマーカー生成
            // cout << "table番号" << tableSetNum << endl;
            visualization_msgs::MarkerArray tableMarkers =
                this->getTableMarkers(
                    ObstacleArray.obstacles[tableSetNum].table, tableSetNum);
            for (int tablePartsNum = 0;
                 tablePartsNum < tableMarkers.markers.size(); tablePartsNum++) {
                obstacleMarkers.markers.push_back(
                    tableMarkers.markers[tablePartsNum]);
            }
            //椅子のマーカー生成
            for (int chairNum = 0;
                 chairNum < ObstacleArray.obstacles[tableSetNum].chairs.size();
                 chairNum++) {
                obstacleMarkers.markers.push_back(this->getChairMarker(
                    ObstacleArray.obstacles[tableSetNum].chairs[chairNum],
                    tableSetNum, chairNum));
            }
        }
        return obstacleMarkers;
    }
    visualization_msgs::MarkerArray getTableMarkers(
        printeps_hsr_modules::HsrObstacle Obstacle, int tableNum) {
        visualization_msgs::MarkerArray tableMarker;

        //パネル
        visualization_msgs::Marker tablePanel;

        tablePanel.header.frame_id = "map";
        tablePanel.header.stamp = ros::Time::now();
        tablePanel.pose.position.x = Obstacle.pose.x;
        tablePanel.pose.position.y = Obstacle.pose.y;
        tablePanel.pose.position.z = 0.7;

        tf::Quaternion quaternion =
            tf::createQuaternionFromRPY(0, 0, Obstacle.pose.theta);
        geometry_msgs::Quaternion quat_Msg;
        quaternionTFToMsg(quaternion, quat_Msg);  //この関数はROSのライブラリ
        tablePanel.pose.orientation = quat_Msg;
        tablePanel.ns = "table/panel";
        tablePanel.id = tableNum;
        tablePanel.type = visualization_msgs::Marker::CUBE;
        tablePanel.action = visualization_msgs::Marker::ADD;

        tablePanel.scale.x = Obstacle.width;
        tablePanel.scale.y = Obstacle.width;
        tablePanel.scale.z = 0.05;

        tablePanel.color.r = (float)115 / 255;
        tablePanel.color.g = (float)66 / 255;
        tablePanel.color.b = (float)41 / 255;
        tablePanel.color.a = 1.0;

        tablePanel.lifetime = ros::Duration(10);

        tableMarker.markers.push_back(tablePanel);

        //脚
        for (int foot = 0; foot < 4; foot++) {
            visualization_msgs::Marker tableFoot;

            tableFoot.header.frame_id = "map";
            tableFoot.header.stamp = ros::Time::now();
            tableFoot.pose.position.x =
                Obstacle.pose.x +
                Obstacle.width * (double)(cos((double)3.14 / 4)) *
                    cos((double)foot * (double)(3.14 / 2) + (double)(3.14 / 4) +
                        Obstacle.pose.theta);
            tableFoot.pose.position.y =
                Obstacle.pose.y +
                Obstacle.width * (double)(cos((double)3.14 / 4)) *
                    sin((double)foot * (double)(3.14 / 2) + (double)(3.14 / 4) +
                        Obstacle.pose.theta);
            tableFoot.pose.position.z = 0.35;

            tableFoot.ns = "table/foot";
            tableFoot.id = tableNum * 4 + foot;
            tableFoot.type = visualization_msgs::Marker::CYLINDER;
            tableFoot.action = visualization_msgs::Marker::ADD;

            tableFoot.scale.x = 0.03;
            tableFoot.scale.y = 0.03;
            tableFoot.scale.z = 0.7;

            tableFoot.color.r = (float)115 / 255;
            tableFoot.color.g = (float)66 / 255;
            tableFoot.color.b = (float)41 / 255;
            tableFoot.color.a = 1.0;

            tableFoot.lifetime = ros::Duration(10000);

            tableMarker.markers.push_back(tableFoot);
        }

        return tableMarker;
    }
    visualization_msgs::Marker getChairMarker(
        printeps_hsr_modules::HsrObstacle Obstacle, int tableNum,
        int chairNum) {
        visualization_msgs::Marker chair;

        chair.header.frame_id = "map";
        chair.header.stamp = ros::Time::now();
        chair.pose.position.x = Obstacle.pose.x;
        chair.pose.position.y = Obstacle.pose.y;
        chair.pose.position.z = 0.2;

        chair.ns = "chair";
        chair.id = tableNum * 10 + chairNum;
        chair.type = visualization_msgs::Marker::CYLINDER;
        chair.action = visualization_msgs::Marker::ADD;

        chair.scale.x = Obstacle.width;
        chair.scale.y = Obstacle.width;
        chair.scale.z = 0.4;

        chair.color.r = (float)115 / 255;
        chair.color.g = (float)66 / 255;
        chair.color.b = (float)41 / 255;
        chair.color.a = 1.0;

        chair.lifetime = ros::Duration(10000);

        return chair;
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "hsr_static_obstacle_server");

    HsrStaticObstacleServer hsrstaticobstacleserver;

    ros::spin();
}
