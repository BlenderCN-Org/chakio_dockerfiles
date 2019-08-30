FROM osrf/ros:kinetic-desktop-full
# install ros tutorials packages
RUN apt-get update && apt-get install -y
RUN apt-get install -y ros-kinetic-ros-tutorials \
    ros-kinetic-common-tutorials 
RUN apt-get install -y libopencv-dev \
    && rm -rf /var/lib/apt/lists/
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export ROS_MASTER_URI=http://192.168.1.211:11311" >> ~/.bashrc