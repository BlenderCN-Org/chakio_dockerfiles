#!/usr/bin/python
# -*- coding: utf-8 -*-
#############################################################################
#####################  K E I O  U N I V E R S I T Y  ########################
#############################################################################
################################  Python  ###################################
#############################################################################
#############################################################################
#########  Yamaguchi Lab., Department of Administration Engineering  ########
#############################################################################
#############################################################################
###                        hsr_place_object.py                            ###
###                                                                       ###
###                   composed by Ayanori Yorozu                          ###
###                   at Keio Advanced Research Centers, Keio University  ###
###                                                                       ###
###                               Copyright (2016), All rights reserved.  ###
###                                                                       ###
###             c/o. Yamagughi Lab., Dept. of Administration Engineering, ###
###             3-14-1 Hiyoshi, Kohoku-ku, Yokohama 223-8522              ###
###             E-mail: yamaguti@ae.keio.ac.jp                            ###
#############################################################################
#############################################################################

################################################################################
#                                   Import                                     #
################################################################################
import hsrb_interface
import sys
import rospy
import copy
import tf
import math
import std_msgs
import sensor_msgs
import geometry_msgs
import tf.transformations
from std_msgs.msg import String
from sensor_msgs.msg    import LaserScan
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from hsrb_interface     import geometry
from printeps_hsr_modules.srv  import HsrPlaceObject
from printeps_hsr_modules.srv   import HsrPlaceObjectResponse
from geometry_msgs.msg  import WrenchStamped
from sensor_msgs.msg  import JointState

import controller_manager_msgs.srv
import trajectory_msgs.msg


#! /usr/bin/env python  
  
import re  

################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')
  
class AcpiChecker():  
    def __init__(self, battery_name):  
        print "\n================ HSR PC BatteryCheck ================="
        rospy.Timer(rospy.Duration(1), self.timer_cb)
        self._info_path = "/sys/class/power_supply/" + battery_name + "/capacity"  
        self._state_path = "/sys/class/power_supply/" + battery_name + "/status"  
        self.before=100
    def battery_checker(self):  
        rospy.spin()
    def timer_cb(self,event):
        if self.get_state()=="Discharging":
            if int(self.before/10)-int(self.get_capacity()/10)>=1:
                talk="PCの充電は残り"+str(int(self.get_capacity()))+"パーセントです."
                tts.say(talk)
        self.before=self.get_capacity()

    def get_capacity(self):  
        f = open(self._info_path)  
        #print f
        for index,line in enumerate(f) :
            if index==0:
                capacity = line
        capacity = float(capacity.splitlines()[0])
        f.close()  
        return capacity  
  
    def get_state(self):  
        f = open(self._state_path)  
        #print f
       
        for index,line in enumerate(f) :
            if index==0:
                state = line
        state = state.splitlines()[0]
        f.close() 
        return str(state)  
  
if __name__=='__main__':  
    checker = AcpiChecker('BAT1')  
    checker.battery_checker() 