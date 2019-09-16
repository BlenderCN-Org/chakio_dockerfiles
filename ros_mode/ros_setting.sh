## source 
source /catkin_ws/devel/setup.bash

## setting
# network_if=enp60s0
network_if=enp4s0
CATKIN_HOME=/catkin_ws
export ros_master_local=true
export ros_master_global=192.168.1.251
## export
export ROS_HOME=~/.ros
export TARGET_IP=$(LANG=C /sbin/ifconfig $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
else
    export ROS_IP=$TARGET_IP
fi
if [ $ros_master_local=true ]; then
    export ROS_MASTER_URI=http://$TARGET_IP:11311
else
    export ROS_MASTER_URI=http://$ros_master_global:11311
fi
export PS1="\[\e[1;31;40m\]<DOCKER ROS_MODE>\[\e[0m\]\w$ "

## alias
alias cm="cd ${CATKIN_HOME} && catkin_make && cd -"
alias hsrb_mode='export ROS_MASTER_URI=http://hsrb.local:11311 export PS1="\[\033[41;1;37m\]<DOCKER HSRB>\[\033[0m\]\w$ "'

## echo
echo "ROS_IP:"$ROS_IP
echo "ROS_MASTER_URI:"$ROS_MASTER_URI