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
from printeps_hsr_modules.srv   import HsrNav3
from printeps_hsr_modules.srv   import HsrNav3Response
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
from printeps_hsr_modules.srv   import HsrCarry2017
from printeps_hsr_modules.srv   import HsrCarry2017Response
"""
from printeps_hsr_modules.srv   import HsrLog
from printeps_hsr_modules.srv   import HsrLogResponse
from printeps_hsr_modules.srv   import HsrLogP
from printeps_hsr_modules.srv   import HsrLogPResponse
"""
################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')

# position setting ---------------------------------------------------------
facalty=False; # ファカルティラウンジの場合
#facalty=False; # 07棟の場合
if facalty:
    #pet
    Pet                 =Pose2D()
    Pet.x               =1.3
    Pet.y               =-1.0
    Pet.theta           =-1.57

    #Table1
    Table1                 =Pose2D()
    Table1.x               = 3.50
    Table1.y               = -1.0
    Table1.theta           =-1.57

    #Table2
    Table2                 = Pose2D()
    Table2.x               = 6.00
    Table2.y               = -1.0
    Table2.theta           = -1.57

    #Table3
    Table3                 = Pose2D()
    Table3.x               = 3.05
    Table3.y               = 1.95
    Table3.theta           = 0

    #Table4
    Table4                 = Pose2D()
    Table4.x               = 5.55
    Table4.y               = 1.95
    Table4.theta           = 0
else:
    #pet
    Pet                 =Pose2D()
    Pet.x               =-0.30
    Pet.y               =-2.30
    Pet.theta           =-1.57

    #Table1
    Table1                 =Pose2D()
    Table1.x               = 2.70
    Table1.y               = -2.30
    Table1.theta           =-1.57

    #Table2
    Table2                 =Pose2D()
    Table2.x               = 3.10
    Table2.y               = -1.30
    Table2.theta           =-1.57

    #Table3
    Table3                 =Pose2D()
    Table3.x               = 2.40
    Table3.y               = 1.20
    Table3.theta           =0

    #trashbox
    Trash                  =Pose2D()
    Trash.x                =-0.50
    Trash.y                = -1.10
    Trash.theta            =-1.57



# ServiceClient ------------------------------------------------------------

    # Navigation Server ----------------------------------------------------
nav_client  = rospy.ServiceProxy('hsr_navigation', HsrNav)

    # Navigation Server ----------------------------------------------------
nav2_client  = rospy.ServiceProxy('hsr_navigation2', HsrNav2)

    # Navigation Server ----------------------------------------------------
nav3_client  = rospy.ServiceProxy('hsr_navigation3', HsrNav3)

    # PickUpObject Server --------------------------------------------------------
pick_up_client = rospy.ServiceProxy('hsr_pick_up_object', HsrPickUpObject)

    # Place Server --------------------------------------------------------
place_client = rospy.ServiceProxy('hsr_place_object', HsrPlaceObject)

    # Hold Server --------------------------------------------------------
hold_client = rospy.ServiceProxy('hsr_hold_object', HsrHoldObject)

    # Release Server --------------------------------------------------------
release_client = rospy.ServiceProxy('hsr_release_object', HsrReleaseObject)

"""
    # Log Server ----------------------------------------------------
log_client  = rospy.ServiceProxy('hsr_log', HsrLog)

    # LogP Server ----------------------------------------------------
log_p_client  = rospy.ServiceProxy('hsr_log_p', HsrLogP)
"""

tflistener = tf.TransformListener()
        
navMotion      =    HsrNav()
nav2Motion     =    HsrNav2()
nav3Motion     =    HsrNav3()
pickupMotion   =    HsrPickUpObject()
placeMotion    =    HsrPlaceObject()
holdMotion     =    HsrHoldObject()
releaseMotion  =    HsrReleaseObject()
"""
logMotion      =    HsrLog()
logpMotion      =    HsrLogP()
"""

################################################################################
#                               HSR Pick And PLace                             #
################################################################################
class HSRCarry:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Carry ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_hold_object")

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Hold Server --------------------------------------------------------
        pickandplace_server = rospy.Service('_hsr_carry', HsrCarry2017, self.carryHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    
    #===========================================================================
    #   Pick And Place Handler
    #===========================================================================
    def carryHandler(self, object):

        print "----------- Carry --------------"
       
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if(object.pose_B=='Pet'):
            self.base_x                = Pet.x
            self.base_y                = Pet.y
            self.base_theta            = Pet.theta
        
        elif(object.pose_B=='Table1'):
            self.base_x                = Table1.x
            self.base_y                = Table1.y
            self.base_theta            = Table1.theta
        
        elif(object.pose_B=='Table2'):
            self.base_x                = Table2.x
            self.base_y                = Table2.y
            self.base_theta            = Table2.theta
        
        elif(object.pose_B=='Table3'):
            self.base_x                = Table3.x
            self.base_y                = Table3.y
            self.base_theta            = Table3.theta
        
        elif(object.pose_B=='Table4'):
            self.base_x                = Table4.x
            self.base_y                = Table4.y
            self.base_theta            = Table4.theta
        else:
            return HsrCarryResponse(success=False)


        if(object.pose_D=='Pet'):
            self.destination='Pet'
            self.destination_x         = Pet.x
            self.destination_y         = Pet.y
            self.destination_theta     = Pet.theta
            self.starttalk="ごゆっくりどうぞ"
            self.endtalk="戻りました"
        elif(object.pose_D=='Table1'):
            self.destination='Table1'
            self.destination_x         = Table1.x
            self.destination_y         = Table1.y
            self.destination_theta     = Table1.theta
            self.starttalk="テーブル1番に向かいます"
            self.endtalk="テーブル1番に到着しました"
        
        elif(object.pose_D=='Table2'):
            self.destination='Table2'
            self.destination_x         = Table2.x
            self.destination_y         = Table2.y
            self.destination_theta     = Table2.theta
            self.starttalk="テーブル2番に向かいます"
            self.endtalk="テーブル2番に到着しました"
        
        elif(object.pose_D=='Table3'):
            self.destination='Table3'
            self.destination_x         = Table3.x
            self.destination_y         = Table3.y
            self.destination_theta     = Table3.theta
            self.starttalk="テーブル3番に向かいます"
            self.endtalk="テーブル3番に到着しました"
        
        elif(object.pose_D=='Table4'):
            self.destination='Table4'
            self.destination_x         = Table4.x
            self.destination_y         = Table4.y
            self.destination_theta     = Table4.theta
            self.starttalk="テーブル4番に向かいます"
            self.endtalk="テーブル4番に到着しました"
        else:
            return HsrCarryResponse(success=False)

        
        #print "Base:"+ self.base_x, ", ", self.base_y, ", ", self.base_theta*180.0/math.pi)
        #print "Destination:"+ self.destination_x, ", ", self.destination_y, ", ", self.destination_theta*180.0/math.pi, ")
        if facalty:
            if object.pose_B=='Table3' or object.pose_B=='Table4':
                self.pose_to_object_x            = self.base_x-0.80
                self.pose_to_object_y            = -0.25
                self.pose_to_object_theta        = 0
            else:
                self.pose_to_object_x            = self.base_x-0.2
                self.pose_to_object_y            = self.base_y+0.8
                self.pose_to_object_theta        = 0

            if object.pose_D=='Table3' or object.pose_D=='Table4':
                self.pose_to_destination_x       = self.destination_x+0.2
                self.pose_to_destination_y       = -0.25
                self.pose_to_destination_theta   = 0
            else:
                self.pose_to_destination_x       = self.destination_x+0.7
                self.pose_to_destination_y       = self.destination_y+0.7
                self.pose_to_destination_theta   = 0
        else:
            self.pose_to_object_x            = self.base_x-0.00
            self.pose_to_object_y            = self.base_y+0.6
            self.pose_to_object_theta        = 0

            if object.pose_D=='Table3' or object.pose_D=='Table4':
                self.pose_to_destination_x       = self.destination_x-0.3
                self.pose_to_destination_y       = -0.25
                self.pose_to_destination_theta   = 0
            else:
                self.pose_to_destination_x       = self.destination_x+0.7
                self.pose_to_destination_y       = self.destination_y+0.55
                self.pose_to_destination_theta   = 0
       
        self.pose_to_object=geometry_msgs.msg.Pose2D()
        self.pose_to_object.x=self.pose_to_object_x
        self.pose_to_object.y=self.pose_to_object_y
        self.pose_to_object.theta=self.pose_to_object_theta

        self.pose_to_destination=geometry_msgs.msg.Pose2D()
        self.pose_to_destination.x=self.pose_to_destination_x
        self.pose_to_destination.y=self.pose_to_destination_y
        self.pose_to_destination.theta=self.pose_to_destination_theta

        """
        #//////////////////////// LOG 開始 //////////////////////////////////////
        logMotion.log=True;
        logMotion.IMU=True;
        logMotion.LRF=True;
        logMotion.Wrist=True;
        logMotion.Joint=True;
        logMotion.TF=True;
        
        sO=object.pose_B;
        sD=object.pose_D
        sMode='Carry';
        sUnder='_';
        sTo='to';
        
        logMotion.mode=sMode+sUnder+sO+sTo+sD;

        log_client(logMotion.log,logMotion.IMU,logMotion.LRF,logMotion.Wrist,logMotion.Joint,logMotion.TF,logMotion.mode)


        logpMotion.log=True;
        logpMotion.PCD=False;
       
        
        logpMotion.mode=sMode+sUnder+sO+sTo+sD;

        log_p_client(logpMotion.log,logpMotion.PCD,logpMotion.mode)
        """
        #//////////////////////// Carryを実行 //////////////////////////
        the_success = self.performCarry()

        """
        #//////////////////////// LOG 停止 //////////////////////////////////////

        logMotion.log=False
        logMotion.IMU=False
        logMotion.LRF=False
        logMotion.Wrist=False
        logMotion.Joint=False
        logMotion.TF=False
        
        sMode=''
        logMotion.mode=sMode

        log_client(logMotion.log,logMotion.IMU,logMotion.LRF,logMotion.Wrist,logMotion.Joint,logMotion.TF,logMotion.mode)
        
        logpMotion.log=False
        logpMotion.PCD=False
       
        
        sO=object.pose_B;
        sD=object.pose_D
        sMode='Carry';
        sUnder='_';
        sTo='to';
       
        
        logpMotion.mode=sMode

        log_p_client(logpMotion.log,logpMotion.PCD,logpMotion.mode)
        """

        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "モジュールを実行しました\n"
            return HsrCarry2017Response(success=True)
        else:
            print "モジュールを実行に失敗しました\n"
            return HsrCarry2017Response(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performCarry(self):
        wagonsensing = False
        try:
             (transH,rotH) = tflistener.lookupTransform('/map', '/hsr_wagon_tf', rospy.Time(0))
             wagonsensing = True
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
           pass
           
        if wagonsensing:
            # カートをつかむ
            holdMotion='Wagon'
            
            hold_client(holdMotion)
        else:
            # 物体のある位置の前に移動する
            nav3Motion.pose = self.pose_to_object
            nav3Motion.obstacle_avoidance   = True
            nav3Motion.first_rot_limit      = 10.0
            nav3Motion.velocity             = 0.4
            
            nav3_client(nav3Motion.pose,nav3Motion.obstacle_avoidance,nav3Motion.first_rot_limit,nav3Motion.velocity) 
       
            # カートをつかむ
            holdMotion='Cart'
            
            hold_client(holdMotion)
         

        # 腕と本体の相対座標を取得 
        try:
             (transH,rotH) = tflistener.lookupTransform('/map', '/hand_palm_link', rospy.Time(0))
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            whole_body.move_to_go()
            return False;   
        try:
             (transB,rotB) = tflistener.lookupTransform('/map', '/base_footprint', rospy.Time(0))
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            whole_body.move_to_go()
            return False;   
        
        eH = tf.transformations.euler_from_quaternion(rotH)
        eB = tf.transformations.euler_from_quaternion(rotB)
        
        xb=transB[0]
        yb=transB[1]
        tb=eB[2]

        xh=transH[0]
        yh=transH[1]
        th=eH[2]+1.57


        xb2=self.pose_to_destination.x-(xh-xb)
        yb2=self.pose_to_destination.y-(yh-yb)
        tb2=eB[2]

        t2=math.atan2((yh-yb),(xh-xb))
        R=math.sqrt((xh-xb)*(xh-xb)+(yh-yb)*(yh-yb))


        xb3=xb2+R*(math.cos(t2)-math.cos(t2-th))
        yb3=yb2+R*(math.sin(t2)-math.sin(t2-th))
        tb3=tb-th
        

        self.pose_to_destination.x=xb3
        self.pose_to_destination.y=yb3
        self.pose_to_destination.theta=tb3
        

        # テーブルの前まで移動する
        tts.say(self.starttalk)
        if self.destination=='Pet':
            nav3Motion.first_rot_limit      = 10.0
        else:
            nav3Motion.first_rot_limit      = 1.0
        nav3Motion.pose = self.pose_to_destination
        nav3Motion.obstacle_avoidance = False
        nav3Motion.velocity             = 0.2

        
        nav3_client(nav3Motion.pose,nav3Motion.obstacle_avoidance,nav3Motion.first_rot_limit,nav3Motion.velocity ) 
           

        rospy.sleep(0.4)
        tts.say(self.endtalk)
        # カートを離す
        releaseMotion='Cart'
        
        release_client(releaseMotion) 
          

        return True


################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRCarry()
    hsr.launchServer()
