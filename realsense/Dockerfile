# ros-kinetic full
FROM osrf/ros:kinetic-desktop-full

#####################################################################
##                              Common                             ##
#####################################################################

# install ifconfig & ping
RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools

##############################################################################
##                              ROS Initialize                              ##
##############################################################################

RUN mkdir -p /home/catkin_ws/src

# for catkin build
RUN apt-get update && apt-get install -y \
    python-catkin-tools
WORKDIR /home/catkin_ws
RUN	/bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin init" && \
	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc && \
	echo "source /home/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
	echo "export ROS_PACKAGE_PATH=\${ROS_PACKAGE_PATH}:/home/catkin_ws" >> ~/.bashrc && \
	echo "export ROS_WORKSPACE=/home/catkin_ws" >> ~/.bashrc
  #/bin/bash -c "source ~/.bashrc"


##################################################################################
##                              Realsense 環境構築                              ##
##################################################################################

# install add-apt-repository
RUN apt-get update && apt-get install -y \
    software-properties-common

# 2.24.0-0~realsense0.1315
RUN apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE && \
    add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u && \
    apt-get update && \
    version="2.23.0-0~realsense0.1165" && \
    apt-get install  -y \
    librealsense2-dkms \
    librealsense2=${version} \
    librealsense2-gl=${version} \
    librealsense2-utils=${version} \
    librealsense2-dev=${version} \
    librealsense2-dbg=${version} \
    ros-kinetic-rgbd-launch

COPY /packages/realsense /home/catkin_ws/src/realsense

# for catkin_make
#WORKDIR /home/catkin_ws
#RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release" && \
#    /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make install" 

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin build" 

RUN echo "export PS1='\[\e[1;34m\]DOCKER REALSENSE\[\e[0m\] \u:\w\$'" >> ~/.bashrc

####################################################################################
##                              docker run後の処理用                              ##
####################################################################################

# ROS MATERのIP設定 run.shで上書き可能
ENV SERVER_IP 172.16.0.2
ENV CLIENT_IP 172.16.0.3

COPY /startup.sh /home/startup.sh
RUN chmod 744 /home/startup.sh
ENTRYPOINT ["/bin/bash"]