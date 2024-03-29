xhost +local:user
docker run -it \
--runtime=nvidia \
--env=DISPLAY=$DISPLAY \
--name ros-kinect-v2-env_cam02 \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--env="QT_X11_NO_MITSHM=1" \
--rm \
-v "/$(pwd)/ros_setting.sh:/ros_setting.sh" \
-v "/$(pwd)/startup/cam02_startup.sh:/startup.sh" \
-v /etc/group:/etc/group:ro \
-v /etc/passwd:/etc/passwd:ro \
--net host \
--privileged \
ros:ros-kinect-v2

#--device /dev/bus/usb/010/006 \

# how to show usb list
# lsusb -t
# cd /dev/bus/usb
# --device /dev/bus/usb/(bus)/(dev) 