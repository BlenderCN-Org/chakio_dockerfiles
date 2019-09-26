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
from std_msgs.msg import String
from sensor_msgs.msg    import LaserScan
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from hsrb_interface     import geometry
from geometry_msgs.msg  import Pose2D, Twist,Point
from geometry_msgs.msg  import PoseWithCovarianceStamped
from geometry_msgs.msg  import PoseArray
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

# LRS2 -----------------------------------------------------------------------
LRS2_RNG_NUM                 = 1001 #1081 HSRの設定
LRS2_RES_RAD                 = (0.25/180.0*math.pi)
LRS2_POSE_X                  = -0.37
LRS2_POSE_Y                  = 0.0
LRS2_POSE_RAD                = math.pi
LRS2_SKIP_NUM                = 1     # 1;スキップしない


# Fuzzy ---------------------------------------------------------------------
FUZZY_RNG_NUM               = 90
AVOID_T_DIST                = 0.7
NEAR_GOAL_DIST              = 0.6       # 減速開始距離[m]
NEAR_NEAR_GOAL_DIST         = NEAR_GOAL_DIST/1.5    # 障害物回避を無効にする距離[m]
REACHED_GOAL_DIST           = 0.2     # 目標し正確に修正し始める距離[m]
OBST_MARGIN                 = 0.15
R_ROBOT                     = 0.2
R_WAGON                     = 0.2
R_WAGON_LEG                 = 0.7
H_WAGON                     = 0.15


MAX_LINEAR_VELOCITY         = 0.40   # 並進最大速度[m/s]
MAX_WAGON_LINEAR_VELOCITY   = 0.30   # 並進最大速度[m/s]
MAX_ANGULAR_VELOCITY        = 0.7   # 回転最大速度[rad/s]
ANGULAR_KP                  = 0.9   # 回転運動比例ゲイン

(ROT1, MOVE, ROT2,)   = range(0, 3)  # 動作フェーズ（進行方向を向く，移動，ゴール姿勢）

SEARCH_RADIUS = 0.9



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
        print "\n================ HSR Trace ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_navigation")

        # Initialize LRS data --------------------------------------------------
        self.lrs_range      = [10.0 for i in range(LRS_RNG_NUM)]
        self.lrs_rad        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_x        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_y        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_d        = [0.0 for i in range(LRS_RNG_NUM)]
        self.lrs_p_i        = [0.0 for i in range(LRS_RNG_NUM)]
        for i in range(LRS_RNG_NUM):
            self.lrs_rad[i] = i*LRS_RES_RAD - (LRS_RNG_NUM-1)/2*LRS_RES_RAD

        # Initialize LRS data --------------------------------------------------
        self.lrs2_range      = [10.0 for i in range(LRS2_RNG_NUM)]
        self.lrs2_rad        = [0.0 for i in range(LRS2_RNG_NUM)]
        self.lrs2_p_x        = [0.0 for i in range(LRS2_RNG_NUM)]
        self.lrs2_p_y        = [0.0 for i in range(LRS2_RNG_NUM)]
        self.lrs2_p_d        = [0.0 for i in range(LRS2_RNG_NUM)]
        for i in range(LRS2_RNG_NUM):
            self.lrs2_rad[i] = i*LRS2_RES_RAD - (LRS2_RNG_NUM-1)/2*LRS2_RES_RAD

        # Initialize mbsp ------------------------------------------------------
        self.mbsp_t_mix     = [0.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_goal    = [0.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_obst    = [1.0 for i in range(FUZZY_RNG_NUM)]
        self.mbsp_t_obst_temp    = [1.0 for i in range(FUZZY_RNG_NUM)]
        self.area_dist      = [10.0 for i in range(FUZZY_RNG_NUM)]
        self.area_dist2      = [10.0 for i in range(FUZZY_RNG_NUM)]
        self.area_dist_wagon = [10.0 for i in range(FUZZY_RNG_NUM)]
        self.area_dist_wagon2= [10.0 for i in range(FUZZY_RNG_NUM)]
        self.max_grade      = 0.0
        self.max_grade_step = 0
        self.max_grade_rad  = 0.0

        # 速度指令 Publisher ----------------------------------------------------
        self.cmd_vel_publisher      = rospy.Publisher('hsrb/command_velocity', geometry_msgs.msg.Twist, queue_size=1)

        # 確認用 Publisher ------------------------------------------------------
        self.area_publisher         = rospy.Publisher('fuzzy_area', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.wagon_area_publisher   = rospy.Publisher('wagon_fuzzy_area', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_goal_publisher  = rospy.Publisher('mbsp_t_goal', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_obst_publisher  = rospy.Publisher('mbsp_t_obst', std_msgs.msg.Float32MultiArray, queue_size=1)
        self.mbsp_t_mix_publisher   = rospy.Publisher('mbsp_t_mix', std_msgs.msg.Float32MultiArray, queue_size=1)

        # 最大速度設定 rosparam --------------------------------------------------
        self.max_linear_vel     = rospy.get_param('~max_speed', MAX_LINEAR_VELOCITY)
        self.max_angular_vel    = rospy.get_param('~max_turn', MAX_ANGULAR_VELOCITY)

        # goal
        self.goal_x =0
        self.goal_y =0
        self.goal_t =0

        #COG
        self.COG_x =0
        self.COG_y =0

        self.path=[]

        self.withWagon = False

        self.current_pose       = geometry_msgs.msg.Pose2D()
        self.current_pose.x=0
        self.current_pose.y=0
        self.current_pose.theta=0

        # ideal pose Publisher ----------------------------------------------
        self.end_publisher      = rospy.Publisher('/hsr_trace_status', String, queue_size=100)
        self.target_Publisher   = rospy.Publisher('/hsr_target', PoseStamped, queue_size=3)
        self.move_Publisher     = rospy.Publisher('/hsr_moveDirection', PoseStamped, queue_size=3)

        self.traceStatus="stop"
        
        self.first = True
        self.back=False
        self.search_radius_rotation = 0.6
    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # LRS Data Subscriber --------------------------------------------------＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊要修正
        lrs_subscriber      = rospy.Subscriber('/hsrb/base_scan', LaserScan, self.lrsCallback)
        """
        lrs2_subscriber     = rospy.Subscriber('/hsr_urg2/base_scan2', LaserScan, self.lrs2Callback)
        """
        # Current pose Subscriber ----------------------------------------------
        amcl_subscriber     = rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.amclCallback)

        #TF Listener------------------------------------------------------------
        self.tf_listener    = tf.TransformListener()

        # Target pose Subscriber ----------------------------------------------
        start_subscriber    = rospy.Subscriber('/hsr_trace_control', String, self.startCallback)

        # COG pose Subscriber ----------------------------------------------
        cog_subscriber      = rospy.Subscriber('/hsr_cog', Pose2D, self.cogCallback)

        # Path Subscriber ---------------------------------------------------
        path_subscriber     = rospy.Subscriber('/hsr_path', PoseArray, self.pathCallback)

        # Goal Subscriber ---------------------------------------------------
        goal_subscriber     = rospy.Subscriber('/hsr_goal', Pose2D, self.goalCallback)
        
        rospy.Timer(rospy.Duration(0.05), self.tracing)

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
            self.lrs_p_i[i]     = sensor.intensities[i]
    """
    def lrs2Callback(self, sensor):
        for i in range(LRS2_RNG_NUM):
            self.lrs2_range[i]   = sensor.ranges[i]
            self.lrs2_p_x[i]     = LRS2_POSE_X + self.lrs2_range[i]*math.cos(self.lrs2_rad[i] + LRS2_POSE_RAD)
            self.lrs2_p_y[i]     = LRS2_POSE_Y + self.lrs2_range[i]*math.sin(self.lrs2_rad[i] + LRS2_POSE_RAD)
            self.lrs2_p_d[i]     = math.sqrt(self.lrs2_p_x[i]*self.lrs2_p_x[i] + self.lrs2_p_y[i]*self.lrs2_p_y[i])
    """
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

        
        self.current_pose.x     = amcl.pose.pose.position.x
        self.current_pose.y     = amcl.pose.pose.position.y
        self.current_pose.theta = euler[2]

        pose = geometry_msgs.msg.PoseStamped()
        pose.pose.position.x = self.current_pose.x
        pose.pose.position.y = self.current_pose.y
        pose.pose.position.z = 0
        roll=0;
        pitch=0;
        the_dir_angle     =math.atan2((self.COG_y-self.current_pose.y),(self.COG_x-self.current_pose.x))
        if the_dir_angle > math.pi:
            the_dir_angle -= 2.0*math.pi
        elif the_dir_angle < -math.pi:
            the_dir_angle += 2.0*math.pi
        yaw=the_dir_angle
        quat = tf.transformations.quaternion_from_euler(roll, pitch, yaw)
        pose.pose.orientation.x = quat[0]
        pose.pose.orientation.y = quat[1]
        pose.pose.orientation.z = quat[2]
        pose.pose.orientation.w = quat[3]
        pose.header.frame_id = "/map"
        pose.header.stamp = rospy.Time.now()


        the_dir_angle     =math.atan2((self.COG_y-self.current_pose.y),(self.COG_x-self.current_pose.x))-self.current_pose.theta
        if the_dir_angle > math.pi:
            the_dir_angle -= 2.0*math.pi
        elif the_dir_angle < -math.pi:
            the_dir_angle += 2.0*math.pi

        #print the_dir_angle

    #===========================================================================
    #   Get Target Pose
    #===========================================================================
    def getTarget(self):
        maxIndex=-1
        self.goal_t     = 0
        #探索円の中で最もインデックスの値が大きいものを選ぶ
        for index,point in enumerate (self.path):
            distance=math.sqrt(math.pow(self.current_pose.x-point[0],2)+math.pow(self.current_pose.y-point[1],2))
            if distance<=SEARCH_RADIUS  and maxIndex<index:
                maxIndex=int(index)
        if maxIndex!=-1:
            self.goal_x     = self.path[maxIndex][0]
            self.goal_y     = self.path[maxIndex][1]

            targetPose = PoseStamped()
            targetPose.pose.position.x=self.path[maxIndex][0]
            targetPose.pose.position.y=self.path[maxIndex][1]
            targetPose.pose.position.z=0
            targetPose.pose.orientation.x=self.path[maxIndex][2]
            targetPose.pose.orientation.y=self.path[maxIndex][3]
            targetPose.pose.orientation.z=self.path[maxIndex][4]
            targetPose.pose.orientation.w=self.path[maxIndex][5]
            targetPose.header.frame_id ="map"

            self.target_Publisher.publish(targetPose)

            self.path_last_x=self.path[-1][0]
            self.path_last_y=self.path[-1][1]
            e = tf.transformations.euler_from_quaternion((self.path[-1][2], self.path[-1][3], self.path[-1][4], self.path[-1][5]))
            yaw=e[2]
            self.path_last_t=yaw
            self.goal_t     = yaw

        

        #print "\nMove to (", self.goal_x, ", ", self.goal_y, ", ",self.goal_t*180.0/math.pi, ")********"

    #===========================================================================
    #   Get Target Pose
    #===========================================================================
    def getRotationTarget(self):
        maxIndex=-1
        
        #探索円の中で最もインデックスの値が大きいものを選ぶ
        for index,point in enumerate (self.path):
            distance=math.sqrt(math.pow(self.current_pose.x-point[0],2)+math.pow(self.current_pose.y-point[1],2))
            if distance<=self.search_radius_rotation  and maxIndex<index:
                maxIndex=int(index)
        if maxIndex!=-1:
            self.rotation_goal_x     = self.path[maxIndex][0]
            self.rotation_goal_y     = self.path[maxIndex][1]

        self.rotation_goal_t     = 0 
        #print "\nMove to (", self.goal_x, ", ", self.goal_y, ", ",self.goal_t*180.0/math.pi, ")********"

    #===========================================================================
    #   Get COG Pose
    #===========================================================================
    def cogCallback(self, cog):
        
        self.COG_x     = cog.x
        self.COG_y     = cog.y

    #===========================================================================
    #   Get COG Pose
    #===========================================================================
    def goalCallback(self, goal):
        
        self.COG_x     = goal.x
        self.COG_y     = goal.y
        self.COG_theta = goal.theta

    #===========================================================================
    #   Get Path
    #===========================================================================

    def pathCallback(self, pathData):
        print "getPAth"
        self.path=[]
        
        for i in range(len(pathData.poses)):
            point=[]
            point.append(pathData.poses[i].position.x)
            point.append(pathData.poses[i].position.y)
            point.append(pathData.poses[i].orientation.x)
            point.append(pathData.poses[i].orientation.y)
            point.append(pathData.poses[i].orientation.z)
            point.append(pathData.poses[i].orientation.w)
            self.path.append(point)

        

    #===========================================================================
    #   Make Area
    #===========================================================================
    def makeArea(self, obst_avoid_flg):

        the_data            = std_msgs.msg.Float32MultiArray()
        self.area_dist      = [180.0 for i in range(FUZZY_RNG_NUM)]

        if obst_avoid_flg==True:
            #hsr純正のレーザ用
            for i in range(LRS_RNG_NUM):
                # SKIP
                if i % LRS_SKIP_NUM:
                    continue

                # 対応するstep算出
                
                intens  = math.pow(self.lrs_p_i[i],2)+self.lrs_p_d[i]/1000
                angle   = math.atan2(self.lrs_p_y[i], self.lrs_p_x[i])
                step    = self.rad2Step(angle)
                if self.lrs_p_d[i]<1 and intens<600:
                    skip=True
                else:
                    skip=False

                """
                if self.lrs_p_d[i]<1:
                    print " ya"+str(self.lrs_p_i[i]*self.lrs_p_i[i]*self.lrs_p_d[i]/1000)+"  angle"+str(angle/math.pi*180)+"     distance:"+str(self.lrs_p_d[i])
                """
                #print "1 angle:"+str(angle/math.pi*180)+"step:"+str(step)
                
                # 距離情報を反映
                if not skip:
                    if self.lrs_p_d[i] < self.area_dist[step]:
                        self.area_dist[step]   = copy.deepcopy(self.lrs_p_d[i])
            """
            #追加のレーザ用
            for i in range(LRS2_RNG_NUM):
                # SKIP
                if i % LRS2_SKIP_NUM:
                    continue

                # 対応するstep算出
                angle   = math.atan2(self.lrs2_p_y[i], self.lrs2_p_x[i])
                step    = self.rad2Step(angle)
                #print "2 angle:"+str(angle/math.pi*180)+"step:"+str(step)
                
                # 距離情報を反映
                if self.lrs2_p_d[i] < self.area_dist[step]:
                    self.area_dist[step]   = copy.deepcopy(self.lrs2_p_d[i])
            """
        for i in range(FUZZY_RNG_NUM):
            the_data.data.append(self.area_dist[i])

        self.area_publisher.publish(the_data)

    #===========================================================================
    #   fixedArea
    #===========================================================================
    def fixedArea(self, in_goal_x, in_goal_y):
        """
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
        """


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


        for i in range(FUZZY_RNG_NUM):
            the_data_obst.data.append(self.mbsp_t_obst[i])
        #self.mbsp_t_obst_publisher.publish(the_data_obst)

    #===========================================================================
    #   Make Obstacle MF　with wagon
    #===========================================================================
    def makeTObstMFWagon(self,in_dist):

        #手の位置でwagonの有無判定
        try:
            (transH,rotH) = self.tf_listener.lookupTransform('/base_footprint', '/hand_palm_link', rospy.Time(0))
            if transH[0]>0.35:
                self.withWagon = True #wagonあり
            else:
                self.withWagon = False #wagonなし
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            self.withWagon = False
        
        #wagonの足の位置の計算
        if self.withWagon:
            try:
                (trans,rot) = self.tf_listener.lookupTransform('/base_footprint', '/hsr_wagon_tf', rospy.Time(0))
                e = tf.transformations.euler_from_quaternion((rot[0], rot[1], rot[2], rot[3]))
                yaw=e[2]+math.pi/2
                getWagon=True
                dig=math.atan2(3,5)
                wagonRadius=math.sqrt(0.5*0.5+0.3*0.3)/2
                legPos=[[0,0],[0,0],[0,0],[0,0]]
                legPos[0][0]=trans[0]+wagonRadius*math.sin(-yaw+dig)
                legPos[0][1]=trans[1]+wagonRadius*math.cos(-yaw+dig)
                legPos[1][0]=trans[0]+wagonRadius*math.sin(-yaw+(math.pi-dig))
                legPos[1][1]=trans[1]+wagonRadius*math.cos(-yaw+(math.pi-dig))
                legPos[2][0]=trans[0]+wagonRadius*math.sin(-yaw+(math.pi+dig))
                legPos[2][1]=trans[1]+wagonRadius*math.cos(-yaw+(math.pi+dig))
                legPos[3][0]=trans[0]+wagonRadius*math.sin(-yaw+(2*math.pi-dig))
                legPos[3][1]=trans[1]+wagonRadius*math.cos(-yaw+(2*math.pi-dig))
                #print legPos
            except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                getWagon=False
        else:
            getWagon=False
            

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        radius=[R_ROBOT,R_WAGON]
        # ゴールとの距離に応じて障害物回避距離を調整
        if in_dist<NEAR_GOAL_DIST:
            the_obst_margin = OBST_MARGIN*(in_dist/NEAR_GOAL_DIST)*(in_dist/NEAR_GOAL_DIST)
        else:
            the_obst_margin = OBST_MARGIN

        self.mbsp_t_obst    = [1.0 for i in range(FUZZY_RNG_NUM)] # 1.0で初期化

        

        #ワゴン座標系とロボット座標系において、各点群との距離を計算し、近い場合にはメンバシップを削る処理
        for i in range(FUZZY_RNG_NUM):
            
            #各点群の位置の取得
            x=self.area_dist[i]*math.cos(float(i*(360/FUZZY_RNG_NUM))/float(180)*3.14-math.pi);
            y=self.area_dist[i]*math.sin(float(i*(360/FUZZY_RNG_NUM))/float(180)*3.14-math.pi);
            notLeg=True
            
            #点群の位置がワゴンの足に該当するかの確認
            #ワゴンが手元にあり、TFが取得できている場合は４足の位置から足かどうか確認
            if getWagon:
                legDistance1=math.sqrt(math.pow(x-legPos[0][0],2)+math.pow(y-legPos[0][1],2))
                legDistance2=math.sqrt(math.pow(x-legPos[1][0],2)+math.pow(y-legPos[1][1],2))
                legDistance3=math.sqrt(math.pow(x-legPos[2][0],2)+math.pow(y-legPos[2][1],2))
                legDistance4=math.sqrt(math.pow(x-legPos[3][0],2)+math.pow(y-legPos[3][1],2))

                legDistance=[legDistance1,legDistance2,legDistance3,legDistance4]
                for j in range(len(legDistance)):
                    if legDistance[j]<R_WAGON_LEG/2:
                        notLeg=False
                
                distance=math.sqrt(math.pow(x-(trans[0]),2)+math.pow(y-trans[1],2))

                #print "x:"+str(x)+" y:"+str(y)+"    distance:"+str(distance)
                """
                if distance<R_WAGON_LEG:
                    notLeg=False
                """
                """
                print("")
                print(str(i))
                print(wagonRadius)
                print(self.area_dist2[i])
                print(legPos)
                print (str(i)+","+str(notLeg)+","+str(legDistance)+",X="+str(x)+",Y="+str(y)+",trans0="+str(trans[0])+",trans1="+str(trans[1])+",yaw="+str(yaw)+",dig="+str(dig))
                """
                #print (str(i)+","+str(notLeg))
            
            #ワゴンが手元にあるが、TFが取得できていない場合 手の位置に基づき足に該当するか確認
            elif self.withWagon:
                distance=math.sqrt(math.pow(x-(transH[0]+H_WAGON),2)+math.pow(y-transH[1],2))
                
                if distance<R_WAGON_LEG:
                        notLeg=False
                #print (str(i)+","+str(distance))


            
            

            #wagonの足に該当する場合は無視する
            if notLeg:
                #ワゴンの足に該当しない場合

                #ロボット座標系でメンバシップの計算
                # しきい値より近い場合 -------------------------------------------------
                if self.area_dist[i] < AVOID_T_DIST:
                    angle   = math.atan2(y, x)
                    step    = self.rad2Step(angle)
                    # 削る幅
                    if (the_obst_margin + R_ROBOT) > self.area_dist[i]:
                        the_rad_w   = math.pi/2.0;
                    else:
                        the_rad_w   = math.asin((the_obst_margin + R_ROBOT)/self.area_dist[i])

                    # 削る領域 左側 [rad]
                    the_rad_left    = i*(360/FUZZY_RNG_NUM)/180.0*math.pi - math.pi + the_rad_w
                    if the_rad_left > math.pi:
                        the_rad_left -= 2.0*math.pi

                    # 削る領域 右側 [rad]
                    the_rad_right   = i*(360/FUZZY_RNG_NUM)/180.0*math.pi - math.pi - the_rad_w
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

            #else:
                #print(str(i)+'  '+str(self.area_dist2[i])+'  '+str(x)+'  '+str(y)+'  '+str(trans[0])+'  '+str(trans[1])+'  '+str(distance));
              
                #　ワゴン座標系の話
                if self.withWagon:
                    if distance < AVOID_T_DIST:
                        angle   = math.atan2(y-trans[1], x-(trans[0]+H_WAGON))
                        step    = self.rad2Step(angle)
                        # しきい値より近い場合 -------------------------------------------------
                        if (the_obst_margin + R_WAGON) > distance:
                            the_rad_w   = math.pi/2.0;
                        else:
                            the_rad_w   = math.asin((the_obst_margin + R_WAGON)/distance)

                        # 削る領域 左側 [rad]
                        the_rad_left    = step*(360/FUZZY_RNG_NUM)/180.0*math.pi - math.pi + the_rad_w
                        if the_rad_left > math.pi:
                            the_rad_left -= 2.0*math.pi

                        # 削る領域 右側 [rad]
                        the_rad_right   = step*(360/FUZZY_RNG_NUM)/180.0*math.pi - math.pi - the_rad_w
                        if the_rad_right < -math.pi :
                            the_rad_right += 2.0*math.pi

                        # 削る領域 [step]
                        the_step_left   = self.rad2Step(the_rad_left)
                        the_step_right  = self.rad2Step(the_rad_right)

                        # 削る高さ
                        the_h   = (distance-R_WAGON-the_obst_margin)/(AVOID_T_DIST-R_WAGON-the_obst_margin)
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
    def makeTMixMF(self,in_dist):

        the_data_obst   = std_msgs.msg.Float32MultiArray()

        # ゴール方向・障害物に関するMF統合 -------------------------------------------
        for i in range(FUZZY_RNG_NUM):
            if in_dist > NEAR_NEAR_GOAL_DIST:
                self.mbsp_t_mix[i]  = self.mbsp_t_goal[i]*self.mbsp_t_obst[i]
            else:
                self.mbsp_t_mix[i]  = self.mbsp_t_goal[i]


        # グレード最大のstep,値算出 ------------------------------------------------
        the_max_step    = 0
        the_max_grade   = 0.0
        for i in range(FUZZY_RNG_NUM):
            if self.mbsp_t_mix[i] > the_max_grade:
                the_max_grade   = self.mbsp_t_mix[i]
                the_max_step    = i

        self.max_grade      = the_max_grade
        self.max_grade_step = the_max_step
        self.max_grade_rad  = -math.pi + self.max_grade_step*(360/FUZZY_RNG_NUM)/180.0*math.pi

        for i in range(FUZZY_RNG_NUM):
            the_data_obst.data.append(self.mbsp_t_mix[i])
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
                the_step += FUZZY_RNG_NUM
            while the_step > FUZZY_RNG_NUM-1:
                the_step -= (FUZZY_RNG_NUM-1)
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
        deg /=(360/FUZZY_RNG_NUM)
        step = deg+FUZZY_RNG_NUM/2
        while step < 0:
            step += FUZZY_RNG_NUM
        while step > FUZZY_RNG_NUM-1:
            step -= (FUZZY_RNG_NUM-1)
        return step

    #===========================================================================
    #   Step to Rad
    #===========================================================================
    def step2Rad(self, in_step):

        the_deg = (float(in_step) -FUZZY_RNG_NUM/2)*(360/FUZZY_RNG_NUM)

        return the_deg*math.pi/180.0
    

    #===========================================================================
    #   Navigation Handler
    #===========================================================================
    def tracing(self,event):
        cmd_vel = geometry_msgs.msg.Twist()
        self.getTarget()
        # 移動位置の設定 ---------------------------------------------------------
        #print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")********"


        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        
        if self.traceStatus=="start":
            
            the_dist        = math.sqrt((self.goal_x-self.current_pose.x)*(self.goal_x-self.current_pose.x) + (self.goal_y-self.current_pose.y)*(self.goal_y-self.current_pose.y))
            
            #トレースし始めにロボットの方向制御の指針を決定する
            if self.first==True:
                self.getTarget()
                
                try:
                    (transH,rotH) = self.tf_listener.lookupTransform('/base_footprint', '/hand_palm_link', rospy.Time(0))
                    if transH[0]>0.35:
                        self.withWagon = True #wagonあり
                    else:
                        self.withWagon = False #wagonなし
                except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                    self.withWagon = False
                the_angle       = math.atan2((self.goal_y-self.current_pose.y),(self.goal_x-self.current_pose.x))-self.current_pose.theta
                if the_angle>2*math.pi:
                    the_angle-=2*math.pi
                elif the_angle<-2*math.pi:
                    the_angle+=2*math.pi

                if the_angle>math.pi:
                    the_angle-=2*math.pi
                elif the_angle<-math.pi:
                    the_angle+=2*math.pi
                
                #print the_angle
                if self.withWagon:#ワゴンを持っている場合
                    if the_angle<math.pi/2 and the_angle>-math.pi/2:#前方向にパスが出ている場合
                        tts.say('ワゴンを持って向かいます')
                        self.back=False
                    else:#後ろ方向にパスが出ている場合
                        self.back=True
                        tts.say('ワゴンを持ってバックで向かいます')
                        rospy.sleep(1)
                        print "theangle:"+str(the_angle)


                else:#ワゴンを持っていない場合
                    self.back=False

                self.first=False

            # 並進運動のMF作成 ***************************************************
            # 周囲距離情報作成(障害物回避の有無)
            self.makeArea(True)

            # ゴールに関するのMF作成
            self.makeTGoalMF(self.goal_x, self.goal_y)

            # 障害物に関するMF作成
            self.makeTObstMFWagon(the_dist)

            # 並進運動に関するMF作成
            self.makeTMixMF(the_dist)

            # 走行制御 *************************************
            # 自分の姿勢に応じてゴール姿勢を修正 *************************************
            

            the_COGdist        = math.sqrt((self.COG_x-self.current_pose.x)*(self.COG_x-self.current_pose.x) + (self.COG_y-self.current_pose.y)*(self.COG_y-self.current_pose.y))

    
            #ワゴンを持っている場合は、急カーブを防ぐためにバックを許容する
            if self.withWagon:

                #ロボット座標系の向かいたい方向の決定
                
                
                the_pathLastDist        = math.sqrt((self.path_last_x-self.current_pose.x)*(self.path_last_x-self.current_pose.x) + (self.path_last_y-self.current_pose.y)*(self.path_last_y-self.current_pose.y))
                if self.back:
                    changePoseDistance=1.3
                    self.search_radius_rotation = 0.9
                else:
                    changePoseDistance=1.1
                    self.search_radius_rotation = 1.3 #ロボットが姿勢変更をする際に参考にするway pointの距離
                self.getRotationTarget()


                if the_pathLastDist<changePoseDistance: #目的地に近づいてきたら、テーブルに対して90度傾いた形になるように姿勢変更
                    the_dir_goal =math.atan2(self.path_last_y-self.current_pose.y,self.path_last_x-self.current_pose.x)
                    the_final_pose1 =  self.path_last_t+math.pi/2
                    the_final_pose2 =  self.path_last_t-math.pi/2

                    CompareDig = [0,0]
                    CompareDig[0] = the_dir_goal - the_final_pose1
                    CompareDig[1] = the_dir_goal - the_final_pose2
                    for i in range(len(CompareDig)):
                        if CompareDig[i] >2*math.pi:
                            CompareDig[i]-=2*math.pi
                        elif CompareDig[i]<-2*math.pi:
                            CompareDig[i]+=2*math.pi

                    #姿勢変更しやすい角度を選択
                    #print "goal:"+str(the_dir_goal/math.pi*180)
                    #print "final1:"+str(the_final_pose1/math.pi*180)
                    #print "final2:"+str(the_final_pose2/math.pi*180)
                    if abs(CompareDig[0])<abs(CompareDig[1]):
                        target_angle=the_final_pose1-self.current_pose.theta
                        print "target_angle=", target_angle
                    else:
                        target_angle=the_final_pose2-self.current_pose.theta
                        print "target_angle=", target_angle
                else:
                    if self.back:
                        #target_angle=self.max_grade_rad
                        target_angle=math.atan2(self.goal_y-self.current_pose.y,self.goal_x-self.current_pose.x)-self.current_pose.theta
                    else:
                        target_angle=math.atan2(self.rotation_goal_y-self.current_pose.y,self.rotation_goal_x-self.current_pose.x)-self.current_pose.theta

                if self.back:
                    if target_angle>=math.pi/2:
                        the_dir_angle=-(math.pi - target_angle)
                    else:
                        the_dir_angle=-(-math.pi - target_angle)
                else:
                    the_dir_angle=target_angle
                
                
                

            #ワゴンを持っていない場合は、通常通り
            else:
                if the_COGdist<0.3:
                    the_dir_angle=self.COG_theta-self.current_pose.theta
                else:
                    the_dir_angle=math.atan2((self.COG_y-self.current_pose.y),(self.COG_x-self.current_pose.x))-self.current_pose.theta

            if the_dir_angle > math.pi:
                the_dir_angle -= 2.0*math.pi
            elif the_dir_angle < -math.pi:
                the_dir_angle += 2.0*math.pi

            # 並進速度指令値
            if self.withWagon:
                maxLinearVel=MAX_WAGON_LINEAR_VELOCITY
            else:
                maxLinearVel=MAX_LINEAR_VELOCITY

            cmd_vel.linear.x    = maxLinearVel*self.max_grade*math.cos(self.max_grade_rad)
            cmd_vel.linear.y    = maxLinearVel**self.max_grade*math.sin(self.max_grade_rad)
            cmd_vel.linear.z    = 0.0

            # 回転速度指令値
            cmd_vel.angular.x   = 0.0
            cmd_vel.angular.y   = 0.0
            if self.withWagon:#ワゴンを持っている場合は姿勢変更速度を遅くする
                cmd_vel.angular.z   = self.max_angular_vel *the_dir_angle/1.3
            else:
                cmd_vel.angular.z   = self.max_angular_vel *the_dir_angle
            if cmd_vel.angular.z > self.max_angular_vel:
                cmd_vel.angular.z = self.max_angular_vel
            elif cmd_vel.angular.z < -self.max_angular_vel:
                cmd_vel.angular.z = -self.max_angular_vel
        

            if the_dist < REACHED_GOAL_DIST:
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0
                if self.withWagon:
                    cmd_vel.angular.x   = 0.0
                    cmd_vel.angular.y   = 0.0
                    cmd_vel.angular.z   = 0.0
                    self.traceStatus="goal"
                    self.first=True
                else:
                    if math.fabs(the_dir_angle)<TARGET_ANGULAR_TOLERANCE:
                        cmd_vel.angular.x   = 0.0
                        cmd_vel.angular.y   = 0.0
                        cmd_vel.angular.z   = 0.0
                        self.traceStatus="goal"
                        self.first=True
                self.cmd_vel_publisher.publish(cmd_vel)

            
            cmd_pose = PoseStamped()
            cmd_pose.header.frame_id        = "/base_footprint"
            cmd_pose.pose.position.x        = self.max_grade*math.cos(self.max_grade_rad)
            cmd_pose.pose.position.y        = self.max_linear_vel*self.max_grade*math.sin(self.max_grade_rad)
            cmd_pose.pose.position.z        = 0
            q = tf.transformations.quaternion_from_euler(0, 0, self.max_grade_rad)
            cmd_pose.pose.orientation.x     = q[0]
            cmd_pose.pose.orientation.y     = q[1]
            cmd_pose.pose.orientation.z     = q[2]
            cmd_pose.pose.orientation.w     = q[3]
            self.move_Publisher.publish(cmd_pose)

            # print "MOVE: ", the_dist
            """
            # 到着判定 **********************************************************
            # 時間が長すぎる場合: 失敗・速度0
            if (rospy.get_rostime().secs - self.start_time.secs) > MOTION_TIME_TORELANCE:
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0
                self.cmd_vel_publisher.publish(cmd_vel)
                self.traceStatus="timeout"
            """ 

            # 速度指令値をPublish ************************************************
            self.cmd_vel_publisher.publish(cmd_vel)
            #print "vx:", cmd_vel.linear.x, " vy:", cmd_vel.linear.y, " dir:", self.max_grade_rad*180.0/math.pi, " vt:", cmd_vel.angular.z


        # 移動結果を送信 ---------------------------------------------------------
        if  self.traceStatus=="goal":
            rospy.loginfo("end")
            self.end_publisher.publish("end")
            #tts.say('お待たせしました')
            self.traceStatus="stop"
            

        elif  self.traceStatus=="timeout":
            rospy.loginfo("end")
            self.end_publisher.publish("end")
            tts.say('タイムアウトしました')
            self.traceStatus="stop"

    def startCallback(self, data):

        if data.data=="start":
            print "hsr_trace----Start Path Tracing \n"
            #tts.say('向かいます')
            self.traceStatus="start"
            self.start_time=rospy.get_rostime()

        elif data.data=="stop":
            tts.say('')
            self.traceStatus="stop"
            #self.traceStatus="start"

        elif data.data=="please":
            #tts.say('')
            tts.say('通りたいなぁ')
            #self.traceStatus="start"
        
        elif data.data=="restart":
            print "hsr_trace----Start Path Tracing \n"
            tts.say('道を変えてみよう')
            self.traceStatus="start"
            self.start_time=rospy.get_rostime()

################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRNavigation()
    hsr.launchServer()

