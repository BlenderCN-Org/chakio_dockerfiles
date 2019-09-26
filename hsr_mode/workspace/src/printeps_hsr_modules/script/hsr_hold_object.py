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
###                         hsr_hold_object.py                            ###
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
from std_msgs.msg       import Bool
from printeps_hsr_modules.srv   import HsrHoldObject
from printeps_hsr_modules.srv   import HsrHoldObjectResponse


################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')

TF_Checker=True;

# 把持のためのパラメータ ----------------------------------------------------------
GRASP_TORQUE                = -0.02         # 把持トルク[Nm]
GRASP_TORQUE_MAX            = -0.015        # 把持トルク[Nm]

(PET, MENU,CART, TABLE,WAGON)    = range(0, 5)   # ペットボトル、メニュー、 カート、テーブル
(no1,no2,no3,no4,no5,no6,)  = range(0, 6)   # ペット ボトルの番号
(PICKUP, PLACE,HOLD,RELEASE)        = range(0, 4)   # PickUp, Place
(BEFORE, CONTACT, AFTER,)   = range(0, 3)   # 事前姿勢、接触、事後姿勢


TF_OBJECT   = ['ar_marker/10', 'ar_marker/10','ar_marker/9', 'ar_marker/9','hsr_wagon_tf']   # つかむ物体のtf: ペットボトル、メニュー(棚)# 物体を置く場所のtf
TF_HAND     = 'hand_palm_link'                  # グリッパのtf

TARGET_POSE = [[[[geometry.pose() for i in range(3)] for j in range(4)]for k in range(6)] for l in range(5)]


# 把持のためのパラメータ(HOLD　CART) ---------------------------------------------------------
cart=1 #0の時縦向き
if cart==0:
    TARGET_POSE[CART][no1][HOLD][BEFORE]     = geometry.pose(x=0.09,y=-0.04, z=-0.10)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][HOLD][CONTACT]    = geometry.pose(z=0.105)    # テーブルの位置,z軸回に-90[deg]回転させた姿勢

    TARGET_POSE[WAGON][no1][HOLD][BEFORE]     = geometry.pose(x=-0.35,y=0.00, z=-0.00,ei=0,ej=math.pi/2.0, ek=0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[WAGON][no1][HOLD][CONTACT]    = geometry.pose(z=0.14) 
    #TARGET_POSE[CART][no1][HOLD][CONTACT]    = geometry.pose(x=0.09,y=-0.04, z=0.005)    # テーブルの位置,z軸回に-90[deg]回転させた姿勢
else:
    TARGET_POSE[CART][no1][HOLD][BEFORE]     = geometry.pose(x=0.19,y=-0.04, z=-0.10)    # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][HOLD][CONTACT]    = geometry.pose(z=0.105)    # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    
    TARGET_POSE[WAGON][no1][HOLD][BEFORE]     = geometry.pose(x=-0.25,y=0.00, z=-0.00,ei=0,ej=math.pi/2.0, ek=0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[WAGON][no1][HOLD][CONTACT]    = geometry.pose(z=0.14) 
    
    """
    TARGET_POSE[WAGON][no1][HOLD][BEFORE]     = geometry.pose(x=0.10,y=-0.10, z=0.10,ei=-math.pi/2.0,ej=0, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[WAGON][no1][HOLD][CONTACT]    = geometry.pose(z=0.0) 
    """
    #TARGET_POSE[CART][no1][HOLD][CONTACT]    = geometry.pose(x=0.19,y=-0.04, z=0.005)    # テーブルの位置,z軸回に-90[deg]回転させた姿勢
# 把持のためのパラメータ(RELEASE　CART) ---------------------------------------------------------
# カートを置く
TARGET_POSE[CART][no1][RELEASE][AFTER]      = geometry.pose(x=0.0, z=-0.20)
TARGET_POSE[WAGON][no1][RELEASE][AFTER]      = geometry.pose(x=0.0, z=-0.20)


################################################################################
#                               HSR Hold Object                                #
################################################################################
class HSRHoldObject:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Hold Object ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_hold_object")
        self.tracking=False



    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Hold Server --------------------------------------------------------
        Hold_server = rospy.Service('hsr_hold_object', HsrHoldObject, self.holdObjectHandler)
        tracking_subscriber     = rospy.Subscriber('/hsr_wagon_tracking', Bool, self.trackingCallback)
        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    def trackingCallback(self, msg):
        self.tracking=msg.data
        
    #===========================================================================
    #   Place Object Handler
    #===========================================================================
    def holdObjectHandler(self, object):

        print "----------- Place Object --------------"
        whole_body.linear_weight=(6)
        print  "object name:"+object.place_id
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if object.place_id == 'Cart':
            self.tracking=True
            self.place_id  = CART
            self.no =no1
            print "Target Place: CART"
        elif object.place_id == 'Wagon':
            self.place_id  = WAGON
            self.no =no1
            print "Target Place: WAGON"
        else:
            print object.place_id + " is an illegal object id"
            return HsrHoldObjectResponse(success=False)


        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performHoldObject()


        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "物体をつかみました\n"
            return HsrHoldObjectResponse(success=True)
        else:
            print "物体をつかむことに失敗しました\n"
            return HsrHoldObjectResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performHoldObject(self):
        gripper.command(1.0)
        TF_Checker=True;
        #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        #一旦TFが見えているかチェック
        counter=0
        while True:
            print  "object name:"
            print  self.place_id
            if self.tracking:
                try:
                    whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][HOLD][BEFORE], TF_OBJECT[self.place_id])
                    print 'ハンドを物体の前まで移動しました'
                    break
                except:
                    TF_Checker=False

                #見えていなかったら首を振る
                if TF_Checker !=True:
                    try:
                        whole_body.move_to_go()
                        whole_body.move_to_joint_positions({'head_tilt_joint': -0.8})
                        whole_body.move_to_go()
                        #rospy.sleep(1.)
                        print 'あ'
                    except:
                        tts.say('把持の姿勢をとれませんでした')
                        print "把持姿勢への初期化失敗"
                        return False
            else:
                if counter==0:
                    try:
                        whole_body.move_to_joint_positions({'head_tilt_joint': 0.0})
                        whole_body.move_to_joint_positions({'head_tilt_joint': -0.8})
                        whole_body.move_to_joint_positions({'head_tilt_joint': 0.0})
                        counter=1
                        #rospy.sleep(1.)
                        print 'い'
                    except:
                        tts.say('把持の姿勢をとれませんでした')
                        print "把持姿勢への初期化失敗"
                        return False
                else:
                    try:
                        whole_body.move_to_joint_positions({'head_pan_joint': 0.0})
                        whole_body.move_to_joint_positions({'head_pan_joint': 0.8})
                        whole_body.move_to_joint_positions({'head_pan_joint': -0.8})
                        whole_body.move_to_joint_positions({'head_pan_joint': 0.0})
                        counter=0
                        #rospy.sleep(1.)
                        print '把持姿勢をとりました'
                    except:
                        tts.say('把持の姿勢をとれませんでした')
                        print "把持姿勢への初期化失敗"
                        return False
           # try:
            #    whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][HOLD][BEFORE], TF_OBJECT[self.place_id])
             #   print 'ハンドを物体の前まで移動しました'
            #except:
             #   return False

         #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        try:
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][HOLD][CONTACT], TF_HAND)
            gripper.grasp(GRASP_TORQUE_MAX)
            print '物体をつかみました'
        except:
            tts.say('物体をつかむことに失敗しました')
            print '物体をつかむことに失敗しました'
            return False
        return True



################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRHoldObject()
    hsr.launchServer()
