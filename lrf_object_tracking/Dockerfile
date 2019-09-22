# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:xenial
#######################################################################
##                            ros install                            ##
#######################################################################

# install packages
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-core=1.3.2-0* \
    ros-kinetic-desktop-full=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

#######################################################################
##                       install nvidia docker                       ##
#######################################################################

RUN apt-get update && apt-get install -y --no-install-recommends \
       pkg-config \
       libxau-dev \
       libxdmcp-dev \
       libxcb1-dev \
       libxext-dev \
       libx11-dev && \
   rm -rf /var/lib/apt/lists/*
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
 /usr/local/lib/x86_64-linux-gnu \
 /usr/local/lib/x86_64-linux-gnu
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
 /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
 /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json
RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
   ldconfig && \
   echo '/usr/local/$LIB/libGL.so.1' >> /etc/ld.so.preload && \
   echo '/usr/local/$LIB/libEGL.so.1' >> /etc/ld.so.preload
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
   ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
   ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

#######################################################################
##                   install additional packages                     ##
#######################################################################
# install opencv
RUN apt-get update && apt-get install -y libopencv-dev \
      net-tools \
      gedit \
      ros-kinetic-map-server \
      ros-kinetic-urg-node \
      && rm -rf /var/lib/apt/lists/*
#######################################################################
##                           ros settings                            ##
#######################################################################
RUN echo "export PS1='\[\e[1;31;40m\]LRF_POSE_SERVER\[\e[0m\] \u:\w\$ '">> ~/.bashrc
RUN echo "source /ros_setting.sh">> ~/.bashrc

