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
from sensor_msgs.msg    import LaserScan
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from hsrb_interface     import geometry
from geometry_msgs.msg  import Pose2D, Twist
from geometry_msgs.msg  import PoseWithCovarianceStamped
from printeps_hsr_modules.srv   import HsrNav
from printeps_hsr_modules.srv   import HsrNavResponse
from printeps_hsr_modules.srv   import HsrNav2
from printeps_hsr_modules.srv   import HsrNav2Response
from printeps_hsr_modules.srv   import HsrNav3
from printeps_hsr_modules.srv   import HsrNav3Response
from printeps_hsr_modules.srv   import HsrNav3
from printeps_hsr_modules.srv   import HsrNav3Response

################################################################################
#                             Grobal Definition                                #
################################################################################



################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':
    rospy.init_node("hsr_KartTest")
    cmd_vel_publisher      = rospy.Publisher('hsrb/command_velocity', geometry_msgs.msg.Twist, queue_size=4)
    msg_publisher      = rospy.Publisher('hsr_logging', std_msgs.msg.String, queue_size=100)
    starttime=rospy.get_time()
    cmd_vel = geometry_msgs.msg.Twist()
    r               = rospy.Rate(50)     # 20Hz
    starttime=rospy.get_time()
    msgg=std_msgs.msg.String()

    msgg.data='Start'
    while (rospy.get_time()-starttime<1):
        
        
        cmd_vel.linear.x    = 0
        cmd_vel.linear.y    = 0.0
        cmd_vel.linear.z    = 0.0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        cmd_vel.angular.z   = 0.0

        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()
    starttime=rospy.get_time()

    msg_publisher.publish(msgg)
    while (rospy.get_time()-starttime<2):
        
            
        cmd_vel.linear.x    = 0
        cmd_vel.linear.y    = 0.0
        cmd_vel.linear.z    = 0.0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        #cmd_vel.angular.z   = 0
        
        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()
    starttime=rospy.get_time()
    while (rospy.get_time()-starttime<10):
        
            
        cmd_vel.linear.x    = 0.3
        #cmd_vel.linear.y    = -0.3*0
        cmd_vel.linear.y    = 0.0
        cmd_vel.linear.z    = 0.0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        cmd_vel.angular.z   = -0.0
        
        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()

    
    starttime=rospy.get_time()
    while (rospy.get_time()-starttime<12):
        
            
        cmd_vel.linear.x    = 0
        cmd_vel.linear.y    = 0.0
        cmd_vel.linear.z    = 0.0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        cmd_vel.angular.z   = 0
        
        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()
    """
    starttime=rospy.get_time()
    while (rospy.get_time()-starttime<4):
        
            
        cmd_vel.linear.x    = -0.3
        cmd_vel.linear.y    = 0.3*0
        cmd_vel.linear.y    = -0.3
        cmd_vel.linear.z    = 0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        cmd_vel.angular.z   = 0.3
        
        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()

    starttime=rospy.get_time()

    while (rospy.get_time()-starttime<2):
        
            
        cmd_vel.linear.x    = 0
        cmd_vel.linear.y    = 0.0
        cmd_vel.linear.z    = 0.0

        # 回転運動: 移動方向
        #cmd_vel.angular.x   = 0.0
        #cmd_vel.angular.y   = 0.0
        cmd_vel.angular.z   = 0
        
        cmd_vel_publisher.publish(cmd_vel)

        # print "ROT1: ", the_dir_angle*180.0/math.pi

        r.sleep()
    """
    msgg.data='End'
    msg_publisher.publish(msgg)