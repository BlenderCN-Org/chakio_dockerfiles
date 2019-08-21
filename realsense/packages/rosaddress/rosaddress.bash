                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        D�ϊ�	&���}5�֛¡�J�����3��X�����S>������wb�24�?��%(5�q�	j����W�B�t"&pk���_����{#-��s�t"N0AW�[_����}��W#!/bin/bash
function _func_rosserver() {
	if [ -z "$ip_addr" ]; then
		echo "No Ethernet connection..."
	else
		echo "There are Ethernet connection"
		export ROS_MASTER_URI=http://${ip_addr}:11311
		export ROS_HOST_NAME=${ip_addr}
		export ROS_IP=${ip_addr}
		export PS1="\[\033[41;1;33m\]<ROS_server>\[\033[0m\]\w$ "
	fi

	env | grep "ROS_MASTER_URI"
	env | grep "ROS_HOST_NAME"
	env | grep "ROS_IP"
}

function _func_rosclient() {
	if [ -z "$1" ]; then
		echo $1
		echo "Input the ROS server's IP address.'"
	else
		if [ -z "$ip_addr" ]; then
			echo "No Ethernet connection..."
		else
			echo "There are Ethernet connection"
			export ROS_MASTER_URI=http://$1:11311
			export ROS_HOST_NAME=${ip_addr}
			export ROS_IP=${ip_addr}
			export PS1="\[\033[44;1;33m\]<ROS_client>\[\033[0m\]\w$ "
		fi
		env | grep "ROS_MASTER_URI"
		env | grep "ROS_HOST_NAME"
		env | grep "ROS_IP"
	fi
}

function _func_roslocal() {
	export ROS_MASTER_URI=http://localhost:11311
	unset ROS_HOST_NAME
	unset ROS_IP
	export PS1="\[\033[42;1;33m\]<ROS_local>\[\033[0m\]\w$ "
	env | grep "ROS_MASTER_URI"
	env | grep "ROS_HOST_NAME"
	env | grep "ROS_IP"
}

function _func_rosexit(){
	export ROS_MASTER_URI=http://localhost:11311
	unset ROS_HOST_NAME
	unset ROS_IP
	export