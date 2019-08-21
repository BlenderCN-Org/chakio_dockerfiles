#!/usr/bin/env bash

source /home/catkin_ws/devel/setup.bash && \
#export ROS_MASTER_URI=http://${SERVER_IP}:11311 && \
#export ROS_TP=${CLIENT_IP} && \
roslaunch realsense2_camera rs_rgbd.launch align_depth:=true
