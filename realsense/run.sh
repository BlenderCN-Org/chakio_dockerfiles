#!/bin/sh

docker run -it \
    --rm \
    --privileged \
    --name realsense \
    --net host \
    --env SERVER_IP=172.17.0.1 \
    --env CLIENT_IP=172.17.0.2 \
    realsense:1.4 \
    /home/startup.sh 
    #--net=ros_net \
    #--ip=${CLIENT_IP} \
    #
   
