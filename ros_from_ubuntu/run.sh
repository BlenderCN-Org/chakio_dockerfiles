xhost +local:user
docker run -it \
--rm \
-v "/home/$(whoami)/catkin_ws/:/catkin_ws/" \
--net host \
ros:ros-from-ubuntu \
