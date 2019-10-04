xhost +local:user
docker run -it \
--runtime=nvidia \
--env=DISPLAY=$DISPLAY \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--env="QT_X11_NO_MITSHM=1" \
--rm \
-v "/$(pwd)/../global_setting/global_ros_setting.sh:/ros_setting.sh" \
-v "/home/$(whoami)/chakio_hsr_ws/:/catkin_ws/" \
-v "/home/$(whoami)/catkin_ws/src/printeps_navigation/:/catkin_ws/src/printeps_navigation/" \
-v /etc/group:/etc/group:ro \
-v /etc/passwd:/etc/passwd:ro \
--privileged \
--net host \
chakio_docker:hsr-mode \