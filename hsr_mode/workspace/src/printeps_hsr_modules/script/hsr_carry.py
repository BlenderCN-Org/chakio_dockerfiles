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
from printeps_hsr_modules.msg   import HsrObstacleArray
from printeps_hsr_modules.msg   import HsrObstacle
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.srv   import HsrGlbNav
from printeps_hsr_modules.srv   import HsrGlbNavResponse
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
    Pet.x               =0.20
    Pet.y               =-1.10
    Pet.theta           =-1.57

    #Table1
    Table1                 =Pose2D()
    Table1.x               = 2.70
    Table1.y               = -1.30
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

    # Hold Server --------------------------------------------------------
hold_client = rospy.ServiceProxy('hsr_hold_object', HsrHoldObject)

    # Release Server --------------------------------------------------------
release_client = rospy.ServiceProxy('hsr_release_object', HsrReleaseObject)

    # Navigation Server ----------------------------------------------------
glbNav_client  = rospy.ServiceProxy('hsr_global_navigation', HsrGlbNav)

"""
    # Log Server ----------------------------------------------------
log_client  = rospy.ServiceProxy('hsr_log', HsrLog)

    # LogP Server ----------------------------------------------------
log_p_client  = rospy.ServiceProxy('hsr_log_p', HsrLogP)
"""

tflistener = tf.TransformListener()
        
glbNavMotion   =    HsrGlbNav()
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
        rospy.Subscriber("hsr_obstacles",HsrObstacleArray, self.obstacle_cb)
        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_hold_object")

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Hold Server --------------------------------------------------------
        pickandplace_server = rospy.Service('hsr_carry', HsrCarry, self.carryHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()
    
    #===========================================================================
    #   Obstacle Callback
    #===========================================================================
    def obstacle_cb(self,data):
        self.Table=[]
        for table in data.obstacles:
            self.Table.append(table.table.pose)

    
    #===========================================================================
    #   Pick And Place Handler
    #===========================================================================
    def carryHandler(self, object):

        print "----------- Carry --------------"
        self.destination    =object.destination
        print "Destination:"+self.destination
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        if  self.destination == 'Pet':
            # PetFrom
            self.base_x                         = self.Table[6].x
            self.base_y                         = self.Table[6].y
            self.base_theta                     = self.Table[6].theta
            self.pose_to_destination_x          = self.base_x  
            self.pose_to_destination_y          = self.base_y-1.40
            self.pose_to_destination_theta      = 1.57
        elif self.destination == 'Table1': 
            self.pose_to_destination_x          = self.Table[0].x
            self.pose_to_destination_y          = self.Table[0].y
            self.pose_to_destination_theta      = self.Table[0].theta
        elif self.destination == 'Table2': 
            self.pose_to_destination_x          = self.Table[1].x
            self.pose_to_destination_y          = self.Table[1].y
            self.pose_to_destination_theta      = self.Table[1].theta
        elif self.destination == 'Table3': 
            self.pose_to_destination_x          = self.Table[2].x
            self.pose_to_destination_y          = self.Table[2].y
            self.pose_to_destination_theta      = self.Table[2].theta
        elif self.destination == 'Table4':
            self.pose_to_destination_x          = self.Table[3].x
            self.pose_to_destination_y          = self.Table[3].y
            self.pose_to_destination_theta      = self.Table[3].theta
        elif self.destination == 'Table5':
            self.pose_to_destination_x          = self.Table[4].x
            self.pose_to_destination_y          = self.Table[4].y
            self.pose_to_destination_theta     = self.Table[4].theta
        elif self.destination == 'Table6':
            self.pose_to_destination_x          = self.Table[5].x
            self.pose_to_destination_y          = self.Table[5].y
            self.pose_to_destination_theta      = self.Table[5].theta
        else:
            return HsrCarryResponse(success=False)


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
            return HsrCarryResponse(success=True)
        else:
            print "モジュールを実行に失敗しました\n"
            return HsrCarryResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performCarry(self):
    
        # ワゴンのある位置の前に移動する
        try:
             (transH,rotH) = tflistener.lookupTransform('/map', '/hsr_wagon_tf', rospy.Time(0))
             eH = tf.transformations.euler_from_quaternion(rotH)
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            
            return False;   
        
        distanceFromWagon=1
        self.pose_to_nearWagon=geometry_msgs.msg.Pose2D()
        self.pose_to_nearWagon.x=transH[0]+distanceFromWagon*math.sin(eH[2])
        self.pose_to_nearWagon.y=transH[1]-distanceFromWagon*math.cos(eH[2])
        self.pose_to_nearWagon.theta=eH[2]+math.pi/2
        glbNav_client(self.pose_to_nearWagon) 
        #print transH
        #print eH
        #print self.pose_to_nearWagon
        # カートをつかむ
        holdMotion='Wagon'
        
        hold_client(holdMotion)
         
        """
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
        """

        # テーブルの前まで移動する
  
        
        glbNav_client(self.pose_to_destination) 
           

        rospy.sleep(0.4)
       
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
