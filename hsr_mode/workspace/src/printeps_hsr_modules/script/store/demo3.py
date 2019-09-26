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
from printeps_hsr_modules.srv   import HsrCarry
from printeps_hsr_modules.srv   import HsrCarryResponse
from printeps_hsr_modules.srv   import HsrPickAndPlace
from printeps_hsr_modules.srv   import HsrPickAndPlaceResponse
from printeps_hsr_modules.srv   import HsrHandRelease
from printeps_hsr_modules.srv   import HsrHandReleaseResponse

################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':
    # Initialize node ------------------------------------------------------
    rospy.init_node("hsr_demo")

    # ServiceClient ------------------------------------------------------------
        # PickAndPlace Server --------------------------------------------------
    pickandplace_client = rospy.ServiceProxy('hsr_pick_and_place', HsrPickAndPlace)
        # Carry Server ---------------------------------------------------------
    carry_client = rospy.ServiceProxy('hsr_carry', HsrCarry)
        
    pickandplaceMotion=HsrPickAndPlace()
    carryMotion=HsrCarry()

    
    # 動作 ---------------------------------------------------------------------
    mode=8

    if mode==1:
    # 4つのペットボトルをtable1に運ぶ
    # phase:1 ペットボトルをカートに置く
        # 1 ボトル1からカート1へ運ぶ
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Cart1'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
        #2 ボトル2からカート2へ運ぶ
        HsrPickAndPlace.object_place = 'Pet2'
        HsrPickAndPlace.destination  = 'Cart2'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
        #3 ボトル3からカート3へ運ぶ
        HsrPickAndPlace.object_place = 'Pet3'
        HsrPickAndPlace.destination  = 'Cart3'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
        #4 ボトル4からカート4へ運ぶ
        HsrPickAndPlace.object_place = 'Pet4'
        HsrPickAndPlace.destination  = 'Cart4'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:2 カートをテーブルの前に移動させる
        HsrCarry.pose_B = 'Pet'                            # 棚の絶対座標
        HsrCarry.pose_D = 'Table1'                         # table1の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    # phase:3 カートからテーブルにペットボトルを移動させる
        
        #1 カート4からtable11に運ぶ
        HsrPickAndPlace.object_place = 'Cart4'
        HsrPickAndPlace.destination  = 'Table11'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #2 カート3からtable12に運ぶ
        HsrPickAndPlace.object_place = 'Cart3'
        HsrPickAndPlace.destination  = 'Table12'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
        #3 カート2からtable13に運ぶ
        HsrPickAndPlace.object_place = 'Cart2'
        HsrPickAndPlace.destination  = 'Table13'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
        #4 カート1からtable14に運ぶ
        HsrPickAndPlace.object_place = 'Cart1'
        HsrPickAndPlace.destination  = 'Table14'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:4 カートを棚の前に移動させる
        HsrCarry.pose_B = 'Table1'                          # table1の絶対座標
        HsrCarry.pose_D = 'Pet'                             # 棚の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    elif mode==2:
    # 2つのペットボトルをtable３に運ぶ
    # phase:1 ペットボトルをカートに置く
        # 1 ボトル1からカート1へ運ぶ
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Cart1'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        #2　ボトル2からカート2へ運ぶ
        HsrPickAndPlace.object_place = 'Pet2'
        HsrPickAndPlace.destination  = 'Cart2'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:2 カートをテーブルの前に移動させる
        HsrCarry.pose_B = 'Pet'                             # 棚の絶対座標
        HsrCarry.pose_D = 'Table4'                          # table3の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    # phase:3 カートからテーブルにペットボトルを移動させる
        #1 カート1からtable31に運ぶ
        HsrPickAndPlace.object_place = 'Cart1'
        HsrPickAndPlace.destination  = 'Table41'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #2 カート1からtable32に運ぶ
        HsrPickAndPlace.object_place = 'Cart2'
        HsrPickAndPlace.destination  = 'Table42'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:4 カートを棚の前に移動させる
        HsrCarry.pose_B = 'Table4'                            # table3の絶対座標
        HsrCarry.pose_D = 'Pet'                               # 棚の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    elif mode==3:
        # ペットボトルを直接テーブル３に置く
        HsrPickAndPlace.object_place = 'Pet4'
        HsrPickAndPlace.destination  = 'Table11'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
    elif mode==4:
    # 4つのペットボトルをtable2に運ぶ
    # phase:1 ペットボトルをカートに置く
        # 1 ボトル1からカート1へ運ぶ
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Cart1'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        #2 ボトル2からカート2へ運ぶ
        HsrPickAndPlace.object_place = 'Pet2'
        HsrPickAndPlace.destination  = 'Cart2'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
        #3 ボトル3からカート3へ運ぶ
        HsrPickAndPlace.object_place = 'Pet3'
        HsrPickAndPlace.destination  = 'Cart3'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #4 ボトル4からカート4へ運ぶ
        HsrPickAndPlace.object_place = 'Pet4'
        HsrPickAndPlace.destination  = 'Cart4'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:2 カートをテーブルの前に移動させる
        HsrCarry.pose_B = 'Pet'                            # 棚の絶対座標
        HsrCarry.pose_D = 'Table2'                         # table1の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    # phase:3 カートからテーブルにペットボトルを移動させる
        #1 カート4からtable11に運ぶ
        HsrPickAndPlace.object_place = 'Cart4'
        HsrPickAndPlace.destination  = 'Table21'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #2 カート3からtable12に運ぶ
        HsrPickAndPlace.object_place = 'Cart3'
        HsrPickAndPlace.destination  = 'Table22'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #3 カート2からtable13に運ぶ
        HsrPickAndPlace.object_place = 'Cart2'
        HsrPickAndPlace.destination  = 'Table23'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #4 カート1からtable14に運ぶ
        HsrPickAndPlace.object_place = 'Cart1'
        HsrPickAndPlace.destination  = 'Table24'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    # phase:4 カートを棚の前に移動させる
        HsrCarry.pose_B = 'Table2'                          # table2の絶対座標
        HsrCarry.pose_D = 'Pet'                             # 棚の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    elif mode==5:
    # 2つのペットボトルをtable4に運ぶ
    # phase:1 ペットボトルをカートに置く
        # 1 ボトル1からカート1へ運ぶ
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Cart1'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        """
        #2　ボトル2からカート2へ運ぶ
        HsrPickAndPlace.object_place = 'Pet2'
        HsrPickAndPlace.destination  = 'Cart2'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        """
    # phase:2 カートをテーブルの前に移動させる
        HsrCarry.pose_B = 'Pet'                             # 棚の絶対座標
        HsrCarry.pose_D = 'Table3'                          # table4の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    # phase:3 カートからテーブルにペットボトルを移動させる
        #1 カート1からtable41に運ぶ
        HsrPickAndPlace.object_place = 'Cart1'
        HsrPickAndPlace.destination  = 'Table31'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        """
        #2 カート1からtable42に運ぶ
        HsrPickAndPlace.object_place = 'Cart2'
        HsrPickAndPlace.destination  = 'Table42'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        """
    # phase:4 カートを棚の前に移動させる
        HsrCarry.pose_B = 'Table3'                            # table4の絶対座標
        HsrCarry.pose_D = 'Pet'                               # 棚の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

    elif mode==6:
        # ペットボトルを直接テーブル4に置く
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Table41'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
    
    elif mode==7:
        # ペットボトルを直接テーブル2に置く
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Table11'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

    elif mode==8:
         
        # 2つのペットボトルをtable1に運ぶ
        # phase:1 ペットボトルをカートに置く
        # 1 ボトル1からカート1へ運ぶ
        HsrPickAndPlace.object_place = 'Pet1'
        HsrPickAndPlace.destination  = 'Cart1'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #2　ボトル2からカート2へ運ぶ
        HsrPickAndPlace.object_place = 'Pet2'
        HsrPickAndPlace.destination  = 'Cart2'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
        
        # phase:2 カートをテーブルの前に移動させる
        HsrCarry.pose_B = 'Pet'                             # 棚の絶対座標
        HsrCarry.pose_D = 'Table1'                          # table4の絶対座標
        carry_client(HsrCarry.pose_B,HsrCarry.pose_D)

        # phase:3 カートからテーブルにペットボトルを移動させる
        #1 カート1からtable41に運ぶ
        HsrPickAndPlace.object_place = 'Cart1'
        HsrPickAndPlace.destination  = 'Table11'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)

        #2 カート1からtable42に運ぶ
        HsrPickAndPlace.object_place = 'Cart2'
        HsrPickAndPlace.destination  = 'Table12'    
        pickandplace_client(HsrPickAndPlace.object_place,HsrPickAndPlace.destination)
