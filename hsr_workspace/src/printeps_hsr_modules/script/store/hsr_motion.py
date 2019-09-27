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
from printeps_cafe_motion_hsr.srv   import HsrNav
from printeps_cafe_motion_hsr.srv   import HsrNavResponse
from printeps_cafe_motion_hsr.srv   import HsrSay
from printeps_cafe_motion_hsr.srv   import HsrSayResponse
from printeps_cafe_motion_hsr.srv   import HsrPickUpObject
from printeps_cafe_motion_hsr.srv   import HsrPickUpObjectResponse
from printeps_cafe_motion_hsr.srv   import HsrPlaceObject
from printeps_cafe_motion_hsr.srv   import HsrPlaceObjectResponse
from printeps_cafe_motion_hsr.srv   import HsrHoldObject
from printeps_cafe_motion_hsr.srv   import HsrHoldObjectResponse
from printeps_cafe_motion_hsr.srv   import HsrReleaseObject
from printeps_cafe_motion_hsr.srv   import HsrReleaseObjectResponse


################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')


# 移動のためのパラメータ ---------------------------------------------------------
MOTION_TIME_TORELANCE       = 60.0                     # 移動タイムアウト時間[s]
TARGET_POSITION_TOLERANCE   = 0.15                      # 到着判定距離[m]
TARGET_ANGULAR_TOLERANCE    = (15.0/180.0*math.pi)      # 到着判定角度[rad]


# LRS -----------------------------------------------------------------------
LRS_RNG_NUM                 = 963 #1081 HSRの設定
LRS_RES_RAD                 = (0.25/180.0*math.pi)
LRS_POSE_X                  = 0.18
LRS_POSE_Y                  = 0.0
LRS_POSE_RAD                = 0.0
LRS_SKIP_NUM                = 1     # 1;スキップしない


# Fuzzy ---------------------------------------------------------------------
FUZZY_RNG_NUM               = 180
AVOID_T_DIST                = 0.8
NEAR_GOAL_DIST              = 0.8       # 減速開始距離[m]
REACHED_GOAL_DIST           = 0.2       # 目標し正確に修正し始める距離[m]
OBST_MARGIN                 = 0.05
R_ROBOT                     = 0.2

MAX_LINEAR_VELOCITY         = 0.20   # 並進最大速度[m/s]
MAX_ANGULAR_VELOCITY        = 0.25   # 回転最大速度[rad/s]
ANGULAR_KP                  = 1.0   # 回転運動比例ゲイン

(ROT1, MOVE, ROT2,)   = range(0, 3)  # 動作フェーズ（進行方向を向く，移動，ゴール姿勢）


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


# 把持のためのパラメータ(PICKUP PET) ---------------------------------------------------------         
    #1
TARGET_POSE[PET][no1][PICKUP][BEFORE]    = geometry.pose(x=-0.17,y=-0.43,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no1][PICKUP][CONTACT]   = geometry.pose(x=-0.17,y=-0.43,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no1][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)                      # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #2
TARGET_POSE[PET][no2][PICKUP][BEFORE]    = geometry.pose(x=-0.0,y=-0.43,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no2][PICKUP][CONTACT]   = geometry.pose(x=-0.0,y=-0.43,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no2][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)                # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #3
TARGET_POSE[PET][no3][PICKUP][BEFORE]    = geometry.pose(x=0.17,y=-0.43,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no3][PICKUP][CONTACT]   = geometry.pose(x=0.17,y=-0.43,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no3][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)     
    #4
TARGET_POSE[PET][no4][PICKUP][BEFORE]    = geometry.pose(x=-0.17,y=-0.13,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no4][PICKUP][CONTACT]   = geometry.pose(x=-0.17,y=-0.13,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no4][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢 x:上方向、y:横方向,z:奥行き方向
    #5
TARGET_POSE[PET][no5][PICKUP][BEFORE]    = geometry.pose(x=0.0,y=-0.13,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[PET][no5][PICKUP][CONTACT]   = geometry.pose(x=0.0,y=-0.13,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no5][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
    #6
TARGET_POSE[PET][no6][PICKUP][BEFORE]    = geometry.pose(x=0.17,y=-0.13,z=-0.3,ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢  x:横方向、y:縦方向,z:奥行き方向
TARGET_POSE[PET][no6][PICKUP][CONTACT]   = geometry.pose(x=0.17,y=-0.13,z=-0.00,ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[PET][no6][PICKUP][AFTER]     = geometry.pose(x=0.05, z=-0.15)     

# 把持のためのパラメータ(PICKUP CART) ---------------------------------------------------------
#1
TARGET_POSE[CART][no1][PICKUP][BEFORE]     = geometry.pose(x=0.02,y=-0.20, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no1][PICKUP][CONTACT]    = geometry.pose(x=0.02,y=-0.13, z=0.32, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no1][PICKUP][AFTER]      = geometry.pose(x=0.10, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[CART][no2][PICKUP][BEFORE]     = geometry.pose(x=0.17,y=-0.20, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no2][PICKUP][CONTACT]    = geometry.pose(x=0.17,y=-0.13, z=0.32, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no2][PICKUP][AFTER]      = geometry.pose(x=0.10, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[CART][no3][PICKUP][BEFORE]     = geometry.pose(x=0.02,y=-0.20, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no3][PICKUP][CONTACT]    = geometry.pose(x=0.02,y=-0.13, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no3][PICKUP][AFTER]      = geometry.pose(x=0.10, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[CART][no4][PICKUP][BEFORE]     = geometry.pose(x=0.17,y=-0.20, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no4][PICKUP][CONTACT]    = geometry.pose(x=0.17,y=-0.13, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no4][PICKUP][AFTER]      = geometry.pose(x=0.10, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢   

# 把持のためのパラメータ(PLACE　CART) ---------------------------------------------------------

#1
TARGET_POSE[CART][no1][PLACE][BEFORE]     = geometry.pose(x=0.02,y=-0.20, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no1][PLACE][CONTACT]    = geometry.pose(x=0.02,y=-0.13, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[CART][no2][PLACE][BEFORE]     = geometry.pose(x=0.17,y=-0.20, z=-0.20, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no2][PLACE][CONTACT]    = geometry.pose(x=0.17,y=-0.13, z=0.30, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.40)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[CART][no3][PLACE][BEFORE]     = geometry.pose(x=0.02,y=-0.20, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no3][PLACE][CONTACT]    = geometry.pose(x=0.02,y=-0.13, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no3][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[CART][no4][PLACE][BEFORE]     = geometry.pose(x=0.17,y=-0.20, z=-0.03, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no4][PLACE][CONTACT]    = geometry.pose(x=0.17,y=-0.13, z=0.12, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no4][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.20)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢



# 置くのためのパラメータ(PLACE　TABLE) ---------------------------------------------------------

#1
TARGET_POSE[TABLE][no1][PLACE][BEFORE]     = geometry.pose(x=-0.24,y=-0.20, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no1][PLACE][CONTACT]    = geometry.pose(x=-0.24,y=-0.12, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no1][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#2
TARGET_POSE[TABLE][no2][PLACE][BEFORE]     = geometry.pose(x=-0.08,y=-0.20, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no2][PLACE][CONTACT]    = geometry.pose(x=-0.08,y=-0.12, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no2][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#3
TARGET_POSE[TABLE][no3][PLACE][BEFORE]     = geometry.pose(x=0.08,y=-0.20, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no3][PLACE][CONTACT]    = geometry.pose(x=0.08,y=-0.12, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no3][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

#4
TARGET_POSE[TABLE][no4][PLACE][BEFORE]     = geometry.pose(x=0.24,y=-0.20, z=-0.07, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no4][PLACE][CONTACT]    = geometry.pose(x=0.24,y=-0.12, z=0.03, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
TARGET_POSE[TABLE][no4][PLACE][AFTER]      = geometry.pose(x=0.0, z=-0.15)      

#TARGET_POSE[MENU][PICKUP][BEFORE]   = geometry.pose()
#TARGET_POSE[MENU][PICKUP][CONTACT]  = geometry.pose()
#TARGET_POSE[MENU][PICKUP][AFTER]    = geometry.pose()
#TARGET_POSE[MENU][PLACE][BEFORE]    = geometry.pose()
#TARGET_POSE[MENU][PLACE][CONTACT]   = geometry.pose()
#TARGET_POSE[MENU][PLACE][AFTER]     = geometry.pose()

# 把持のためのパラメータ(HOLD　CART) ---------------------------------------------------------

TARGET_POSE[CART][no1][HOLD][BEFORE]     = geometry.pose(x=0.09,y=-0.05, z=-0.10)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[CART][no1][HOLD][CONTACT]    = geometry.pose(x=0.09,y=-0.05, z=0.005)    # テーブルの位置,z軸回に-90[deg]回転させた姿勢  
 
# 把持のためのパラメータ(RELEASE　CART) ---------------------------------------------------------
# カートを置く

TARGET_POSE[CART][no1][RELEASE][AFTER]      = geometry.pose(x=0.0, z=-0.15)  
################################################################################
#                                   HSR Motion                                 #
################################################################################
class HSRMotion:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Motion ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("printeps_cafe_motion_hsr")

        # Initialize LRS data --------------------------------------------------
        self.lrs_range      = [10.0 for i in range(LRS_RNG_NUM)]
        self.lrs_rad        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_x        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_y        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_d        = [0.0 for i in range(LRS_RNG_NUM)]
        for i in range(LRS_RNG_NUM):
            self.lrs_rad[i] = i*LRS_RES_RAD - (LRS_RNG_NUM-1)/2*LRS_RES_RAD

        # Initialize mbsp ------------------------------------------------------
        self.mbsp_t_mix     = [0.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_goal    = [0.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_obst    = [1.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_obst_temp    = [1.0 for i in range(FUZZY_RNG_NUM)]
        self.area_dist      = [10.0 for i in range(FUZZY_RNG_NUM)]
        self.max_grade      = 0.0
        self.max_grade_step = 0
        self.max_grade_rad  = 0.0

        # 速度指令 Publisher ----------------------------------------------------
        self.cmd_vel_publisher      = rospy.Publisher('hsrb/command_velocity', geometry_msgs.msg.Twist, queue_size=1)

        # 確認用 Publisher ------------------------------------------------------
        self.area_publisher         = rospy.Publisher('fuzzy_area', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_goal_publisher  = rospy.Publisher('mbsp_t_goal', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_obst_publisher  = rospy.Publisher('mbsp_t_obst', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_mix_publisher   = rospy.Publisher('mbsp_t_mix', std_msgs.msg.Float32MultiArray, queue_size=1)

        # 初期姿勢 --------------------------------------------------------------
        whole_body.move_to_go()     # 移動の姿勢

        gripper.command(1.2)        # グリッパーオープン




    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # LRS Data Subscriber --------------------------------------------------＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊要修正
        lrs_subscriber  = rospy.Subscriber('/hsrb/base_scan', LaserScan, self.lrsCallback)

        # Current pose Subscriber ----------------------------------------------
        amcl_subscriber   = rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.amclCallback)

        # Navigation Server ----------------------------------------------------
        nav_server  = rospy.Service('hsr_navigation', HsrNav, self.navigationHandler2)

       

        # Say Server -----------------------------------------------------------
        tts_server = rospy.Service('hsr_say', HsrSay, self.ttsHandler)

        # PickUpObject Server --------------------------------------------------------
        pick_up_server = rospy.Service('hsr_pick_up_object', HsrPickUpObject, self.pickUpObjectHandler)

        # Place Server --------------------------------------------------------
        place_server = rospy.Service('hsr_place_object', HsrPlaceObject, self.placeObjectHandler)

        # Hold Server --------------------------------------------------------
        Hold_server = rospy.Service('hsr_hold_object', HsrHoldObject, self.holdObjectHandler)

        # Release Server --------------------------------------------------------
        Release_server = rospy.Service('hsr_release_object', HsrReleaseObject, self.releaseObjectHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()



    #===========================================================================
    #   Get Current LRS data
    #===========================================================================
    def lrsCallback(self, sensor):

        for i in range(LRS_RNG_NUM):
            self.lrs_range[i]   = sensor.ranges[i]
            self.lrs_p_x[i]     = LRS_POSE_X + self.lrs_range[i]*math.cos(self.lrs_rad[i] + LRS_POSE_RAD)
            self.lrs_p_y[i]     = LRS_POSE_Y + self.lrs_range[i]*math.sin(self.lrs_rad[i] + LRS_POSE_RAD)
            self.lrs_p_d[i]     = math.sqrt(self.lrs_p_x[i]*self.lrs_p_x[i] + self.lrs_p_y[i]*self.lrs_p_y[i])



    #===========================================================================
    #   Get Current Pose
    #===========================================================================
    def amclCallback(self, amcl):

        orientation = (
            amcl.pose.pose.orientation.x,
            amcl.pose.pose.orientation.y,
            amcl.pose.pose.orientation.z,
            amcl.pose.pose.orientation.w
        )
        euler   = tf.transformations.euler_from_quaternion(orientation)

        self.current_pose       = geometry_msgs.msg.Pose2D()
        self.current_pose.x     = amcl.pose.pose.position.x
        self.current_pose.y     = amcl.pose.pose.position.y
        self.current_pose.theta = euler[2]

        print "x=", self.current_pose.x, " y=", self.current_pose.y, " theta=", self.current_pose.theta*180.0/math.pi



    #===========================================================================
    #   Make Area
    #===========================================================================
    def makeArea(self):

        the_data            = std_msgs.msg.Float32MultiArray()
        self.area_dist      = [10.0 for i in range(FUZZY_RNG_NUM)]


        for i in range(LRS_RNG_NUM):
            # SKIP
            if i % LRS_SKIP_NUM:
                continue

            # 対応するstep算出
            angle   = math.atan2(self.lrs_p_y[i], self.lrs_p_x[i])
            step    = self.rad2Step(angle)

            # 距離情報を反映
            if self.lrs_p_d[i] < self.area_dist[step]:
                self.area_dist[step]   = copy.deepcopy(self.lrs_p_d[i])

        for i in range(FUZZY_RNG_NUM):
            the_data.data.append(self.area_dist[i])

        self.area_publisher.publish(the_data)



    #===========================================================================
    #   Make T Goal MF
    #===========================================================================
    def makeTGoalMF(self, goal_x, goal_y):

        the_data            = std_msgs.msg.Float32MultiArray()

        goal_dist   = math.sqrt((self.current_pose.x-goal_x)*(self.current_pose.x-goal_x) + (self.current_pose.y-goal_y)*(self.current_pose.y-goal_y))
        goal_rad    = math.atan2(goal_y-self.current_pose.y, goal_x-self.current_pose.x) - self.current_pose.theta
        goal_step   = self.rad2Step(goal_rad)

        if goal_dist < NEAR_GOAL_DIST:
            t_max   = goal_dist/NEAR_GOAL_DIST
        else:
            t_max   = 1.0

        t_min   = t_max*0.05

        # ゴール方向へのMF作成 ----------------------------------------------------
        self.makeTMF(goal_step, t_max, t_min)


        for i in range(FUZZY_RNG_NUM):
            the_data.data.append(self.mbsp_t_goal[i])
        self.mbsp_t_goal_publisher.publish(the_data)



    #===========================================================================
    #   Make Obstacle MF
    #===========================================================================
    def makeTObstMF(self):

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        self.mbsp_t_obst    = [1.0 for i in range(FUZZY_RNG_NUM)] # 1.0で初期化

        for i in range(FUZZY_RNG_NUM):

            # しきい値より近い場合 -------------------------------------------------
            if self.area_dist[i] < AVOID_T_DIST:

                # 削る幅
                if (OBST_MARGIN + R_ROBOT) > self.area_dist[i]:
                    the_rad_w   = math.pi/2.0;
                else:
                    the_rad_w   = math.asin((OBST_MARGIN + R_ROBOT)/self.area_dist[i])

                # 削る領域 左側 [rad]
                the_rad_left    = i*2.0/180.0*math.pi - math.pi + the_rad_w
                if the_rad_left > math.pi:
                    the_rad_left -= 2.0*math.pi

                # 削る領域 右側 [rad]
                the_rad_right   = i*2.0/180.0*math.pi - math.pi - the_rad_w
                if the_rad_right < -math.pi :
                    the_rad_right += 2.0*math.pi

                # 削る領域 [step]
                the_step_left   = self.rad2Step(the_rad_left)
                the_step_right  = self.rad2Step(the_rad_right)

                # 削る高さ
                the_h   = (self.area_dist[i]-R_ROBOT-OBST_MARGIN)/(AVOID_T_DIST-R_ROBOT-OBST_MARGIN)
                if the_h > 1.0:
                    the_h   = 1.0
                elif the_h < 0.0:
                    the_h   = 0.0

                # 凹型MF
                self.makeCMF(the_h, the_step_left, the_step_right)

                # 障害物に対するMFへ統合(logicalProduct)
                for j in range(FUZZY_RNG_NUM):
                    if self.mbsp_t_obst[j] > self.mbsp_t_obst_temp[j]:
                        self.mbsp_t_obst[j] = copy.deepcopy(self.mbsp_t_obst_temp[j])


        for i in range(FUZZY_RNG_NUM):
            the_data_obst.data.append(self.mbsp_t_obst[i])
        self.mbsp_t_obst_publisher.publish(the_data_obst)



    #===========================================================================
    #   Make T Mix MF
    #===========================================================================
    def makeTMixMF(self):

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        # ゴール方向・障害物に関するMF統合 -------------------------------------------
        for i in range(FUZZY_RNG_NUM):
            self.mbsp_t_mix[i]  = self.mbsp_t_goal[i] #*self.mbsp_t_obst[i]


        # グレード最大のstep,値算出 ------------------------------------------------
        the_max_step    = 0;
        the_max_grade   = 0.0;
        for i in range(FUZZY_RNG_NUM):
            if self.mbsp_t_mix[i] > the_max_grade:
                the_max_grade   = self.mbsp_t_mix[i]
                the_max_step    = i

        self.max_grade      = the_max_grade
        self.max_grade_step = the_max_step
        self.max_grade_rad  = -math.pi + self.max_grade_step*2.0/180.0*math.pi

        for i in range(FUZZY_RNG_NUM):
            the_data_obst.data.append(self.mbsp_t_mix[i])
        self.mbsp_t_mix_publisher.publish(the_data_obst)



    #===========================================================================
    #   Make Triangular MF
    #===========================================================================
    def makeTMF(self, step, max, min):

        the_mf  = [0.0 for i in range(FUZZY_RNG_NUM)]
        the_up  = (max - min)/(FUZZY_RNG_NUM/2)

        # 最初に中央が頂点の三角形型MFを作る -----------------------------------------
        for i in range(FUZZY_RNG_NUM/2):
            the_mf[i]   = min + the_up*i
        for i in range(FUZZY_RNG_NUM/2, FUZZY_RNG_NUM):
            the_mf[i]   = max - the_up*(i-FUZZY_RNG_NUM/2)

        # シフトする --------------------------------------------------------------
        the_step_diff   = step - FUZZY_RNG_NUM/2
        for i in range(FUZZY_RNG_NUM):
            the_step    = i-the_step_diff
            while the_step < 0:
                the_step += 180
            while the_step > 179:
                the_step -= 180
            self.mbsp_t_goal[i] = copy.deepcopy(the_mf[the_step])



    #===========================================================================
    #   Make C MF
    #===========================================================================
    def makeCMF(self, height, step_left, step_right):

        if step_right < step_left:
            for i in range(FUZZY_RNG_NUM):
                if (i >= step_right and i <= step_left):
                    self.mbsp_t_obst_temp[i]    = height
                else:
                    self.mbsp_t_obst_temp[i]    = 1.0

        else:
            for i in range(FUZZY_RNG_NUM):
                if (i>=step_left and i<=step_right):
                    self.mbsp_t_obst_temp[i]    = 1.0
                else:
                    self.mbsp_t_obst_temp[i]    = height



    #===========================================================================
    #   Rad to Step
    #===========================================================================
    def rad2Step(self, rad):

        deg = rad*180.0/math.pi     # -90 から 270[deg]
        deg = int(deg)              # int
        if deg > 180:
            deg -= 360            # -180　から 180[deg]
        deg += 180                # 0 から 360
        step = deg/2
        while step < 0:
            step += 180
        while step > 179:
            step -= 180
        return step



    #===========================================================================
    #   Navigation Handler
    #===========================================================================
    def navigationHandler(self, goal):

        cmd_vel = geometry_msgs.msg.Twist()

        # 移動位置の設定 ---------------------------------------------------------
        print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")********"


        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        start_time      = rospy.get_rostime()
        reached_t_flg   = False
        reached_r_flg   = False
        motion_phase    = ROT1              # 回転方向を向くフェーズ
        r               = rospy.Rate(20)     # 20Hz



        while (reached_t_flg == False or reached_r_flg == False):

            # 自分の姿勢に応じてゴール姿勢を修正 *************************************
            the_dist        = math.sqrt((goal.pose.x-self.current_pose.x)*(goal.pose.x-self.current_pose.x) + (goal.pose.y-self.current_pose.y)*(goal.pose.y-self.current_pose.y))
            the_dir_angle   = math.atan2((goal.pose.y-self.current_pose.y),(goal.pose.x-self.current_pose.x)) - self.current_pose.theta
            if the_dir_angle > math.pi:
                the_dir_angle -= 2.0*math.pi
            elif the_dir_angle < -math.pi:
                the_dir_angle += 2.0*math.pi

            while (goal.pose.theta - self.current_pose.theta) > math.pi:
                goal.pose.theta -= 2.0*math.pi
            while (self.current_pose.theta - goal.pose.theta) < -math.pi:
                goal.pose.theta += 2.0*math.pi


            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成
            self.makeArea()

            # ゴールに関するのMF作成
            self.makeTGoalMF(goal.pose.x, goal.pose.y)

            # 障害物に関するMF作成
            self.makeTObstMF()

            # 並進運動に関するMF作成
            self.makeTMixMF()


            # フェーズ1: 進行方向を向く *********************************************
            if motion_phase == ROT1:

                # 並進運動:なし
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0

                # 回転運動: 移動方向
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = the_dir_angle
                if cmd_vel.angular.z > MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = MAX_ANGULAR_VELOCITY
                elif cmd_vel.angular.z < -MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = -MAX_ANGULAR_VELOCITY

                if math.fabs(the_dir_angle) < TARGET_ANGULAR_TOLERANCE:
                    motion_phase = MOVE
                    self.cmd_vel_publisher.publish(cmd_vel)

                print "ROT1: ", the_dir_angle*180.0/math.pi


            # フェーズ2: 移動 *****************************************************
            elif motion_phase == MOVE:

                # 並進速度指令値
                cmd_vel.linear.x    = MAX_LINEAR_VELOCITY*self.max_grade*math.cos(self.max_grade_rad)
                cmd_vel.linear.y    = MAX_ANGULAR_VELOCITY*self.max_grade*math.sin(self.max_grade_rad)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0

                if the_dist < REACHED_GOAL_DIST:
                    motion_phase    = ROT2
                    reached_t_flg   = True
                    self.cmd_vel_publisher.publish(cmd_vel)

                print "MOVE: ", the_dist


            # フェーズ3: 最終姿勢角 ************************************************
            elif motion_phase == ROT2:

                # 並進運動:なし
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0

                # 回転運動：目標姿勢角
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = (goal.pose.theta - self.current_pose.theta)*ANGULAR_KP   # 目標姿勢との差分
                if cmd_vel.angular.z > MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = MAX_ANGULAR_VELOCITY
                elif cmd_vel.angular.z < -MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = -MAX_ANGULAR_VELOCITY

                if math.fabs(self.current_pose.theta - goal.pose.theta)<TARGET_ANGULAR_TOLERANCE:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    reached_r_flg       = True
                    self.cmd_vel_publisher.publish(cmd_vel)
                    break

                print "ROT2: ", self.current_pose.theta - goal.pose.theta


            # 到着判定 **********************************************************
            # 時間が長すぎる場合: 失敗・速度0
            if (rospy.get_rostime().secs - start_time.secs) > MOTION_TIME_TORELANCE:
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0
                self.cmd_vel_publisher.publish(cmd_vel)
                break

            # 速度指令値をPublish ************************************************
            self.cmd_vel_publisher.publish(cmd_vel)
            #print "vx:", cmd_vel.linear.x, " vy:", cmd_vel.linear.y, " dir:", self.max_grade_rad*180.0/math.pi, " vt:", cmd_vel.angular.z

            r.sleep()


        # 移動結果を送信 ---------------------------------------------------------
        if reached_t_flg == True and reached_r_flg == True:
            print "Success: Reached Goal!! (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")\n"
            return HsrNavResponse(success=True)
        else:
            print "False: Did Not Reach Goal\n"
            return HsrNavResponse(success=False)


    def navigationHandler2(self, goal):
    
        cmd_vel = geometry_msgs.msg.Twist()

        # 移動位置の設定 ---------------------------------------------------------
        print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")********"


        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        start_time      = rospy.get_rostime()
        #reached_t_flg   = False
        reached_t_flg   = True
        reached_r_flg   = False
        motion_phase    = MOVE              # 回転方向を向くフェーズ
        r               = rospy.Rate(20)     # 20Hz



        while (reached_t_flg == False or reached_r_flg == False):

            # 自分の姿勢に応じてゴール姿勢を修正 *************************************
            the_dist        = math.sqrt((goal.pose.x-self.current_pose.x)*(goal.pose.x-self.current_pose.x) + (goal.pose.y-self.current_pose.y)*(goal.pose.y-self.current_pose.y))
            the_dir_angle   = math.atan2((goal.pose.y-self.current_pose.y),(goal.pose.x-self.current_pose.x)) - self.current_pose.theta
            if the_dir_angle > math.pi:
                the_dir_angle -= 2.0*math.pi
            elif the_dir_angle < -math.pi:
                the_dir_angle += 2.0*math.pi

            while (goal.pose.theta - self.current_pose.theta) > math.pi:
                goal.pose.theta -= 2.0*math.pi
            while (self.current_pose.theta - goal.pose.theta) < -math.pi:
                goal.pose.theta += 2.0*math.pi


            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成
            self.makeArea()

            # ゴールに関するのMF作成
            self.makeTGoalMF(goal.pose.x, goal.pose.y)

            # 障害物に関するMF作成
            self.makeTObstMF()

            # 並進運動に関するMF作成
            self.makeTMixMF()


            # フェーズ1: 進行方向を向く *********************************************
            if motion_phase == ROT1:

                # 並進運動:なし
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0

                # 回転運動: 移動方向
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = the_dir_angle
                if cmd_vel.angular.z > MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = MAX_ANGULAR_VELOCITY
                elif cmd_vel.angular.z < -MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = -MAX_ANGULAR_VELOCITY

                if math.fabs(the_dir_angle) < TARGET_ANGULAR_TOLERANCE:
                    motion_phase = MOVE
                    self.cmd_vel_publisher.publish(cmd_vel)

                print "ROT1: ", the_dir_angle*180.0/math.pi


            # フェーズ2: 移動 *****************************************************
            elif motion_phase == MOVE:

                # 並進速度指令値
                cmd_vel.linear.x    = MAX_LINEAR_VELOCITY*self.max_grade*math.cos(self.max_grade_rad)
                cmd_vel.linear.y    = MAX_ANGULAR_VELOCITY*self.max_grade*math.sin(self.max_grade_rad)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0

                if the_dist < REACHED_GOAL_DIST:
                    motion_phase    = ROT2
                    reached_t_flg   = True
                    self.cmd_vel_publisher.publish(cmd_vel)

                print "MOVE: ", the_dist


            # フェーズ3: 最終姿勢角 ************************************************
            elif motion_phase == ROT2:

                # 並進運動:なし
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0

                # 回転運動：目標姿勢角
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = (goal.pose.theta - self.current_pose.theta)*ANGULAR_KP   # 目標姿勢との差分
                if cmd_vel.angular.z > MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = MAX_ANGULAR_VELOCITY
                elif cmd_vel.angular.z < -MAX_ANGULAR_VELOCITY:
                    cmd_vel.angular.z = -MAX_ANGULAR_VELOCITY

                if math.fabs(self.current_pose.theta - goal.pose.theta)<TARGET_ANGULAR_TOLERANCE:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    reached_r_flg       = True
                    self.cmd_vel_publisher.publish(cmd_vel)
                    break

                print "ROT2: ", self.current_pose.theta - goal.pose.theta


            # 到着判定 **********************************************************
            # 時間が長すぎる場合: 失敗・速度0
            if (rospy.get_rostime().secs - start_time.secs) > MOTION_TIME_TORELANCE:
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0
                self.cmd_vel_publisher.publish(cmd_vel)
                break

            # 速度指令値をPublish ************************************************
            self.cmd_vel_publisher.publish(cmd_vel)
            #print "vx:", cmd_vel.linear.x, " vy:", cmd_vel.linear.y, " dir:", self.max_grade_rad*180.0/math.pi, " vt:", cmd_vel.angular.z

            r.sleep()


        # 移動結果を送信 ---------------------------------------------------------
        if reached_t_flg == True and reached_r_flg == True:
            print "Success: Reached Goal!! (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")\n"
            return HsrNavResponse(success=True)
        else:
            print "False: Did Not Reach Goal\n"
            return HsrNavResponse(success=False)



    #===========================================================================r_pick
    #   tts Handler
    #===========================================================================
    def ttsHandler(self, say):

        the_len = len(say.words)
        the_time = (float(the_len)/12.0)

        # 発話 -------------------------------------
        try:
            tts.say(say.words)
            rospy.sleep(the_time)
            print say.words
            return HsrSayResponse(success=True)

        except:
            rospy.logerr('発話に失敗しました')
            return HsrSayResponse(success=False)



    #===========================================================================
    #   Pick Up Object Handler
    #===========================================================================
    def pickUpObjectHandler(self, object):

        print "----------- Pick Up Object --------------"

        #///////////////////// Service からパラメータを設定 /////////////////////////
        # PickUpする物体ID -------------------------------------------------------
        if object.object_id == 'Pet':
            self.object_id  = PET
            print "Target Object: PET"
            
        elif object.object_id == 'Pet1':
            whole_body.linear_weight=(2)
            self.object_id  = PET
            self.no =no1
            print "Target Object: PET1"
        elif object.object_id == 'Pet2':
            whole_body.linear_weight=(2)
            self.object_id  = PET
            self.no =no2
            print "Target Object: PET2"
        elif object.object_id == 'Pet3':
            whole_body.linear_weight=(2)
            self.object_id  = PET
            self.no =no3
            print "Target Object: PET3"
        elif object.object_id == 'Pet4':
            whole_body.linear_weight=(0.5)
            self.object_id  = PET
            self.no =no4
            print "Target Object: PET4"
        elif object.object_id == 'Pet5':
            whole_body.linear_weight=(0.5)
            self.object_id  = PET
            self.no =no5
            print "Target Object: PET5"
        elif object.object_id == 'Pet6':
            whole_body.linear_weight=(0.5)
            self.object_id  = PET
            self.no =no6
            print "Target Object: PET6"

        elif object.object_id == 'Menu':
            self.object_id  = MENU
            print "Target Object: MENU"

        elif object.object_id == 'Cart1':
            whole_body.linear_weight=(100)
            self.object_id  = CART
            self.no =no1
            print "Target Object: CART1"
        elif object.object_id == 'Cart2':
            whole_body.linear_weight=(5)
            self.object_id  = CART
            self.no =no2
            print "Target Object: CART2"
        elif object.object_id == 'Cart3':
            whole_body.linear_weight=(2)
            self.object_id  = CART
            self.no =no3
            print "Target Object: CART3"
        elif object.object_id == 'Cart4':
            whole_body.linear_weight=(2)
            self.object_id  = CART
            self.no =no4
            print "Target Object: CART4"

        else:
            print object.object_id + " is an illegal object id"
            return HsrPickUpObjectResponse(success=False)

        rospy.sleep(2.0)

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

        #/////////////////////////// 把持姿勢に移行 //////////////////////////////
        try:
            whole_body.move_to_neutral()
            gripper.command(0.6)
            print '把持姿勢をとりました'
        except:
            tts.say('把持の姿勢をとれませんでした')
            print "把持姿勢への初期化失敗"
            return False


        #////////////////////// 物体の前までハンドを移動する /////////////////////////
        try:
            tts.say('ボトルをみつけました')
            whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][BEFORE], TF_OBJECT[self.object_id])
            print 'ハンドを物体の前まで移動しました'
        except:
            tts.say('物体を検出できませんでした')
            print '物体を検出できませんでした'
            return False


        #////////////////////////////// 物体を把持する ////////////////////////////
        try:
            if self.no ==no2 and self.object_id==CART:
                whole_body.linear_weight=(100)
            tts.say('ボトルをつかみます')
            whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][CONTACT], TF_OBJECT[self.object_id])
            gripper.grasp(GRASP_TORQUE)
            print '物体をつかみました'
        except:
            tts.say('物体の把持に失敗しました')
            print '物体の把持に失敗しました'
            return False


        #/////////////////////////// 移動姿勢に移行 //////////////////////////////
        try:
            whole_body.linear_weight=(0.1)
            whole_body.move_end_effector_pose(TARGET_POSE[self.object_id][self.no][PICKUP][AFTER], TF_HAND)
            whole_body.move_to_go()
            print '移動姿勢をとりました'
        except:
            tts.say('移動姿勢をとれませんでした')
            print '移動姿勢をとれませんでした'
            return False

        return True



    #===========================================================================
    #   Place Object Handler
    #===========================================================================
    def placeObjectHandler(self, object):

        print "----------- Place Object --------------"
       
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if object.place_id == 'Cart1':
            whole_body.linear_weight=(100)
            self.place_id  = CART
            self.no =no1
            print "Target Place: CART1"
        elif object.place_id == 'Cart2':
            whole_body.linear_weight=(100)
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

        elif object.place_id == 'Table1':
            whole_body.linear_weight=(2)
            self.place_id  = TABLE
            self.no =no1
            print "Target Place: TABLE1"
        elif object.place_id == 'Table2':
            whole_body.linear_weight=(2)
            self.place_id  = TABLE
            self.no =no2
            print "Target Place: TABLE2"
        elif object.place_id == 'Table3':
            whole_body.linear_weight=(2)
            self.place_id  = TABLE
            self.no =no3
            print "Target Place: TABLE3"
        elif object.place_id == 'Table4':
            whole_body.linear_weight=(2)
            self.place_id  = TABLE
            self.no =no4
            print "Target Place: TABLE4"
        
        else:
            print object.place_id + " is an illegal object id"
            return HsrPlaceObjectResponse(success=False)


        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performPlaceObject()


        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "物体を置きました\n"
            return HsrPlaceObjectResponse(success=True)
        else:
            print "物体を置くことに失敗しました\n"
            return HsrPlaceObjectResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performPlaceObject(self):
        #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        try:
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][BEFORE], TF_OBJECT[self.place_id])
            print '物体を置きました'
        except:
            tts.say('物体を置けませんでした')
            print '物体を置けませんでした'
            return False

        #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        try:
                
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][CONTACT], TF_OBJECT[self.place_id])
            gripper.command(1.2)
            print '物体を置きました'
        except:
            tts.say('物体を置けませんでした')
            print '物体を置けませんでした'
            return False


        #/////////////////////////// 移動姿勢に移行 //////////////////////////////
        try:
                
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][PLACE][AFTER], TF_HAND)
            whole_body.move_to_go()
            print '移動姿勢をとりました'
        except:
            tts.say('移動姿勢をとれませんでした')
            print '移動姿勢をとれませんでした'
            return False

        return True


    #===========================================================================
    #   Place Object Handler
    #===========================================================================
    def holdObjectHandler(self, object):

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

        #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        try:
            gripper.command(0.5)
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][HOLD][BEFORE], TF_OBJECT[self.place_id])
            print '物体をつかみました'
        except:
            tts.say('物体を置けませんでした')
            print '物体をつかむことに失敗しました'
            return False

         #//////////////////// 物体を置く位置の前までハンドを移動する ////////////////////
        try:
            
            whole_body.move_end_effector_pose(TARGET_POSE[self.place_id][self.no][HOLD][CONTACT], TF_OBJECT[self.place_id])
            gripper.grasp(GRASP_TORQUE_MAX)
            print '物体をつかみました'
        except:
            tts.say('物体をつかむことに失敗しました')
            print '物体をつかむことに失敗しました'
            return False
        return True



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

    staff   = HSRMotion()
    staff.launchServer()
