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
        
    navMotion      =    HsrNav()
    nav2Motion     =    HsrNav2()
    pickupMotion   =    HsrPickUpObject()
    placeMotion    =    HsrPlaceObject()
    holdMotion     =    HsrHoldObject()
    releaseMotion  =    HsrReleaseObject()

    # position setting ---------------------------------------------------------
    facalty=True;
    if facalty:
        #pet
        Pet                 =Pose2D()
        Pet.x               =2.70
        Pet.y               =-0.80
        Pet.theta           =-1.57

        #Table
        Table                 =Pose2D()
        Table.x               = 4.70
        Table.y               = 2.10
        Table.theta           =0
    else:
        #pet
        Pet                 =Pose2D()
        Pet.x               =0.60
        Pet.y               =-1.30
        Pet.theta           =-1.57

        #Table
        Table                 =Pose2D()
        Table.x               = 2.50
        Table.y               = 0.60
        Table.theta           = 0

        # PetFromCart
    PetFromCart         =Pose2D()
    PetFromCart.x       = Pet.x
    PetFromCart.y       = Pet.y+0.70
    PetFromCart.theta   =-1.57

        # CartFromPet
    CartFromPet         =Pose2D()   
    CartFromPet.x       =Pet.x-0.10
    CartFromPet.y       =Pet.y+0.60 
    CartFromPet.theta   =0

        # CartToTable
    CartToTable         =Pose2D() 
    CartToTable.x       =Table.x-0.3;
    CartToTable.y       =Pet.y + 0.4
    CartToTable.theta   =0

        # CartFromTable
    CartFromTable       =Pose2D() 
    CartFromTable.x     =Table.x-0.60
    CartFromTable.y     =Pet.y+0.60
    CartFromTable.theta =0  

        # TableFromCart
    TableFromCart       =Pose2D()
    TableFromCart.x     =Table.x-0.60;
    TableFromCart.y     =Table.y;
    TableFromCart.theta =0 

        # CartToPet
    CartToPet           =Pose2D() 
    CartToPet.x         =Pet.x+0.7
    CartToPet.y         =Pet.y+0.3
    CartToPet.theta     =0

        # 0
        # PetFromCart
    Genten              =Pose2D()
    Genten.x            =0
    Genten.y            =0
    Genten.theta        =0




    # 動作 ---------------------------------------------------------------------

    
# phase:1 ペットボトルをカートに置く
# 1
    # 棚の前に移動する
    nav2Motion.pose=PetFromCart
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # 棚からペットボトル1をとる
    pickupMotion='Pet1'
    pick_up_client(pickupMotion)
    # カートの前に移動する
    nav2Motion.pose=CartFromPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートの1番に置く
    placeMotion = 'Cart3'
    place_client(placeMotion)

#2
    # 棚の前に移動する
    nav2Motion.pose=PetFromCart    
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # 棚からペットボトル2をとる
    pickupMotion='Pet2'
    pick_up_client(pickupMotion)
    # カートの前に移動する
    nav2Motion.pose=CartFromPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートの2番に置く
    placeMotion = 'Cart4'
    place_client(placeMotion)



    
# phase:2 カートをテーブルの前に移動させる
    # カートの前に移動する
    nav2Motion.pose=CartFromPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートをつかむ
    holdMotion='Cart'
    hold_client(holdMotion)
    # テーブルの前まで移動する
    nav2Motion.pose=CartToTable
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートを離す
    releaseMotion='Cart'
    release_client(releaseMotion)


# phase:3 カートからテーブルにペットボトルを移動させる

#1
    # カートの前に移動する
    nav2Motion.pose=CartFromTable
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートの4番からペットボトルをとる
    pickupMotion='Cart4'
    pick_up_client(pickupMotion)
    # テーブルの横に移動する
    # テーブルの前に移動する
    nav2Motion.pose=TableFromCart
    nav2Motion.obstacle_avoidance=True
    nav2Motion.first_rot=True
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # テーブルの1番に置く
    placeMotion = 'Table31'
    place_client(placeMotion)

#2
    # カートの前に移動する
    nav2Motion.pose=CartFromTable
    nav2Motion.obstacle_avoidance=True
    nav2Motion.first_rot=True
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートの3番からペットボトルをとる
    pickupMotion='Cart3'
    pick_up_client(pickupMotion)
    # テーブルの横に移動する
    # テーブルの前に移動する
    nav2Motion.pose=TableFromCart
    nav2Motion.obstacle_avoidance=True
    nav2Motion.first_rot=True
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # テーブルの2番に置く
    placeMotion = 'Table32'
    place_client(placeMotion)


    
# phase:4 カートを棚の前に移動させる
    # カートの前に移動する
    nav2Motion.pose=CartFromTable
    nav2Motion.obstacle_avoidance=True
    nav2Motion.first_rot=True
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートをつかむ
    holdMotion='Cart'
    hold_client(holdMotion)
    # 棚の前まで移動する
    nav2Motion.pose=CartFromPet
    nav2Motion.obstacle_avoidance=False
    nav2Motion.first_rot=False
    nav2_client(nav2Motion.pose,nav2Motion.obstacle_avoidance,nav2Motion.first_rot)
    # カートを離す
    releaseMotion='Cart'
    release_client(releaseMotion)