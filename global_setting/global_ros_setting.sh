## source 
source /catkin_ws/devel/setup.bash

## setting
if [ $HOSTNAME = ytpc2019a ] ; then
    network_if=enp4s0
elif [ $HOSTNAME = dlbox ] ; then
    network_if=eno01
elif [ $HOSTNAME = ytnpc2019c ] ; then
    network_if=enp60s0
elif [ $HOSTNAME = ytnpc2018b ] ; then
    network_if=enp60s0
else
    network_if=enp60s0
fi 
CATKIN_HOME=/catkin_ws

## export
#export ros_master=global
export ros_master=local
#export ros_master_global=192.168.1.55
export hsr_ip=192.168.1.47
export dlbox_ip=192.168.1.55

export ROS_HOME=~/.ros

echo "HOSTNAME : "$HOSTNAME
echo "network_if : "$network_if
export TARGET_IP=$(LANG=C /sbin/ifconfig $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
else
    export ROS_IP=$TARGET_IP
fi
if [ ${ros_master} = local ] ; then
    echo "ROS_MASER : LOCAL" 
    export ROS_MASTER_URI=http://$TARGET_IP:11311
else
    echo "ROS_MASER : GLOBAL" 
    export ROS_MASTER_URI=http://$ros_master_global:11311
fi

## alias
cdls()
{
    \cd "$@" && ls
}
alias cd="cdls"
alias cm="cd ${CATKIN_HOME} && catkin_make && cd -"
alias hsrb_mode='export ROS_MASTER_URI=http://${hsr_ip}:11311 export PS1="\[\033[41;1;37m\]<DOCKER HSR_MODE>\[\033[0m\]\w$ "&& echo "ROS_MASTER_URI:"$ROS_MASTER_URI && rosnode kill pose_integrator'
alias dlbox_mode='export ROS_MASTER_URI=http://${dlbox_ip}:11311 export PS1="\[\033[41;1;37m\]<DOCKER DLBOX_MODE>\[\033[0m\]\w$ "&& echo "ROS_MASTER_URI:"$ROS_MASTER_URI'

## echo
echo "ROS_IP:"$ROS_IP
echo "ROS_MASTER_URI:"$ROS_MASTER_URI
echo "==========================="
echo "=LOADED GLOBAL ROS SETTING="
echo "==========================="

