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
###                         hsr_navigation.py                             ###
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
from std_msgs.msg import Empty
from sensor_msgs.msg     import LaserScan
from geometry_msgs.msg   import PoseStamped, Point, Quaternion
from hsrb_interface      import geometry
from geometry_msgs.msg   import Pose2D, Twist
from geometry_msgs.msg   import PoseWithCovarianceStamped
from nav_msgs.msg import Odometry


################################################################################
#                               HSR Navigation                                 #
################################################################################
class HSRIsActive:
    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR IsActive ================="
        rospy.init_node("hsr_is_active")
        rospy.Timer(rospy.Duration(1), self.timerCallback)

        rospy.loginfo("Ready to serve command.")
        # Odom Subscriber ----------------------------------------------
        
        self.alive_publisher    = rospy.Publisher('/hsr_is_active', Empty, queue_size=10)

        self.Timeout            = 3.0
        self.updateTime         = rospy.Time.now()
        self.odom_subscriber    = rospy.Subscriber('/hsrb/wheel_odom', Odometry, self.odomCallback)
        rospy.spin()


    #===========================================================================
    #   Get Current odom data
    #===========================================================================
    def odomCallback(self, odom):
        self.updateTime=rospy.Time.now()


    #===========================================================================
    #   Get Current Pose
    #===========================================================================
    def timerCallback(self,event):
        if (rospy.Time.now()-self.updateTime).to_sec()<self.Timeout:
            self.alive_publisher.publish()





   
################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRIsActive()


