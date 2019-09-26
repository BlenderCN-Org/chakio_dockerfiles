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
###                        hsr_place_object.py                            ###
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
from printeps_hsr_modules.srv  import HsrHandRelease
from printeps_hsr_modules.srv   import HsrHandReleaseResponse
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

TF_Checker=True

# 把持のためのパラメータ ----------------------------------------------------------
GRASP_TORQUE                = -0.01         # 把持トルク[Nm]
GRASP_TORQUE_MAX            = -0.02         # 把持トルク[Nm]

(PET, MENU,CART, TABLE1,TABLE2,TABLE3,TABLE4)    = range(0, 7)   # ペットボトル、メニュー、 カート、テーブル
(no1,no2,no3,no4,no5,no6,)  = range(0, 6)   # ペット ボトルの番号fh
(PICKUP, PLACE,HOLD,RELEASE)        = range(0, 4)   # PickUp, Place
(BEFORE, CONTACT, AFTER,)   = range(0, 3)   # 事前姿勢、接触、事後姿勢


TF_OBJECT   = ['ar_marker/10', 'ar_marker/10','ar_marker/11', 'ar_marker/12','ar_marker/13','ar_marker/8','ar_marker/9']   # つかむ物体のtf: ペットボトル、メニュー(棚)# 物体を置く場所のtf
TF_HAND     = 'hand_palm_link'                  # グリッパのtf

TARGET_POSE = [[[[geometry.pose() for i in range(3)] for j in range(4)]for k in range(6)] for l in range(7)]
#TARGET_POSE[PET][PICKUP][BEFORE]    = geometry.pose(y=-0.05, z=-0.12, ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][CONTACT]   = geometry.pose(z=-0.01, ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][AFTER]     = geometry.pose(x=0.12, z=-0.2)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
#TARGET_POSE[PET][PLACE][BEFORE]     = geometry.pose(y=-0.15, z=-0.18, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][CONTACT]    = geometry.pose(y=-0.11, z=0.1, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][AFTER]      = geometry.pose(x=0.08, z=-0.25)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

PetHeight=0.06
# 把持のためのパラメータ(PLACE　CART) ---------------------------------------------------------
cart=1 #0の時縦向き
if cart==0:
    #1
    TARGET_POSE[CART][no1][PLACE][BEFORE]     = geometry.pose(x=0.02,y=-0.05-PetHeight-0.05, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.30)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no1][PLACE][CONTACT]    = geometry.pose(x=0.02,y=-0.10, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢2
    #2
    TARGET_POSE[CART][no2][PLACE][BEFORE]     = geometry.pose(x=0.17,y=-0.05-PetHeight-0.05, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.30)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no2][PLACE][CONTACT]    = geometry.pose(x=0.17,y=-0.10, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #3
    TARGET_POSE[CART][no3][PLACE][BEFORE]     = geometry.pose(x=0.02,y=-0.05-PetHeight-0.05, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.15)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no3][PLACE][CONTACT]    = geometry.pose(x=0.02,y=-0.10, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #4
    TARGET_POSE[CART][no4][PLACE][BEFORE]     = geometry.pose(x=0.17,y=-0.05-PetHeight-0.05, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.15)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no4][PLACE][CONTACT]    = geometry.pose(x=0.17,y=-0.10, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

else:
    #1
    TARGET_POSE[CART][no1][PLACE][BEFORE]     = geometry.pose(x=0.12,y=-0.05-PetHeight-0.05, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.18)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no1][PLACE][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.18, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.07)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢2
    #2
    TARGET_POSE[CART][no2][PLACE][BEFORE]     = geometry.pose(x=0.27,y=-0.05-PetHeight-0.05, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.18)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no2][PLACE][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.18, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.07)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #3
    TARGET_POSE[CART][no3][PLACE][BEFORE]     = geometry.pose(x=0.12,y=-0.05-PetHeight-0.05, z=-0.05, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.11)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no3][PLACE][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.06, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.07)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #4
    TARGET_POSE[CART][no4][PLACE][BEFORE]     = geometry.pose(x=0.27,y=-0.05-PetHeight-0.05, z=-0.05, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.11)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no4][PLACE][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.06, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PLACE][AFTER]      = geometry.pose(x=0.03, z=-0.07)       



# 置くのためのパラメータ(PLACE　TABLE1) ---------------------------------------------------------

#1
TARGET_POSE[TABLE1][no1][PLACE][BEFORE]     = geometry.pose(x=-0.24,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE1][no1][PLACE][CONTACT]    = geometry.pose(x=-0.24,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[TABLE1][no2][PLACE][BEFORE]     = geometry.pose(x=-0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE1][no2][PLACE][CONTACT]    = geometry.pose(x=-0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[TABLE1][no3][PLACE][BEFORE]     = geometry.pose(x=0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no3][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE1][no3][PLACE][CONTACT]    = geometry.pose(x=0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no3][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[TABLE1][no4][PLACE][BEFORE]     = geometry.pose(x=0.24,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no4][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE1][no4][PLACE][CONTACT]    = geometry.pose(x=0.24,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no4][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)

# 置くのためのパラメータ(PLACE　TABLE2) ---------------------------------------------------------

#1
TARGET_POSE[TABLE2][no1][PLACE][BEFORE]     = geometry.pose(x=-0.24,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE2][no1][PLACE][CONTACT]    = geometry.pose(x=-0.24,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[TABLE2][no2][PLACE][BEFORE]     = geometry.pose(x=-0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE2][no2][PLACE][CONTACT]    = geometry.pose(x=-0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[TABLE2][no3][PLACE][BEFORE]     = geometry.pose(x=0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no3][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE2][no3][PLACE][CONTACT]    = geometry.pose(x=0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no3][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[TABLE2][no4][PLACE][BEFORE]     = geometry.pose(x=0.24,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no4][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE2][no4][PLACE][CONTACT]    = geometry.pose(x=0.24,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no4][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)

# 置くのためのパラメータ(PLACE　TABLE3) ---------------------------------------------------------

#1
TARGET_POSE[TABLE3][no1][PLACE][BEFORE]     = geometry.pose(x=-0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE3][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.10)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE3][no1][PLACE][CONTACT]    = geometry.pose(x=-0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE3][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[TABLE3][no2][PLACE][BEFORE]     = geometry.pose(x=0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE3][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE3][no2][PLACE][CONTACT]    = geometry.pose(x=0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE3][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

# 置くのためのパラメータ(PLACE　TABLE4) ---------------------------------------------------------

#1
TARGET_POSE[TABLE4][no1][PLACE][BEFORE]     = geometry.pose(x=-0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE4][no1][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.10)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE4][no1][PLACE][CONTACT]    = geometry.pose(x=-0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE4][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[TABLE4][no2][PLACE][BEFORE]     = geometry.pose(x=0.08,y=-0.05-PetHeight-0.05-0.1, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE4][no2][PLACE][CONTACT]    = geometry.pose(x=-0.05, z=0.1)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[TABLE4][no2][PLACE][CONTACT]    = geometry.pose(x=0.08,y=-0.10, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE4][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢



#TARGET_POSE[MENU][PICKUP][BEFORE]   = geometry.pose()
#TARGET_POSE[MENU][PICKUP][CONTACT]  = geometry.pose()
#TARGET_POSE[MENU][PICKUP][AFTER]    = geometry.pose()
#TARGET_POSE[MENU][PLACE][BEFORE]    = geometry.pose()
#TARGET_POSE[MENU][PLACE][CONTACT]   = geometry.pose()
#TARGET_POSE[MENU][PLACE][AFTER]     = geometry.pose()



################################################################################
#                                HSR Hand Release                              #
################################################################################
class HSRHandRelease:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR hand Release ================="
        rospy.Subscriber("/hsrb/wrist_wrench/raw", WrenchStamped, self.hand_cb)
        rospy.Subscriber("/hsrb/joint_states", JointState, self.lift_cb)
        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_place_object")
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
    def lift_cb(self,data):
        for n in range(1,len(data.name)):
            # print data.name[n]
            if data.name[n]=='arm_lift_joint':
                self.liftDigree=data.position[n]
                # print self.liftDigree
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
                self.difference_x=self._force_data_x-self.calib_x
                self.difference_y=self._force_data_y-self.calib_y
                self.difference_z=self._force_data_z-self.calib_z
                self.difference_all=math.sqrt(self.difference_x*self.difference_x+self.difference_y*self.difference_y+self.difference_z*self.difference_z)
                self.difference_waight=round(self.difference_all / 9.81 * 1000, 1)
            print "Touch!!"
        except KeyboardInterrupt:
            print "aaaa"
            pass

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Place Server --------------------------------------------------------
        release_server = rospy.Service('hsr_hand_release', HsrHandRelease, self.handReleaseHandler)


        rospy.loginfo("Ready to serve command.")
        rospy.spin()



    #===========================================================================
    #   Place Object Handler
    #===========================================================================
    def handReleaseHandler(self, object):

        print "----------- Place Object --------------"

        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if object.place_id == 'Cart1':
            whole_body.linear_weight=(50)
            self.place_id  = CART
            self.no =no1
            print "Target Place: CART1"
        elif object.place_id == 'Cart2':
            whole_body.linear_weight=(50)
            self.place_id  = CART
            self.no =no2
            print "Target Place: CART2"
        elif object.place_id == 'Cart3':
            whole_body.linear_weight=(5)
            self.place_id  = CART
            self.no =no3
            print "Target Place: CART3"
        elif object.place_id == 'Cart4':
            whole_body.linear_weight=(5)
            self.place_id  = CART
            self.no =no4
            print "Target Place: CART4"

        #Table1
        elif object.place_id == 'Table11':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE1
            self.no =no1
            print "Target Place: TABLE11"
        elif object.place_id == 'Table12':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE1
            self.no =no2
            print "Target Place: TABLE12"
        elif object.place_id == 'Table13':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE1
            self.no =no3
            print "Target Place: TABLE13"
        elif object.place_id == 'Table14':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE1
            self.no =no4
            print "Target Place: TABLE14"

        #Table2
        elif object.place_id == 'Table21':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE2
            self.no =no1
            print "Target Place: TABLE21"
        elif object.place_id == 'Table22':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE2
            self.no =no2
            print "Target Place: TABLE22"
        elif object.place_id == 'Table23':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE2
            self.no =no3
            print "Target Place: TABLE23"
        elif object.place_id == 'Table24':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE2
            self.no =no4
            print "Target Place: TABLE24"

        #Table3
        elif object.place_id == 'Table31':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE3
            self.no =no1
            print "Target Place: TABLE31"
        elif object.place_id == 'Table32':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE3
            self.no =no2
            print "Target Place: TABLE32"

        #Table4
        elif object.place_id == 'Table41':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE4
            self.no =no1
            print "Target Place: TABLE41"
        elif object.place_id == 'Table42':
            whole_body.linear_weight=(3)
            self.place_id  = TABLE4
            self.no =no2
            print "Target Place: TABLE42"

        else:
            print object.place_id + " is an illegal object id"
            return HsrHandReleaseResponse(success=False)


        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performPlaceObject()


        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "物体を置きました\n"
            return HsrHandReleasetResponse(success=True)
        else:
            print "物体を置くことに失敗しました\n"
            return HsrHandReleaseResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performPlaceObject(self):
        TF_Checker=True
        
        #////////////////////// 物体の前までハンドを移動する /////////////////////////
        #一旦TFが見えているかチェック
        try:
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][BEFORE], TF_OBJECT[self.place_id])
            print 'ハンドを対象の前まで移動しました'
        except:
            TF_Checker=False

        #見えていなかったら首を振る
        if TF_Checker !=True:
            try:
                whole_body.move_to_go()
                whole_body.move_to_joint_positions({'head_tilt_joint': -0.8})
                whole_body.move_to_go()
                #rospy.sleep(2.)
                print '置く姿勢をとりました'
            except:
                tts.say('置く姿勢をとれませんでした')
                print "置く姿勢への初期化失敗"
                return False

            try:
                whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][BEFORE], TF_OBJECT[self.place_id])
                print 'ハンドを対象の前まで移動しました'
            except:
                tts.say('物体を置けませんでした')
                return False


        #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
       
           
        # whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][CONTACT], TF_HAND)
        self.calibration()
        self.waitingTouch()
        gripper.command(1.2)
        print '物体を置きました'
       
        


        #/////////////////////////// 移動姿勢に移行 //////////////////////////////
        try:
            whole_body.linear_weight=(4)
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][AFTER], TF_HAND)
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

    hsr   = HSRHandRelease()
    hsr.launchServer()