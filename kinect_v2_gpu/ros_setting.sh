export ROS_HOME=~/.ros
source /catkin_ws/devel/setup.bash
#network_if=enp60s0
network_if=enp60s0
export TARGET_IP=$(LANG=C /sbin/ifconfig $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
else
    export ROS_IP=$TARGET_IP
fi
export ROS_MASTER_URI=http://$TARGET_IP:11311
#export ROS_MASTER_URI=http://192.168.1.212:11311
echo "ROS_IP:"$ROS_IP
echo "ROS_MASTER_URI:"$ROS_MASTER_URI