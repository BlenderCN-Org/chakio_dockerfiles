xhost +local:user
docker run -it \
--runtime=nvidia \
--env=DISPLAY=$DISPLAY \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--env="QT_X11_NO_MITSHM=1" \
--rm \
-v "/home/$(whoami)/chakio_ros_ws/:/catkin_ws/" \
-v /etc/group:/etc/group:ro \
-v /etc/passwd:/etc/passwd:ro \
--net host \
ros:ros-gui-develop \