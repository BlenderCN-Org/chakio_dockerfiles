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
###                        hsr_pick_up_object.py                          ###
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
from sensor_msgs.msg    import LaserScan
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from hsrb_interface     import geometry
from geometry_msgs.msg  import Pose2D, Twist
from printeps_hsr_modules.srv  import HsrPickUpObject
from printeps_hsr_modules.srv  import HsrPickUpObjectResponse

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
TF_Checker=True # TFが見えるかどうか

# 把持のためのパラメータ ----------------------------------------------------------
GRASP_TORQUE                = -0.01         # 把持トルク[Nm]
GRASP_TORQUE_MAX            = -0.02         # 把持トルク[Nm]

(PET, MENU,CART, TABLE1,TABLE2,TABLE3,TABLE4,TABLE5,TABLE6,WAGON)    = range(0, 10)   # ペットボトル、メニュー、 カート、テーブル
(no1,no2,no3,no4,no5,no6,HANDOVER)  = range(0, 7)   # ペット ボトルの番号
(PICKUP, PLACE,HOLD,RELEASE)        = range(0, 4)   # PickUp, Place
(BEFORE, CONTACT, AFTER,)   = range(0, 3)   # 事前姿勢、接触、事後姿勢


TF_OBJECT   = ['ar_marker/15', 'ar_marker/10','ar_marker/14', 'ar_marker/8','ar_marker/9','ar_marker/10','ar_marker/11','ar_marker/12','ar_marker/13','hsr_wagon_tf']    # つかむ物体のtf: ペットボトル、メニュー(棚)# 物体を置く場所のtf
TF_HAND     = 'hand_palm_link'                  # グリッパのtf

TARGET_POSE = [[[[geometry.pose() for i in range(3)] for j in range(4)]for k in range(7)] for l in range(10)]
#TARGET_POSE[PET][PICKUP][BEFORE]    = geometry.pose(y=-0.05, z=-0.12, ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][CONTACT]   = geometry.pose(z=-0.01, ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][AFTER]     = geometry.pose(x=0.12, z=-0.2)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
#TARGET_POSE[PET][PLACE][BEFORE]     = geometry.pose(y=-0.15, z=-0.18, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][CONTACT]    = geometry.pose(y=-0.11, z=0.1, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][AFTER]      = geometry.pose(x=0.08, z=-0.25)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
PetHeight=0.04

# 把持のためのパラメータ(PICKUP PET) ---------------------------------------------------------
    #1
TARGET_POSE[PET][no1][PICKUP][BEFORE]    = geometry.pose(x=-0.16,y=-0.34-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no1][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no1][PICKUP][CONTACT]   = geometry.pose(x=-0.17,y=-0.38,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no1][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)                      # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #2
TARGET_POSE[PET][no2][PICKUP][BEFORE]    = geometry.pose(x=-0.0,y=-0.34-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no2][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no2][PICKUP][CONTACT]   = geometry.pose(x=-0.0,y=-0.38,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no2][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)                # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #3
TARGET_POSE[PET][no3][PICKUP][BEFORE]    = geometry.pose(x=0.16,y=-0.34-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no3][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no3][PICKUP][CONTACT]   = geometry.pose(x=0.17,y=-0.38,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no3][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)
    #4
TARGET_POSE[PET][no4][PICKUP][BEFORE]    = geometry.pose(x=-0.16,y=-0.05-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no4][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no4][PICKUP][CONTACT]   = geometry.pose(x=-0.17,y=-0.10,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no4][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢 x:上方向、y:横方向,z:奥行き方向
    #5
TARGET_POSE[PET][no5][PICKUP][BEFORE]    = geometry.pose(x=0.0,y=-0.05-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[PET][no5][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no5][PICKUP][CONTACT]   = geometry.pose(x=0.0,y=-0.10,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no5][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #6
TARGET_POSE[PET][no6][PICKUP][BEFORE]    = geometry.pose(x=0.16,y=-0.05-PetHeight,z=-0.2,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no6][PICKUP][CONTACT]   = geometry.pose(z=0.20)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][no6][PICKUP][CONTACT]   = geometry.pose(x=0.17,y=-0.10,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no6][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.10)

TARGET_POSE[PET][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[PET][HANDOVER][PICKUP][AFTER]      = geometry.pose(x=0.05, z=-0.10) 

# 把持のためのパラメータ(PICKUP CART) ---------------------------------------------------------
cart=1 #0の時縦向き
if cart==0:
    #1
    TARGET_POSE[CART][no1][PICKUP][BEFORE]     = geometry.pose(x=0.02,y=-0.05-PetHeight-0.04, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.30)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=0.02,y=-0.10, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #2
    TARGET_POSE[CART][no2][PICKUP][BEFORE]     = geometry.pose(x=0.17,y=-0.05-PetHeight-0.04, z=-0.00, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.30)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=0.17,y=-0.10, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #3
    TARGET_POSE[CART][no3][PICKUP][BEFORE]     = geometry.pose(x=0.02,y=-0.05-PetHeight-0.04, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.14)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=0.02,y=-0.10, z=0.11, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #4
    TARGET_POSE[CART][no4][PICKUP][BEFORE]     = geometry.pose(x=0.17,y=-0.05-PetHeight-0.04, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.14)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=0.17,y=-0.10, z=0.11, ek=-math.pi/2.0)
    TARGET_POSE[CART][no4][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

else:
    #1
    TARGET_POSE[CART][no1][PICKUP][BEFORE]     = geometry.pose(x=0.12,y=-0.05-PetHeight-0.04, z=-0.05, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.25)
    #TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.20, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no1][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #2
    TARGET_POSE[CART][no2][PICKUP][BEFORE]     = geometry.pose(x=0.27,y=-0.05-PetHeight-0.04, z=-0.05, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.25)
    #TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.20, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no2][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #3
    TARGET_POSE[CART][no3][PICKUP][BEFORE]     = geometry.pose(x=0.12,y=-0.05-PetHeight-0.04, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.09)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.06, ek=-math.pi/2.0) 
    TARGET_POSE[CART][no3][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.10)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

    #4
    TARGET_POSE[CART][no4][PICKUP][BEFORE]     = geometry.pose(x=0.27,y=-0.05-PetHeight-0.04, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
    TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.09)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
    #TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.06, ek=-math.pi/2.0)
    TARGET_POSE[CART][no4][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.10)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

TARGET_POSE[WAGON][no1][PICKUP][BEFORE]     = geometry.pose(x=-0.09,y=-0.05-PetHeight-0.04, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no1][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.23)
#TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.20, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no1][PICKUP][AFTER]      = geometry.pose(x=0.20, z=-0.05)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[WAGON][no2][PICKUP][BEFORE]     = geometry.pose(x=0.09,y=-0.05-PetHeight-0.04, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no2][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.23)
#TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.20, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no2][PICKUP][AFTER]      = geometry.pose(x=0.20, z=-0.05)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[WAGON][no3][PICKUP][BEFORE]     = geometry.pose(x=-0.09,y=-0.05-PetHeight-0.04, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no3][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.13)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=0.12,y=-0.10, z=0.06, ek=-math.pi/2.0) 
TARGET_POSE[WAGON][no3][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.05)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[WAGON][no4][PICKUP][BEFORE]     = geometry.pose(x=0.09,y=-0.05-PetHeight-0.04, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[WAGON][no4][PICKUP][CONTACT]    = geometry.pose(x=-0.05, z=0.13)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=0.27,y=-0.10, z=0.06, ek=-math.pi/2.0)
TARGET_POSE[WAGON][no4][PICKUP][AFTER]      = geometry.pose(x=0.1, z=-0.05)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

# 把持のためのパラメータ(PICKUP Table) ---------------------------------------------------------

TARGET_POSE[TABLE1][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE1][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE1][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE1][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE1][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE2][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE2][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE2][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE2][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE2][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE3][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE3][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE3][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE3][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE3][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE4][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE4][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE4][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE4][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE4][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 

TARGET_POSE[TABLE5][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE5][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE5][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE5][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE5][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 

TARGET_POSE[TABLE6][HANDOVER][PICKUP][BEFORE]     = geometry.pose(x=0,y=-0.05-PetHeight-0.05-0.05, z=0.04, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE6][no1][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE6][no2][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE6][no3][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 
TARGET_POSE[TABLE6][no4][PICKUP][AFTER]           = geometry.pose(x=0.05, z=-0.10) 

publog = rospy.Publisher("handover",String,queue_size=30)

################################################################################
#                               HSR PickUpObject                               #
################################################################################
class HSRPickUpObject:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Pick up Object ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_pick_up_object")

        rospy.Subscriber("/hsrb/wrist_wrench/raw", WrenchStamped, self.hand_cb)
        rospy.Subscriber("/hsrb/joint_states", JointState, self.gripper_cb)
        

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # PickUpObject Server --------------------------------------------------------
        pick_up_server = rospy.Service('hsr_pick_up_object', HsrPickUpObject, self.pickUpObjectHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    #===========================================================================
    #   handsensor callback
    #===========================================================================
    def hand_cb(self,data):

      self._force_data_x = data.wrench.force.x
      self._force_data_y = data.wrench.force.y
      self._force_data_z = data.wrench.force.z
    #===========================================================================
    #   gripper callback
    #===========================================================================
    def gripper_cb(self,data):
        for n in range(1,len(data.name)):
            if data.name[n]=='hand_motor_joint':
                self.gripperDigree=data.position[n]

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
            while count<500:
                self.calib_x+=self._force_data_x
                self.calib_y+=self._force_data_y
                self.calib_z+=self._force_data_z
                count+=1
                print count
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
    #   Pick Up Object Handler
    #===========================================================================
    def pickUpObjectHandler(self, object):

        print "----------- Pick Up Object --------------"

        #///////////////////// Service からパラメータを設定 /////////////////////////
        # PickUpする物体ID -------------------------------------------------------
        if object.object_id == 'Pet':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =HANDOVER
            print "Target Object: PET"

        elif object.object_id == 'Pet1':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no1
            print "Target Object: PET1"
        elif object.object_id == 'Pet2':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no2
            print "Target Object: PET2"
        elif object.object_id == 'Pet3':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no3
            print "Target Object: PET3"
        elif object.object_id == 'Pet4':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no4
            print "Target Object: PET4"
        elif object.object_id == 'Pet5':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no5
            print "Target Object: PET5"
        elif object.object_id == 'Pet6':
            whole_body.linear_weight=(3)
            self.object_id  = PET
            self.no =no6
            print "Target Object: PET6"

        elif object.object_id == 'Menu':
            self.object_id  = MENU
            print "Target Object: MENU"

        elif object.object_id == 'Cart1':
            whole_body.linear_weight=(50)
            self.object_id  = CART
            self.no =no1
            print "Target Object: CART1"
        elif object.object_id == 'Cart2':
            whole_body.linear_weight=(50)
            self.object_id  = CART
            self.no =no2
            print "Target Object: CART2"
        elif object.object_id == 'Cart3':
            whole_body.linear_weight=(4)
            self.object_id  = CART
            self.no =no3
            print "Target Object: CART3"
        elif object.object_id == 'Cart4':
            whole_body.linear_weight=(4)
            self.object_id  = CART
            self.no =no4
            print "Target Object: CART4"


        elif object.object_id == 'Wagon1':
            whole_body.linear_weight=(50)
            self.object_id  = WAGON
            self.no =no1
            print "Target Object: WAGON1"
        elif object.object_id == 'Wagon2':
            whole_body.linear_weight=(50)
            self.object_id  = WAGON
            self.no =no2
            print "Target Object: WAGON2"
        elif object.object_id == 'Wagon3':
            whole_body.linear_weight=(4)
            self.object_id  = WAGON
            self.no =no3
            print "Target Object: WAGON3"
        elif object.object_id == 'Wagon4':
            whole_body.linear_weight=(4)
            self.object_id  = WAGON
            self.no =no4
            print "Target Object: WAGON4"
        #Table1
        elif object.object_id == 'Table11':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE1
            self.no =no1
            print "Target Place: TABLE11"
        elif object.object_id == 'Table12':
            whole_body.linear_weight=(5)
            self.object_id = TABLE1
            self.no =no2
            print "Target Place: TABLE12"
        elif object.object_id == 'Table13':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE1
            self.no =no3
            print "Target Place: TABLE13"
        elif object.object_id == 'Table14':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE1
            self.no =no4
            print "Target Place: TABLE14"

        #Table2
        elif object.object_id == 'Table21':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE2
            self.no =no1
            print "Target Place: TABLE21"
        elif object.object_id == 'Table22':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE2
            self.no =no2
            print "Target Place: TABLE22"
        elif object.object_id == 'Table23':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE2
            self.no =no3
            print "Target Place: TABLE23"
        elif object.object_id == 'Table24':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE2
            self.no =no4
            print "Target Place: TABLE24"

        #Table3
        elif object.object_id == 'Table31':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE3
            self.no =no1
            print "Target Place: TABLE31"
        elif object.object_id == 'Table32':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE3
            self.no =no2
            print "Target Place: TABLE32"

        #Table4
        elif object.object_id == 'Table41':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE4
            self.no =no1
            print "Target Place: TABLE41"
        elif object.object_id == 'Table42':
            whole_body.linear_weight=(5)
            self.object_id  = TABLE4
            self.no =no2
            print "Target Place: TABLE42"


        else:
            print object.object_id + " is an illegal object id"
            return HsrPickUpObjectResponse(success=False)

        rospy.sleep(1.0)

        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performPickUpObject()


        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "目標の物体を把持しました\n"
            return HsrPickUpObjectResponse(success=True)
        else:
            print "把持に失敗しました\n"
            return HsrPickUpObjectResponse(success=False)



    #===========================================================================
    #   Pick Up Object
    #===========================================================================
    def performPickUpObject(self):

        gripper.command(1.0)
        TF_Checker=True;
       
        try:
            if self.object_id==TABLE1 or self.object_id==TABLE2 or self.object_id==TABLE3 or self.object_id==TABLE4:
                publog.publish("start,pickup")
                whole_body.move_end_effector_pose(TARGET_POSE[TABLE][HANDOVER][PLACE][BEFORE], TF_OBJECT[self.object_id])
            else:
                whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][BEFORE], TF_OBJECT[self.object_id])
            print 'ハンドを物体の前まで移動しました'

        except:
            publog.publish("end,end")
            TF_Checker=False
            
                    #見えていなかったら首を振る
        if TF_Checker !=True:
            TF_Checker=True     
            try:
                whole_body.move_to_go()
                whole_body.move_to_joint_positions({'head_tilt_joint': -0.8})
                whole_body.move_to_go()
                #rospy.sleep(2.)
                print '把持姿勢をとりました'
            except:
                tts.say('把持の姿勢をとれませんでした')
                print "把持姿勢への初期化失敗"
                return False

            try:
                if self.object_id==TABLE1 or self.object_id==TABLE2 or self.object_id==TABLE3 or self.object_id==TABLE4:
                    publog.publish("start,pickup")
                    whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][HANDOVER][PICKUP][BEFORE], TF_OBJECT[self.object_id])
                else:
                    whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][BEFORE], TF_OBJECT[self.object_id])
                print 'ハンドを物体の前まで移動しました'
            except:
                TF_Checker=False

        #////////////////////////////// 物体を把持する ////////////////////////////
        try:
            if TF_Checker !=True:
                whole_body.move_to_neutral()
                self.calibration()
                tts.say('ボトルを取ることができません')
                tts.say('だれか助けてください')
                self.waitingTouch(220)
                gripper.grasp(GRASP_TORQUE)
                tts.say('ありがとうございます')
                whole_body.move_to_go()
                print '物体を把持しました'
                return True
            else:
                if self.object_id==TABLE1 or self.object_id==TABLE2 or self.object_id==TABLE3 or self.object_id==TABLE4:
                    publog.publish("moved,pickup")
                    self.calibration()
                    tts.say('ゴミをいただきます.手に押し当ててください')
                    self.waitingTouch(220)
                    publog.publish("touch,place")
                    tts.say('恐れいります')
                elif self.object_id==PET:
                    whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][CONTACT], TF_HAND)
                    self.calibration()
                    tts.say('飲み物をいただきます')
                    self.waitingTouch(220)
                else:
                    whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][CONTACT], TF_HAND)
                gripper.grasp(GRASP_TORQUE)
                print '物体を把持しました'
            
        except:
            tts.say('物体の把持に失敗しました')
            print '物体の把持に失敗しました'
            return False


        #/////////////////////////// 移動姿勢に移行 //////////////////////////////
        try:
            whole_body.linear_weight=(2)
            whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][AFTER], TF_HAND)
            publog.publish("end,end")
            while True:
                if self.gripperDigree>-0.7:
                    print '物体をつかみました'
                    break
                
                tts.say('把持に失敗しました')
                print '物体の把持に失敗しました'
                gripper.command(1.2)
                whole_body.move_to_neutral()
                self.calibration()
                tts.say('だれか助けてください')
                self.waitingTouch(100)
                gripper.grasp(-0.01)
                if self.gripperDigree>-0.7:
                    tts.say('ありがとうございます')
            
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

    hsr   = HSRPickUpObject()
    hsr.launchServer()
