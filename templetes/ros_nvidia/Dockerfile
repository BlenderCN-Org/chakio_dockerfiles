FROM osrf/ros:kinetic-desktop-full
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

# install opencv
RUN apt-get update && apt-get install -y
RUN apt-get install -y libopencv-dev 

# ros additional packages
RUN apt-get install -y ros-kinetic-map-server
RUN apt-get install -y ros-kinetic-amcl
RUN apt-get install -y ros-kinetic-teleop-twist-joy



# set ros
RUN echo "export ROS_IP=192.168.1.218.">> ~/.bashrc
RUN echo "export ROS_HOME=~/.ros">> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export ROS_MASTER_URI=http://192.168.1.221:11311" >> ~/.bashrc