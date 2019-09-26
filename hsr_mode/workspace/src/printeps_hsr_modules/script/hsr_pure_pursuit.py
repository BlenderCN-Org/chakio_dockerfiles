#!/usr/bin/python
# -*- coding: utf-8 -*-
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
from nav_msgs.msg   import Odometry 
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


# Fuzzy ---------------------------------------------------------------------

REACHED_GOAL_DIST           = 0.1     # 目標し正確に修正し始める距離[m]

MAX_LINEAR_VELOCITY         = 0.30   # 並進最大速度[m/s]
MAX_WAGON_LINEAR_VELOCITY   = 0.30   # 並進最大速度[m/s]
MAX_ANGULAR_VELOCITY        = 0.7   # 回転最大速度[rad/s]
ANGULAR_KP                  = 0.9   # 回転運動比例ゲイン
WHEEL_BASE                  = 0.65

(ROT1, MOVE, ROT2,)   = range(0, 3)  # 動作フェーズ（進行方向を向く，移動，ゴール姿勢）

SEARCH_RADIUS = 0.40

################################################################################
#                              HSR Pure Pursuit                                #
################################################################################
class HSRPurepursuit:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Trace ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_navigation")
        # 速度指令 Publisher ----------------------------------------------------
        self.cmd_vel_publisher      = rospy.Publisher('hsrb/command_velocity', geometry_msgs.msg.Twist, queue_size=1)
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
        self.actualRobotVelocity=[0,0,0]

        self.withWagon = False

        self.current_pose       = geometry_msgs.msg.Pose2D()
        self.current_pose.x=0
        self.current_pose.y=0
        self.current_pose.theta=0

        # ideal pose Publisher ----------------------------------------------
        self.target_Publisher   = rospy.Publisher('/hsr_purepuersuit_target', PoseStamped, queue_size=3)
        self.wagonPose_Publisher   = rospy.Publisher('/hsr_purepuersuit_wagon', PoseStamped, queue_size=3)

        self.traceStatus="stop"
        
        self.first = True
        self.back=False
        self.search_radius_rotation = 0.6
    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):
        #TF Listener------------------------------------------------------------
        self.tf_listener                = tf.TransformListener()

        # Target pose Subscriber ----------------------------------------------
        start_subscriber                = rospy.Subscriber('/hsr_purepursuit_control', String, self.startCallback)

        # Path Subscriber ---------------------------------------------------
        path_subscriber                 = rospy.Subscriber('/hsr_purepursuit_path', PoseArray, self.pathCallback)
        
        # actual velocity subscriber ----------------------------------------
        actual_velocity_subscriber      = rospy.Subscriber('/hsrb/wheel_odom', Odometry, self.actualVelocityCallback)
        
        rospy.Timer(rospy.Duration(0.05), self.tracing)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    #===========================================================================
    #   Get Target Pose
    #===========================================================================
    def getTarget(self):
        maxIndex=-1
        self.goal_t     = 0
        # ロボットの現在の位置を取得する
        try:
            (robotPos,robotDirectionQuat) = self.tf_listener.lookupTransform( '/map','/base_link', rospy.Time(0))
            robotDirection = tf.transformations.euler_from_quaternion(robotDirectionQuat)
            wagonPos=[0,0]
            wagonPos[0] = robotPos[0]+WHEEL_BASE*math.cos(robotDirection[2])
            wagonPos[1] = robotPos[1]+WHEEL_BASE*math.sin(robotDirection[2])
            #探索円の中で最もインデックスの値が大きいものを選ぶ
            maxDistance=0
            print(robotPos)
            print(wagonPos)
            for index in range(len(self.path)):
                distance=math.sqrt(math.pow(wagonPos[0]-self.path[index][0],2)+math.pow(wagonPos[1]-self.path[index][1],2))
                #print(trans)
                #print(point)
                #print(distance)
                if distance<=SEARCH_RADIUS  and maxIndex<index:
                    maxIndex=int(index)
                    maxDistance=distance
            print(maxIndex)
            print(maxDistance)
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

        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            print("exception")
            pass

        
        
        

        #print "\nMove to (", self.goal_x, ", ", self.goal_y, ", ",self.goal_t*180.0/math.pi, ")********"

    #===========================================================================
    #   Get Path
    #===========================================================================

    def pathCallback(self, pathData):
        print "getPath"
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
    #   Get Actual Velocity
    #===========================================================================
    def actualVelocityCallback(self,data):
        self.actualRobotVelocity[0] = data.twist.twist.linear.x
        self.actualRobotVelocity[1] = data.twist.twist.linear.y
        self.actualRobotVelocity[2] = data.twist.twist.angular.z
    

    #===========================================================================
    #   Navigation Handler
    #===========================================================================
    def tracing(self,event):
        cmd_vel = geometry_msgs.msg.Twist()
        # 移動位置の設定 ---------------------------------------------------------
        #print "\nMove to (", goal.pose.x, ", ", goal.pose.y, ", ", goal.pose.theta*180.0/math.pi, ")********"
        # 目標姿勢になるまでFuzzy制御 -----------------------------------------------
        
        if self.traceStatus=="start":
            self.getTarget()
            try:
                back = False
                (robotPos,robotDirectionQuat) = self.tf_listener.lookupTransform( '/map','/base_link', rospy.Time(0))
                robotDirection = tf.transformations.euler_from_quaternion(robotDirectionQuat)
                wagonPos=robotPos
                wagonPos[0] += WHEEL_BASE*math.cos(robotDirection[2])
                wagonPos[1] += WHEEL_BASE*math.sin(robotDirection[2])
                the_dist = 1000
                the_dist = math.sqrt(math.pow(wagonPos[0]-self.path[len(self.path)-1][0],2)+math.pow(wagonPos[1]-self.path[len(self.path)-1][1],2))
                
                # pure pursuitによる旋回半径の決定
                L = math.sqrt(math.pow(self.goal_y - wagonPos[1], 2) + math.pow(self.goal_x - wagonPos[0], 2))
                
                wagonDirection = robotDirection[2] + math.pi
                moveDirection = math.atan2(self.goal_y - wagonPos[1], self.goal_x - wagonPos[0])
                differentDirection = wagonDirection - moveDirection
                # -M_PI~M_PIに変換
                if differentDirection > math.pi:
                    differentDirection -= 2 * math.pi
                elif differentDirection < -math.pi:
                    differentDirection += 2 * math.pi
                    
                # ワゴンの旋回半径の取得
                wagonVelocityRadius = L / (2 * math.sin(differentDirection))
                # バックかどうかの判定
                if differentDirection>math.pi/2.0 or differentDirection<-math.pi/2.0:
                    back = True
                    print "back"
                print "==========Pure puersuit==========" 
                print "L:",L ,"differentDirection:", differentDirection
                print "wagonVelocityRadius:", wagonVelocityRadius
                    
                # ワゴンの旋回半径を実現するようなロボットの入力の決定
                robotVelocity = MAX_LINEAR_VELOCITY
                if the_dist<SEARCH_RADIUS*0.8:
                    robotVelocity =the_dist/(SEARCH_RADIUS*0.8)*MAX_LINEAR_VELOCITY
                # ロボットの旋回半径の算出
                robotVelocityRadius = math.sqrt(math.pow(WHEEL_BASE, 2) + math.pow(wagonVelocityRadius, 2))
                # ロボットの角速度の算出
                actualVelocity = math.sqrt(math.pow(self.actualRobotVelocity[0], 2) + math.pow(self.actualRobotVelocity[1], 2))
                robotAngularVelocity = actualVelocity / robotVelocityRadius
                if wagonVelocityRadius<0:
                    robotAngularVelocity *= -1
                # バックの適用
                if not back:
                    robotVelocity *= -1
                    robotAngularVelocity *= -1
                    
                # 接線方向の算出
                robotDirection = math.atan(WHEEL_BASE / (wagonVelocityRadius))
            
                print "==========Robot Control==========" 
                print " robotVelocityRadius:", robotVelocityRadius,"robotAngularVelocity:",robotAngularVelocity
                print "robotDirection:",robotDirection

                # 並進速度指令値
                cmd_vel.linear.x    = robotVelocity * math.cos(robotDirection)
                cmd_vel.linear.y    = -robotVelocity * math.sin(robotDirection)
                cmd_vel.linear.z    = 0.0

                # 回転速度指令値
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = robotAngularVelocity
                print "==========Command Velocity==========" 
                print "vx:", cmd_vel.linear.x, " vy:", cmd_vel.linear.y, " vt:", cmd_vel.angular.z
                print("")
            except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                print("exception")
                pass
        

            if the_dist < REACHED_GOAL_DIST:
                cmd_vel.linear.x    = 0.0
                cmd_vel.linear.y    = 0.0
                cmd_vel.linear.z    = 0.0
                
                cmd_vel.angular.x   = 0.0
                cmd_vel.angular.y   = 0.0
                cmd_vel.angular.z   = 0.0
                self.traceStatus = "stop"
            self.cmd_vel_publisher.publish(cmd_vel)
            
            wagonPose = PoseStamped()
            wagonPose.pose.position.x=wagonPos[0]
            wagonPose.pose.position.y=wagonPos[1]
            wagonPose.pose.position.z=0
            wagonPose.pose.orientation.x=0
            wagonPose.pose.orientation.y=0
            wagonPose.pose.orientation.z=0
            wagonPose.pose.orientation.w=0
            wagonPose.header.frame_id ="map"
            self.wagonPose_Publisher.publish(wagonPose)


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
            # self.cmd_vel_publisher.publish(cmd_vel)
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

################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRPurepursuit()
    hsr.launchServer()