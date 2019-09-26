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
###                            handoverExam.py                            ###
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
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from hsrb_interface     import geometry
from geometry_msgs.msg  import Pose2D, Twist
from geometry_msgs.msg  import WrenchStamped
from sensor_msgs.msg  import JointState

################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')


################################################################################
#                               HSR Hold Object                                #
################################################################################
class HSRHoldObject(object):

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\================ HSR Hold Object ================="

        # Initialize node ------------------------------------------------------
        # rospy.init_node("hsr_handover")
        rospy.Subscriber("/hsrb/wrist_wrench/raw", WrenchStamped, self.hand_cb)
        rospy.Subscriber("/hsrb/joint_states", JointState, self.gripper_cb)
        # launchServer()

    

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Hold Server --------------------------------------------------------
        # Hold_server = rospy.Service('hsr_hold_object', HsrHoldObject, self.holdObjectHandler)

        rospy.loginfo("Ready to serve command.")
        

    #===========================================================================
    #   handsensor callback
    #===========================================================================
    def hand_cb(self,data):

      self._force_data_x = data.wrench.force.x
      self._force_data_y = data.wrench.force.y
      self._force_data_z = data.wrench.force.z
    #===========================================================================
    #   handsensor callback
    #===========================================================================
    def gripper_cb(self,data):
        for n in range(1,len(data.name)):
            
            if data.name[n]=='hand_motor_joint':
                self.gripperDigree=data.position[n]
            if data.name[n]=='arm_lift_joint':
                self.liftDigree=data.position[n]
                print self.liftDigree
    #==============================================================
    #   calibration
    #===========================================================================
    def calibration(self):
        print "calibration start"
        self.calib_x=0
        self.calib_y=0
        self.calib_z=0
        self.object_x=0
        self.object_y=0
        self.object_z=0
        count =0
        try:
            while count<100:
                self.calib_x+=self._force_data_x
                self.calib_y+=self._force_data_y
                self.calib_z+=self._force_data_z
                count+=1
                rospy.sleep(0.001)
        except KeyboardInterrupt:
            pass
        self.calib_x/=count
        self.calib_y/=count
        self.calib_z/=count
        print "calibration end"
    #===========================================================================
    #   waiting touch
    #===========================================================================
    def waitingTouch(self,waight):
        print "waitingTouch"
        self.difference_waight=0
        try:
            while self.difference_waight<waight:
                self.difference_x=self._force_data_x-self.calib_x-self.object_x
                self.difference_y=self._force_data_y-self.calib_y-self.object_y
                self.difference_z=self._force_data_z-self.calib_z-self.object_z
                self.difference_all=math.sqrt(self.difference_x*self.difference_x+self.difference_y*self.difference_y+self.difference_z*self.difference_z)
                self.difference_waight=round(self.difference_all / 9.81 * 1000, 1)
            print "Touch!!"
        except KeyboardInterrupt:
            print "aaaa"
            pass

    #===========================================================================
    #   calculate
    #===========================================================================

    def calculateWaight(self):
        print "calculateWaight"
        count=0
        try:
            while count<100:
                self.object_x+=self._force_data_x-self.calib_x
                self.object_y+=self._force_data_y-self.calib_y
                self.object_z+=self._force_data_z-self.calib_z
            
                rospy.sleep(0.001)
                count+=1
        except KeyboardInterrupt:
            print "aaaa"
            pass
        self.object_x/=count
        self.object_y/=count
        self.object_z/=count
        self.object_all=math.sqrt(self.object_x*self.object_x+self.object_y*self.object_y+self.object_z*self.object_z)
        self.object_waight=round(self.object_all / 9.81 * 1000,1)
        print self.object_waight
        a="これは"
        b="グラムです"
        tts.say(a+str(self.object_waight)+b)

    #===========================================================================
    #   main
    #===========================================================================
    def main(self):
        try: 
            

            gripper.command(1.2)
            whole_body.move_to_neutral()
            self.calibration()
            while True:
                gripper.command(0.8)
                rospy.sleep(0.5)
                self.waitingTouch(200)
                gripper.grasp(-0.01)
                if self.gripperDigree<-0.5:
                    tts.say('だれか助けてください')
                else:
                    rospy.sleep(0.5)
                    self.calculateWaight()
                    self.waitingTouch(200)
                    self.object_x=0
                    self.object_y=0
                    self.object_z=0
        except KeyboardInterrupt:
            print "aaaa"
            pass
################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRHoldObject()
    hsr.main()
    