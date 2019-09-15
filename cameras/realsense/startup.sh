#!/usr/bin/env bash

source /home/catkin_ws/devel/setup.bash && \
#export ROS_MASTER_URI=http://${SERVER_IP}:11311 && \
#export ROS_TP=${CLIENT_IP} && \
#roslaunch realsense2_camera rs_rgbd.launch align_depth:=true camera:=rs01
#roslaunch realsense2_camera rs_rgbd.launch align_depth:=true camera:=rs02
roslaunch realsense2_camera rs_multiple_cameras.launch align_depth:=true camera1:=rs00 serial_no_camera1:=838212070676  camera2:=rs01 serial_no_camera2:=838212072328
#roslaunch realsense2_camera rs_rgbd.launch align_depth:=true camera1:=rs01 serial_no_camera1:=838212070676
#roslaunch realsense2_camera rs_rgbd.launch align_depth:=true camera:=rs02
 