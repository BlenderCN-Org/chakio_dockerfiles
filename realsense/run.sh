#!/bin/sh

docker run -it \
    --rm \
    --privileged \
    --name realsense \
    --net host \
    -v "/$(pwd)/ros_setting.sh:/ros_setting.sh" \
    realsense:1.4 \
    #/home/startup.sh
    
    #--env SERVER_IP=172.17.0.1 \
    #--env CLIENT_IP=172.17.0.2 \ 
    #--net=ros_net \
    #--ip=${CLIENT_IP} \
    #
   
