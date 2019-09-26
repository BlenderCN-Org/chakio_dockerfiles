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
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')


# 移動のためのパラメータ ---------------------------------------------------------
MOTION_TIME_TORELANCE       = 60.0                     # 移動タイムアウト時間[s]
TARGET_POSITION_TOLERANCE   = 0.12                      # 到着判定距離[m]
TARGET_ANGULAR_TOLERANCE    = (10.0/180.0*math.pi)      # 到着判定角度[rad]


# LRS -----------------------------------------------------------------------
LRS_RNG_NUM                 = 963 #1081 HSRの設定
LRS_RES_RAD                 = (0.25/180.0*math.pi)
LRS_POSE_X                  = 0.18
LRS_POSE_Y                  = 0.0
LRS_POSE_RAD                = 0.0
LRS_SKIP_NUM                = 1     # 1;スキップしない


# Fuzzy ---------------------------------------------------------------------
FUZZY_RNG_NUM               = 180
AVOID_T_DIST                = 1.2
NEAR_GOAL_DIST              = 0.8       # 減速開始距離[m]
NEAR_NEAR_GOAL_DIST         = NEAR_GOAL_DIST/1.5    # 障害物回避を無効にする距離[m]
REACHED_GOAL_DIST           = 0.2       # 目標し正確に修正し始める距離[m]
OBST_MARGIN                 = 0.15
R_ROBOT                     = 0.2

MAX_LINEAR_VELOCITY         = 0.20   # 並進最大速度[m/s]
MAX_ANGULAR_VELOCITY        = 0.8   # 回転最大速度[rad/s]
ANGULAR_KP                  = 0.5   # 回転運動比例ゲイン

(ROT1, MOVE, ROT2,)   = range(0, 3)  # 動作フェーズ（進行方向を向く，移動，ゴール姿勢）


################################################################################
#                               Virtual Objecct                                #
################################################################################
# Rectangle-shaped Object ------------------------------------------------------
class RectancleObject:
    def __init__(self):
        self.p_x    = 0.0
        self.p_y    = 0.0
        self.len_x  = 0.0
        self.len_y  = 0.0

# Circle-shaped Object ---------------------------------------------------------
class CircleObject:
    def __init__(self):
        self.p_x    = 0.0
        self.p_y    = 0.0
        self.r      = 0.0



################################################################################
#                               HSR Navigation                                 #
################################################################################
class HSRNavigation:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Navigation ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_navigation")

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
        #self.area_publisher         = rospy.Publisher('fuzzy_area', std_msgs.msg.Float32MultiArray, queue_size=1)
        #self.mbsp_t_goal_publisher  = rospy.Publisher('mbsp_t_goal', std_msgs.msg.Float32MultiArray, queue_size=1)
        #self.mbsp_t_obst_publisher  = rospy.Publisher('mbsp_t_obst', std_msgs.msg.Float32MultiArray, queue_size=1)
        #self.mbsp_t_mix_publisher   = rospy.Publisher('mbsp_t_mix', std_msgs.msg.Float32MultiArray, queue_size=1)

        # 最大速度設定 rosparam --------------------------------------------------
        self.max_linear_vel     = rospy.get_param('~max_speed', MAX_LINEAR_VELOCITY)
        self.max_angular_vel    = rospy.get_param('~max_turn', MAX_ANGULAR_VELOCITY)


        # 仮想障害物の設定 -------------------------------------------------------
        self.use_virtual_object = rospy.get_param('~use_virtual_object', True)
        
        if self.use_virtual_object==True:
            self.r_object_num = 7
            self.r_object     = [0 for i in range(self.r_object_num)]
            for i in range(self.r_object_num):
                self.r_object[i] = RectancleObject()

            '''
            self.r_object[0]        = RectancleObject()
            self.r_object[0].p_x    = 1.0
            self.r_object[0].p_y    = -0.5
            self.r_object[0].len_x  = 1.0
            self.r_object[0].len_y  = 1.0
            '''
            # カウンター棚
            self.r_object[0].p_x    = 0.0#1.5
            self.r_object[0].p_y    = -1.9#-1.5
            self.r_object[0].len_x  = 1.2
            self.r_object[0].len_y  = 1.2

            # テーブル1
            self.r_object[1].p_x    = 2.8#3.5
            self.r_object[1].p_y    = -1.8#-1.5
            self.r_object[1].len_x  = 2.0
            self.r_object[1].len_y  = 1.2

            # テーブル2
            self.r_object[2].p_x    = 6.0
            self.r_object[2].p_y    = -1.5
            self.r_object[2].len_x  = 2.0
            self.r_object[2].len_y  = 1.2

            # テーブル3
            self.r_object[3].p_x    = 2.8#3.5
            self.r_object[3].p_y    = 0.8#2.0
            self.r_object[3].len_x  = 1.0#1.2
            self.r_object[3].len_y  = 1.5#1.6

            # テーブル4
            self.r_object[4].p_x    = 6.0
            self.r_object[4].p_y    = 2.0
            self.r_object[4].len_x  = 1.2
            self.r_object[4].len_y  = 1.6

            # カウンターJACO
            self.r_object[5].p_x    = 1.0#0.0
            self.r_object[5].p_y    = 1.8#2.0
            self.r_object[5].len_x  = 1.6#2.0
            self.r_object[5].len_y  = 1.0
            

            # テーブル3にスタックしないための障害物
            self.r_object[6].p_x    = 2.0
            self.r_object[6].p_y    = 12.0#2.0
            self.r_object[6].len_x  = 3.0
            self.r_object[6].len_y  = 1.4
            



    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # LRS Data Subscriber --------------------------------------------------＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊要修正
        lrs_subscriber  = rospy.Subscriber('/hsrb/base_scan', LaserScan, self.lrsCallback)

        # Current pose Subscriber ----------------------------------------------
        amcl_subscriber   = rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.amclCallback)

        # Navigation Server ----------------------------------------------------
        nav_server  = rospy.Service('_hsr_navigation', HsrNav, self.navigationHandler)

        # Navigation Server ----------------------------------------------------
        nav2_server  = rospy.Service('hsr_navigation2', HsrNav2, self.navigationHandler2)

        # Navigation Server ----------------------------------------------------
        nav3_server  = rospy.Service('hsr_navigation3', HsrNav3, self.navigationHandler3)

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

        # print "x=", self.current_pose.x, " y=", self.current_pose.y, " theta=", self.current_pose.theta*180.0/math.pi



    #===========================================================================
    #   Make Area
    #===========================================================================
    def makeArea(self, obst_avoid_flg):

        the_data            = std_msgs.msg.Float32MultiArray()
        self.area_dist      = [10.0 for i in range(FUZZY_RNG_NUM)]

        if obst_avoid_flg==True:
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

        #self.area_publisher.publish(the_data)



    #===========================================================================
    #   fixedArea
    #===========================================================================
    def fixedArea(self, in_goal_x, in_goal_y):

        the_data    = std_msgs.msg.Float32MultiArray()
        the_x       = self.current_pose.x
        the_y       = self.current_pose.y

        if in_goal_x > 4.0:
            the_r_object_num = self.r_object_num
        else:
            the_r_object_num = self.r_object_num -1

        # Rectangle Objects ----------------------------------------------------
        for i in range(the_r_object_num):

            # x=lower_side (y_min<y<y_max)
            for j in range(FUZZY_RNG_NUM):
                the_rad  = self.current_pose.theta + self.step2Rad(j)
                if math.cos(the_rad):
                    the_l   = (self.r_object[i].p_x - self.r_object[i].len_x/2.0 - the_x)/math.cos(the_rad)
                    if the_l >= 0.0:
                        if the_l < self.area_dist[j]:
                            if the_y + the_l*math.sin(the_rad) >= self.r_object[i].p_y - self.r_object[i].len_y/2.0:
                                if the_y + the_l*math.sin(the_rad) <= self.r_object[i].p_y + self.r_object[i].len_y/2.0:
                                    self.area_dist[j] = copy.deepcopy(the_l) 

            # x=upper_side (y_min<y<y_max)
            for j in range(FUZZY_RNG_NUM):
                the_rad  = self.current_pose.theta + self.step2Rad(j)
                if math.cos(the_rad):
                    the_l   = (self.r_object[i].p_x + self.r_object[i].len_x/2.0 - the_x)/math.cos(the_rad)
                    if the_l >= 0.0:
                        if the_l < self.area_dist[j]:
                            if the_y + the_l*math.sin(the_rad) >= self.r_object[i].p_y - self.r_object[i].len_y/2.0:
                                if the_y + the_l*math.sin(the_rad) <= self.r_object[i].p_y + self.r_object[i].len_y/2.0:
                                    self.area_dist[j] = copy.deepcopy(the_l) 

            # y=lower_side (x_min<x<x_max)
            for j in range(FUZZY_RNG_NUM):
                the_rad  = self.current_pose.theta + self.step2Rad(j)
                if math.sin(the_rad):
                    the_l   = (self.r_object[i].p_y - self.r_object[i].len_y/2.0 - the_y)/math.sin(the_rad)
                    if the_l >= 0.0:
                        if the_l < self.area_dist[j]:
                            if the_x + the_l*math.cos(the_rad) >= self.r_object[i].p_x - self.r_object[i].len_x/2.0:
                                if the_x + the_l*math.cos(the_rad) <= self.r_object[i].p_x + self.r_object[i].len_x/2.0:
                                    self.area_dist[j] = copy.deepcopy(the_l) 

            # y=upper_side (x_min<x<x_max)
            for j in range(FUZZY_RNG_NUM):
                the_rad  = self.current_pose.theta + self.step2Rad(j)
                if math.sin(the_rad):
                    the_l   = (self.r_object[i].p_y + self.r_object[i].len_y/2.0 - the_y)/math.sin(the_rad)
                    if the_l >= 0.0:
                        if the_l < self.area_dist[j]:
                            if the_x + the_l*math.cos(the_rad) >= self.r_object[i].p_x - self.r_object[i].len_x/2.0:
                                if the_x + the_l*math.cos(the_rad) <= self.r_object[i].p_x + self.r_object[i].len_x/2.0:
                                    self.area_dist[j] = copy.deepcopy(the_l) 


        for i in range(FUZZY_RNG_NUM):
            the_data.data.append(self.area_dist[i])

        #self.area_publisher.publish(the_data)



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


        #for i in range(FUZZY_RNG_NUM):
        #    the_data.data.append(self.mbsp_t_goal[i])
        #self.mbsp_t_goal_publisher.publish(the_data)



    #===========================================================================
    #   Make Obstacle MF
    #===========================================================================
    def makeTObstMF(self,in_dist):

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        # ゴールとの距離に応じて障害物回避距離を調整
        if in_dist<NEAR_GOAL_DIST:
            the_obst_margin = OBST_MARGIN*(in_dist/NEAR_GOAL_DIST)*(in_dist/NEAR_GOAL_DIST)
        else:
            the_obst_margin = OBST_MARGIN

        self.mbsp_t_obst    = [1.0 for i in range(FUZZY_RNG_NUM)] # 1.0で初期化

        for i in range(FUZZY_RNG_NUM):

            # しきい値より近い場合 -------------------------------------------------
            if self.area_dist[i] < AVOID_T_DIST:

                # 削る幅
                if (the_obst_margin + R_ROBOT) > self.area_dist[i]:
                    the_rad_w   = math.pi/2.0;
                else:
                    the_rad_w   = math.asin((the_obst_margin + R_ROBOT)/self.area_dist[i])

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
                the_h   = (self.area_dist[i]-R_ROBOT-the_obst_margin)/(AVOID_T_DIST-R_ROBOT-the_obst_margin)
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


        #for i in range(FUZZY_RNG_NUM):
        #    the_data_obst.data.append(self.mbsp_t_obst[i])
        #self.mbsp_t_obst_publisher.publish(the_data_obst)



    #===========================================================================
    #   Make T Mix MF
    #===========================================================================
    def makeTMixMF(self,in_dist):

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        # ゴール方向・障害物に関するMF統合 -------------------------------------------
        for i in range(FUZZY_RNG_NUM):
            if in_dist > NEAR_NEAR_GOAL_DIST:
                self.mbsp_t_mix[i]  = self.mbsp_t_goal[i]*self.mbsp_t_obst[i]
            else:
                self.mbsp_t_mix[i]  = self.mbsp_t_goal[i]


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

        #for i in range(FUZZY_RNG_NUM):
        #    the_data_obst.data.append(self.mbsp_t_mix[i])
        #self.mbsp_t_mix_publisher.publish(the_data_obst)



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
    #   Step to Rad
    #===========================================================================
    def step2Rad(self, in_step):

        the_deg = (float(in_step) - 90.0)*2.0

        return the_deg*math.pi/180.0
    

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
            while (goal.pose.theta - self.current_pose.theta) < -math.pi:
                goal.pose.theta += 2.0*math.pi


            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成(障害物回避の有無)
            self.makeArea(True)

            # 仮想障害物の統合
            if self.use_virtual_object==True:
                self.fixedArea(goal.pose.x, goal.pose.y)

            # ゴールに関するのMF作成
            self.makeTGoalMF(goal.pose.x, goal.pose.y)

            # 障害物に関するMF作成
            self.makeTObstMF(the_dist)

            # 並進運動に関するMF作成
            self.makeTMixMF(the_dist)


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(the_dir_angle) < TARGET_ANGULAR_TOLERANCE:
                    motion_phase = MOVE
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "ROT1: ", the_dir_angle*180.0/math.pi


            # フェーズ2: 移動 *****************************************************
            elif motion_phase == MOVE:

                # 並進速度指令値
                cmd_vel.linear.x    = self.max_linear_vel*self.max_grade*math.cos(self.max_grade_rad)
                cmd_vel.linear.y    = self.max_linear_vel*self.max_grade*math.sin(self.max_grade_rad)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = the_dir_angle
                if cmd_vel.angular.z > self.max_angular_vel/3.0:
                    cmd_vel.angular.z = self.max_angular_vel/3.0
                elif cmd_vel.angular.z < -self.max_angular_vel/3.0:
                    cmd_vel.angular.z = -self.max_angular_vel/3.0

                if the_dist < REACHED_GOAL_DIST:
                    motion_phase    = ROT2
                    reached_t_flg   = True
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "MOVE: ", the_dist


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(self.current_pose.theta - goal.pose.theta)<TARGET_ANGULAR_TOLERANCE:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    reached_r_flg       = True
                    self.cmd_vel_publisher.publish(cmd_vel)
                    break

                # print "ROT2: ", self.current_pose.theta - goal.pose.theta


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


    #===========================================================================
    #   Navigation Handler2
    #===========================================================================
    def navigationHandler2(self, goal):

        cmd_vel = geometry_msgs.msg.Twist()

        # 移動位置の設定 ---------------------------------------------------------
        # print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")********"


        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        start_time      = rospy.get_rostime()
        reached_t_flg   = False
        reached_r_flg   = False
        r               = rospy.Rate(20)     # 20Hz
        if goal.first_rot == True:
            motion_phase    = ROT1           # 回転方向を向くフェーズ
        else:
            motion_phase    = MOVE           # 目標方向へ移動するフェーズ


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
            while (goal.pose.theta - self.current_pose.theta) < -math.pi:
                goal.pose.theta += 2.0*math.pi


            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成(障害物回避の有無)
            self.makeArea(goal.obstacle_avoidance)

            # 仮想障害物の統合
            if self.use_virtual_object==True:
                self.fixedArea(goal.pose.x, goal.pose.y)

            # ゴールに関するのMF作成
            self.makeTGoalMF(goal.pose.x, goal.pose.y)

            # 障害物に関するMF作成
            self.makeTObstMF(the_dist)

            # 並進運動に関するMF作成
            self.makeTMixMF(the_dist)


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(the_dir_angle) < TARGET_ANGULAR_TOLERANCE:
                    motion_phase = MOVE
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "ROT1: ", the_dir_angle*180.0/math.pi


            # フェーズ2: 移動 *****************************************************
            elif motion_phase == MOVE:

                # 並進速度指令値
                cmd_vel.linear.x    = self.max_linear_vel*self.max_grade*math.cos(self.max_grade_rad)
                cmd_vel.linear.y    = self.max_linear_vel*self.max_grade*math.sin(self.max_grade_rad)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                if goal.first_rot == True:
                    cmd_vel.angular.z   = the_dir_angle
                    if cmd_vel.angular.z > self.max_angular_vel/3.0:
                        cmd_vel.angular.z = self.max_angular_vel/3.0
                    elif cmd_vel.angular.z < -self.max_angular_vel/3.0:
                        cmd_vel.angular.z = -self.max_angular_vel/3.0
                else:
                    cmd_vel.angular.z   = 0.0


                if the_dist < REACHED_GOAL_DIST:
                    motion_phase    = ROT2
                    reached_t_flg   = True
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "MOVE: ", the_dist


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(self.current_pose.theta - goal.pose.theta)<TARGET_ANGULAR_TOLERANCE:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    reached_r_flg       = True
                    self.cmd_vel_publisher.publish(cmd_vel)
                    break

                # print "ROT2: ", self.current_pose.theta - goal.pose.theta


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
            return HsrNav2Response(success=True)
        else:
            print "False: Did Not Reach Goal\n"
            return HsrNav2Response(success=False)

    #===========================================================================
    #   Navigation Handler3
    #===========================================================================
    def navigationHandler3(self, goal):

        cmd_vel = geometry_msgs.msg.Twist()

        # 移動位置の設定 ---------------------------------------------------------
        print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ",",goal.velocity,")********"


        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        start_time      = rospy.get_rostime()
        reached_t_flg   = False
        reached_r_flg   = False
        r               = rospy.Rate(20)     # 20Hz

        if math.sqrt((goal.pose.x-self.current_pose.x)*(goal.pose.x-self.current_pose.x) + (goal.pose.y-self.current_pose.y)*(goal.pose.y-self.current_pose.y))>goal.first_rot_limit:
            motion_phase    = ROT1           # 回転方向を向くフェーズ
        else:
            motion_phase    = MOVE           # 目標方向へ移動するフェーズ


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
            while (goal.pose.theta - self.current_pose.theta) < -math.pi:
                goal.pose.theta += 2.0*math.pi


            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成
            self.makeArea(goal.obstacle_avoidance)

            # 仮想障害物の統合
            if self.use_virtual_object==True:
                self.fixedArea(goal.pose.x, goal.pose.y)

            # ゴールに関するのMF作成
            self.makeTGoalMF(goal.pose.x, goal.pose.y)

            # 障害物に関するMF作成
            self.makeTObstMF(the_dist)

            # 並進運動に関するMF作成
            self.makeTMixMF(the_dist)


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(the_dir_angle) < TARGET_ANGULAR_TOLERANCE:
                    motion_phase = MOVE
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "ROT1: ", the_dir_angle*180.0/math.pi


            # フェーズ2: 移動 *****************************************************
            elif motion_phase == MOVE:

                # 並進速度指令値
                cmd_vel.linear.x    = goal.velocity*self.max_grade*math.cos(self.max_grade_rad)
                cmd_vel.linear.y    = goal.velocity*self.max_grade*math.sin(self.max_grade_rad)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                if math.sqrt((goal.pose.x-self.current_pose.x)*(goal.pose.x-self.current_pose.x) + (goal.pose.y-self.current_pose.y)*(goal.pose.y-self.current_pose.y))>goal.first_rot_limit:
                    cmd_vel.angular.z   = the_dir_angle
                    if cmd_vel.angular.z > self.max_angular_vel/3.0:
                        cmd_vel.angular.z = self.max_angular_vel/3.0
                    elif cmd_vel.angular.z < -self.max_angular_vel/3.0:
                        cmd_vel.angular.z = -self.max_angular_vel/3.0
                else:
                    cmd_vel.angular.z   = 0.0


                if the_dist < REACHED_GOAL_DIST:
                    motion_phase    = ROT2
                    reached_t_flg   = True
                    self.cmd_vel_publisher.publish(cmd_vel)

                # print "MOVE: ", the_dist


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
                if cmd_vel.angular.z > self.max_angular_vel:
                    cmd_vel.angular.z = self.max_angular_vel
                elif cmd_vel.angular.z < -self.max_angular_vel:
                    cmd_vel.angular.z = -self.max_angular_vel

                if math.fabs(self.current_pose.theta - goal.pose.theta)<TARGET_ANGULAR_TOLERANCE:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    reached_r_flg       = True
                    self.cmd_vel_publisher.publish(cmd_vel)
                    break

                # print "ROT2: ", self.current_pose.theta*180.0/math.pi, goal.pose.theta*180.0/math.pi


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
            return HsrNav3Response(success=True)
        else:
            print "False: Did Not Reach Goal\n"
            return HsrNav3Response(success=False)


################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRNavigation()
    hsr.launchServer()
