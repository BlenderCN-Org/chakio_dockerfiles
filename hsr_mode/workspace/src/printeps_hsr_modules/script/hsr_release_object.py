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

from printeps_hsr_modules.srv   import HsrReleaseObject
from printeps_hsr_modules.srv   import HsrReleaseObjectResponse


################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')

# 把持のためのパラメータ ----------------------------------------------------------
GRASP_TORQUE                = -0.01         # 把持トルク[Nm]
GRASP_TORQUE_MAX            = -0.02         # 把持トルク[Nm]

(PET, MENU,CART, TABLE,)    = range(0, 4)   # ペットボトル、メニュー、 カート、テーブル
(no1,no2,no3,no4,no5,no6,)  = range(0, 6)   # ペット ボトルの番号
(PICKUP, PLACE,HOLD,RELEASE)        = range(0, 4)   # PickUp, Place
(BEFORE, CONTACT, AFTER,)   = range(0, 3)   # 事前姿勢、接触、事後姿勢


TF_OBJECT   = ['ar_marker/10', 'ar_marker/10','ar_marker/11', 'ar_marker/12']   # つかむ物体のtf: ペットボトル、メニュー(棚)# 物体を置く場所のtf
TF_HAND     = 'hand_palm_link'                  # グリッパのtf

TARGET_POSE = [[[[geometry.pose() for i in range(3)] for j in range(4)]for k in range(6)] for l in range(4)]
#TARGET_POSE[PET][PICKUP][BEFORE]    = geometry.pose(y=-0.05, z=-0.12, ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][CONTACT]   = geometry.pose(z=-0.01, ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][AFTER]     = geometry.pose(x=0.12, z=-0.2)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
#TARGET_POSE[PET][PLACE][BEFORE]     = geometry.pose(y=-0.15, z=-0.18, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][CONTACT]    = geometry.pose(y=-0.11, z=0.1, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][AFTER]      = geometry.pose(x=0.08, z=-0.25)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

# 把持のためのパラメータ(RELEASE　CART) ---------------------------------------------------------
# カートを置く
TARGET_POSE[CART][no1][RELEASE][AFTER]      = geometry.pose(x=0.0, z=-0.05)  



################################################################################
#                                   HSR Motion                                 #
################################################################################
class HSRReleaseObject:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Release Object ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("printeps_cafe_motion_hsr")




    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):
       
        # Release Server --------------------------------------------------------
        Release_server = rospy.Service('hsr_release_object', HsrReleaseObject, self.releaseObjectHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()





    #===========================================================================
    #   Release Object Handler
    #===========================================================================
    def releaseObjectHandler(self, object):

        print "----------- Place Object --------------"
        whole_body.linear_weight=(5)
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if object.place_id == 'Cart':
            self.place_id  = CART
            self.no =no1
            print "Target Place: CART"
        else:
            print object.place_id + " is an illegal object id"
            return HsrReleaseObjectResponse(success=False)


        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performReleaseObject()


        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "物体をつかみました\n"
            return HsrReleaseObjectResponse(success=True)
        else:
            print "物体をつかむことに失敗しました\n"
            return HsrReleaseObjectResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performReleaseObject(self):

        
        #/////////////////////////// カートを離し、離れる //////////////////////////////
        try:
            gripper.command(1.2)
            #whole_body.linear_weight=(0.1)
            #whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][Release][AFTER], TF_HAND)
        except:
            tts.say('物体を置けませんでした')
            print '物体を置けませんでした'
            return False

        #/////////////////////////// 移動姿勢に移行 //////////////////////////////
        try:
            whole_body.move_to_go()
            print '移動姿勢をとりました'
        except:
            tts.say('移動姿勢をとれませんでした')
            print '移動姿勢をとれませんでした'
            return False
        return True


################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    staff   = HSRReleaseObject()
    staff.launchServer()
