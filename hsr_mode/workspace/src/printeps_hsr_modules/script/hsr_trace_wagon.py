#!/usr/bin/python
# -*- coding: utf-8 -*-

################################################################################
#                                   Import                                     #
################################################################################
import csv
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

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
from geometry_msgs.msg  import Pose2D, Twist,Point
from geometry_msgs.msg  import PoseWithCovarianceStamped
from geometry_msgs.msg  import PoseArray

from nav_msgs.msg       import Odometry

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
#                               HSR Trace Wagon                                #
################################################################################
class HSRTraceWagon:
    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Trace Wagon ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_navigation")

        # 速度指令 Publisher ----------------------------------------------------
        self.cmd_vel_publisher      = rospy.Publisher('hsrb/command_velocity', geometry_msgs.msg.Twist, queue_size=1)

        # 最大速度設定 rosparam --------------------------------------------------
        self.max_linear_vel     = 0.2
        self.max_angular_vel    = 0.2
        
        self.actualCmdVX = [0]
        self.actualCmdVY = [0]
        self.actualCmdOmega = [0]
        self.actualCmdTime = [0]
        
        self.referenceCmdVX = [0]
        self.referenceCmdVY = [0]
        self.referenceCmdOmega = [0]
        self.referenceCmdTime = [0]
        
        self.savedCmdVX = 0
        self.savedCmdVY = 0
        self.savedCmdOmega = 0
        
        plt.figure()
        plt.subplot(3,1,1)
        plt.plot(self.referenceCmdTime,self.referenceCmdOmega)
        plt.plot(self.actualCmdTime,self.actualCmdOmega)
        plt.subplot(3,1,2)
        plt.plot(self.referenceCmdTime,self.referenceCmdVX)
        plt.plot(self.actualCmdTime,self.actualCmdVX)
        plt.subplot(3,1,3)
        plt.plot(self.referenceCmdTime,self.referenceCmdVY)
        plt.plot(self.actualCmdTime,self.actualCmdVY)
      
        self.axes =plt.gcf().get_axes()
        self.lines1 = self.axes[0].get_lines()
        self.lines2 = self.axes[1].get_lines()
        self.lines3 = self.axes[2].get_lines()
        
        self.axes[0].set_ylim(-self.max_angular_vel, self.max_angular_vel )
        self.axes[1].set_ylim(-self.max_linear_vel, self.max_linear_vel )
        self.axes[2].set_ylim(-self.max_linear_vel, self.max_linear_vel )
        
        self.record = False

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):
        #TF Listener------------------------------------------------------------
        self.tf_listener    = tf.TransformListener()

        # Path Subscriber ---------------------------------------------------
        path_subscriber     = rospy.Subscriber('/path', PoseArray, self.pathCallback)
        cmd_subscriber      = rospy.Subscriber('hsrb/command_velocity', Twist, self.cmdCallback)
        actualCmd_subscriber= rospy.Subscriber('/hsrb/wheel_odom', Odometry, self.actualCmdCallback)
        traceCmd_subscriber = rospy.Subscriber('/trace', String, self.traceCmdCallback)
        
        #rospy.Timer(rospy.Duration(0.01), self.tracing)
        rospy.loginfo("Ready to serve command.")
        while not rospy.is_shutdown():
            assert len(self.referenceCmdOmega) == len(self.referenceCmdTime), 'omega length error' 
            # print"10"
            self.lines1[0].set_xdata(np.array(self.referenceCmdTime))
            self.lines1[0].set_ydata(np.array(self.referenceCmdOmega))
            # print "time"
            # print len(self.referenceCmdTime)
            # print "referenceCmdOmega"
            # print len(self.referenceCmdOmega)
            #print"11"
            assert len(self.actualCmdOmega) == len(self.referenceCmdTime), 'actual omega length error'
            
            self.lines1[1].set_xdata(np.array(self.referenceCmdTime))
            self.lines1[1].set_ydata(np.array(self.actualCmdOmega))
            # print "actualCmdOmega"
            # print len(self.actualCmdOmega)
            
            #print"20"
            assert len(self.referenceCmdVX) == len(self.referenceCmdTime), 'ref VX length error'
            
            self.lines2[0].set_xdata(np.array(self.referenceCmdTime))
            self.lines2[0].set_ydata(np.array(self.referenceCmdVX))
            # print "referenceCmdVX"
            # print len(self.referenceCmdVX)
            #print"21"
            
            assert len(self.actualCmdVX) == len(self.referenceCmdTime), 'act VX length error'
            self.lines2[1].set_xdata(np.array(self.referenceCmdTime))
            self.lines2[1].set_ydata(np.array(self.actualCmdVX))
            print "actualCmdVX"
            print len(self.actualCmdVX)
            
            #print"30"
            assert len(self.referenceCmdVY) == len(self.referenceCmdTime), 'ref VY length error'
            self.lines3[0].set_xdata(np.array(self.referenceCmdTime))
            self.lines3[0].set_ydata(np.array(self.referenceCmdVY))
            print "referenceCmdVY"
            print len(self.referenceCmdVY)
            #print"31"
            
            assert len(self.referenceCmdVY) == len(self.referenceCmdTime), 'act VY length error'
            self.lines3[1].set_xdata(np.array(self.referenceCmdTime))
            self.lines3[1].set_ydata(np.array(self.actualCmdVY))
            print "actualCmdVY"
            print len(self.actualCmdVY)
            
            self.axes[0].set_xlim(min(self.referenceCmdTime), max(self.referenceCmdTime))
            self.axes[1].set_xlim(min(self.referenceCmdTime), max(self.referenceCmdTime))
            self.axes[2].set_xlim(min(self.referenceCmdTime), max(self.referenceCmdTime))
 
            plt.draw()
            plt.pause(0.01)
        
        rospy.spin()
    
    #===========================================================================
    #   Get Trace Cmd
    #===========================================================================
    def traceCmdCallback(self, traceData):
        if traceData.data == "start":
            self.record = True
            self.actualCmdOmega = [0]
            self.actualCmdVX = [0]
            self.actualCmdVY = [0]
            self.actualCmdTime = [0]
            self.referenceCmdVX = [0]
            self.referenceCmdVY = [0]
            self.referenceCmdOmega = [0]
            self.referenceCmdTime = [0]
            self.startTime = rospy.get_time()
        elif traceData.data == "end":
            self.record = False
        print traceData.data

    #===========================================================================
    #   Get Path
    #===========================================================================
    def pathCallback(self, pathData):
        pass
        #print "getPath"
        
    #===========================================================================
    #   Get Actual Cmd
    #===========================================================================
    def actualCmdCallback(self, cmdData):
        if self.record:
            self.actualCmdVX.append(cmdData.twist.twist.linear.x)
            self.actualCmdVY.append(cmdData.twist.twist.linear.y)
            self.actualCmdOmega.append(cmdData.twist.twist.angular.z)
            self.actualCmdTime.append(rospy.get_time()-self.startTime)
            
            self.referenceCmdVX.append(self.savedCmdVX)
            self.referenceCmdVY.append(self.savedCmdVY)
            self.referenceCmdOmega.append(self.savedCmdOmega)
            self.referenceCmdTime.append(rospy.get_time()-self.startTime)
        pass
        #print "getPath"
        
    #===========================================================================
    #   Get Reference Cmd
    #===========================================================================
    def cmdCallback(self, cmdData):
        if self.record:
            self.savedCmdVX = cmdData.linear.x
            self.savedCmdVY = cmdData.linear.y
            self.savedCmdOmega = cmdData.angular.z
        #print "getPath"
        pass

################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRTraceWagon()
    hsr.launchServer()