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
###                          pepper_motion.py                             ###
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
import sys
import rospy
import copy
import tf
import std_msgs
import sensor_msgs
import geometry_msgs
import math
import tf.transformations
from std_msgs.msg       import String
from sensor_msgs.msg        import LaserScan
from geometry_msgs.msg      import PoseStamped, Point, Quaternion
from geometry_msgs.msg      import Pose2D, Twist
from geometry_msgs.msg      import PoseWithCovarianceStamped
from printeps_pepper_modules.srv    import PepperNav
from printeps_pepper_modules.srv    import PepperNavResponse
from printeps_pepper_modules.srv    import PepperSpeak
from printeps_pepper_modules.srv    import PepperSpeakResponse



################################################################################
#                             Pepper Navigation                                #
################################################################################
class PepperTableButton:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n============== Pepper Table Button ==============="

        # Initialize node ------------------------------------------------------
        rospy.init_node("pepper_table_button")

        # ServiceClient --------------------------------------------------------
        self.pepper_speak_client    = rospy.ServiceProxy('/printeps/dialogue/pepper_speak', PepperSpeak)

        #  Publisher ----------------------------------------------------
        self.clean_up_response_publisher    = rospy.Publisher('clean_up_response', String, queue_size=1)


    #===========================================================================
    #   Launch Subscriber
    #===========================================================================
    def launchSubscriber(self):

        # Clean up Subscriber --------------------------------------------------
        clean_up_subscriber  = rospy.Subscriber('clean_up', String, self.cleanUpCallback)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()



    #===========================================================================
    #   Clean up Callback
    #===========================================================================
    def cleanUpCallback(self, order):
        
        print "テーブルからの指令: " + order.data
        reseponse   = order.data[:6]

        pepper_speak            = PepperSpeak()
        pepper_speak.ip_address = "192.168.1.16"
        pepper_speak.contents   = "テーブル" + str(order.data[5]) + "に行って、ゴミ受け取ってもろて"

        self.pepper_speak_client(pepper_speak.ip_address,pepper_speak.contents)

        #self.clean_up_response_publisher.publish(reseponse)



################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    staff   = PepperTableButton()
    staff.launchSubscriber()
