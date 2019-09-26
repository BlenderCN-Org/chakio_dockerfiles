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
###                           hsr_motion.py                               ###
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
from printeps_hsr_modules.srv   import HsrSay
from printeps_hsr_modules.srv   import HsrSayResponse
from printeps_hsr_modules.srv   import HsrPickUpObject
from printeps_hsr_modules.srv   import HsrPickUpObjectResponse
from printeps_hsr_modules.srv   import HsrPlaceObject
from printeps_hsr_modules.srv   import HsrPlaceObjectResponse
from printeps_hsr_modules.srv   import HsrHoldObject
from printeps_hsr_modules.srv   import HsrHoldObjectResponse
from printeps_hsr_modules.srv   import HsrReleaseObject
from printeps_hsr_modules.srv   import HsrReleaseObjectResponse

################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':
    # Initialize node ------------------------------------------------------
    rospy.init_node("hsr_demo")

    # ServiceClient ------------------------------------------------------------

        # Say Server -----------------------------------------------------------
    tts_client = rospy.ServiceProxy('hsr_say', HsrSay)

        # Navigation Server ----------------------------------------------------
    nav_client  = rospy.ServiceProxy('hsr_navigation', HsrNav)

        # Navigation Server ----------------------------------------------------
    nav2_client  = rospy.ServiceProxy('hsr_navigation2', HsrNav2)

        # PickUpObject Server --------------------------------------------------------
    pick_up_client = rospy.ServiceProxy('hsr_pick_up_object', HsrPickUpObject)

        # Place Server --------------------------------------------------------
    place_client = rospy.ServiceProxy('hsr_place_object', HsrPlaceObject)

        # Hold Server --------------------------------------------------------
    hold_client = rospy.ServiceProxy('hsr_hold_object', HsrHoldObject)

        # Release Server --------------------------------------------------------
    release_client = rospy.ServiceProxy('hsr_release_object', HsrReleaseObject)
        
    sayMotion      =    HsrSay()
    navMotion      =    HsrNav()
    nav2Motion     =    HsrNav2()
    pickupMotion   =    HsrPickUpObject()
    placeMotion    =    HsrPlaceObject()
    holdMotion     =    HsrHoldObject()
    releaseMotion  =    HsrReleaseObject()

    # position setting ---------------------------------------------------------
    facalty=False;
    if facalty:
        #pet
        Pet                 =Pose2D()
        Pet.x               =0.60
        Pet.y               =-1.30
        Pet.theta           =-1.57

        #Table
        Table                 =Pose2D()
        Table.x               = 2.90
        Table.y               = -1.30
        Table.theta           =-1.57
    else:
        #pet
        Pet                 =Pose2D()
        Pet.x               =0.60
        Pet.y               =-1.30
        Pet.theta           =-1.57

        #Table
        Table                 =Pose2D()
        Table.x               = 2.90
        Table.y               = -1.30
        Table.theta           =-1.57

        # PetFromCart
    PetFromCart         =Pose2D()
    PetFromCart.x       = Pet.x
    PetFromCart.y       = Pet.y+0.70
    PetFromCart.theta   =-1.57

        # CartFromPet
    CartFromPet         =Pose2D()   
    CartFromPet.x       =Pet.x
    CartFromPet.y       =Pet.y+0.70 
    CartFromPet.theta   =0

        # CartToTable
    CartToTable         =Pose2D() 
    CartToTable.x       =Table.x + 0.5
    CartToTable.y       =Table.y + 0.5
    CartToTable.theta   =0

        # CartFromTable
    CartFromTable       =Pose2D() 
    CartFromTable.x     =Table.x+0.4
    CartFromTable.y     =Table.y+0.7
    CartFromTable.theta =0  

        # TableFromCart
    TableFromCart       =Pose2D()
    TableFromCart.x     =Table.x
    TableFromCart.y     =Table.y+0.70;
    TableFromCart.theta =-1.57  

        # CartToPet
    CartToPet           =Pose2D() 
    CartToPet.x         =Pet.x+0.3
    CartToPet.y         =Pet.y+0.5
    CartToPet.theta     =0

        # 0
        # PetFromCart
    Genten              =Pose2D()
    Genten.x            =0
    Genten.y            =0
    Genten.theta        =0



    # 動作 ---------------------------------------------------------

    """
    sayMotion='げんてんにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose＝Genten
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    """
    sayMotion='たなにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose=PetFromCart
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    
    sayMotion='かーとにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose=CartFromPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    
    sayMotion='かーとをおします'
    tts_client(sayMotion)
    nav2Motion.pose=CartToTable
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    
    sayMotion='てーぶるにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose=TableFromCart
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    """
    sayMotion='かーとにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose＝CartFromTable
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)

    sayMotion='たなにむかいます'
    tts_client(sayMotion)
    nav2Motion.pose＝CartToPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    """