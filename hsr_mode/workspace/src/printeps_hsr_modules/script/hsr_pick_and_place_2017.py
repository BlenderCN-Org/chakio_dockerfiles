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
from printeps_hsr_modules.srv   import HsrPickAndPlace
from printeps_hsr_modules.srv   import HsrPickAndPlaceResponse
# from printeps_hsr_modules.srv   import HsrLog
# from printeps_hsr_modules.srv   import HsrLogResponse
# from printeps_hsr_modules.srv   import HsrLogP
# from printeps_hsr_modules.srv   import HsrLogPResponse

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
#facalty=True; # ファカルティラウンジの場合
facalty=False # 07棟の場合
if facalty:
    #pet
    Pet                 =Pose2D()
    Pet.x               =1.5
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

    #trashbox
    Trash                  =Pose2D()
    Trash.x                =0.75
    Trash.y                =-1.0
    Trash.theta            =-1.57

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
    Table3.x               = 2.30
    Table3.y               = 0.80
    Table3.theta           =0

    #trashbox
    Trash                  =Pose2D()
    Trash.x                =-0.50
    Trash.y                = -1.30
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

    # Log Server ----------------------------------------------------
# log_client  = rospy.ServiceProxy('hsr_log', HsrLog)

    # LogP Server ----------------------------------------------------
# log_p_client  = rospy.ServiceProxy('hsr_log_p', HsrLogP)
        
navMotion      =    HsrNav()
nav2Motion     =    HsrNav2()
nav3Motion     =    HsrNav3()
pickupMotion   =    HsrPickUpObject()
placeMotion    =    HsrPlaceObject()
holdMotion     =    HsrHoldObject()
releaseMotion  =    HsrReleaseObject()
# logMotion      =    HsrLog()
# logpMotion      =    HsrLogP()

    
################################################################################
#                               HSR Pick And PLace                             #
################################################################################
class HSRPickAndPlace:

    #===========================================================================
    #   Constructor
    #===========================================================================        # Initialize node ------------------------------------------------------

    def __init__(self):
        print "\n================ HSR Pick And PLace ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_pick_and_place")

    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Hold Server --------------------------------------------------------
        pickandplace_server = rospy.Service('_hsr_pick_and_place', HsrPickAndPlace, self.pickAndPlaceHandler)
        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    
    #===========================================================================
    #   Pick And Place Handler
    #===========================================================================
    def pickAndPlaceHandler(self, object):

        print "----------- Pick and Place --------------"
        
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        

        self.object_place   =object.object_place

        self.destination    =object.destination

        self.object_name    =object.object_name 

        print "Object Place:"+self.object_place
        #print "Base:"+ self.base_x +", "+ self.base_y+", "+ self.base_theta*180.0/math.pi
        print "Destination:"+self.destination

        if self.object_place =='hand':
            self.pose_to_object_x            = 0  
            self.pose_to_object_y            = 0
            self.pose_to_object_theta        = 0

        if self.object_place =='hand':
            self.pose_to_destination_x       = 0
            self.pose_to_destination_y       = 0
            self.pose_to_destination_theta   = 0
        
        if  self.object_place == 'Pet1' or self.object_place == 'Pet2' or self.object_place == 'Pet3' or self.object_place == 'Pet4' or self.object_place == 'Pet5' or self.object_place == 'Pet6':
            # PetFrom
            self.base_x         =Pet.x
            self.base_y         =Pet.y
            self.base_theta     =Pet.theta
            self.pose_to_object_x            = self.base_x  
            self.pose_to_object_y            = self.base_y+0.60
            self.pose_to_object_theta        =-1.57

        elif self.object_place == 'Cart1' or self.object_place == 'Cart2' or self.object_place == 'Cart3' or self.object_place == 'Cart4':
            # CartFrom
            if self.destination == 'Table31' or self.destination == 'Table32' or self.destination == 'Table33' or self.destination == 'Table34'or self.destination == 'Table41' or self.destination == 'Table42'or self.destination == 'Table43' or self.destination == 'Table44':
                if self.destination == 'Table31' or self.destination == 'Table32'or self.destination == 'Table33' or self.destination == 'Table34':
                    self.base_x         =Table3.x
                    self.base_y         =Table3.y
                    self.base_theta     =Table3.theta
                else:
                    self.base_x         =Table4.x
                    self.base_y         =Table4.y
                    self.base_theta     =Table4.theta
                self.pose_to_object_x            = self.base_x -0.70 
                self.pose_to_object_y            =-0.3
                self.pose_to_object_theta        =0
            elif self.destination == 'Table11' or self.destination == 'Table12'or self.destination == 'Table13'or self.destination == 'Table14'or self.destination == 'Table21' or self.destination == 'Table22'or self.destination == 'Table23'or self.destination == 'Table24':
                if self.destination == 'Table11' or self.destination == 'Table12'or self.destination == 'Table13'or self.destination == 'Table14':
                    self.base_x         =Table1.x-0.2
                    self.base_y         =Table1.y
                    self.base_theta     =Table1.theta
                else:
                    self.base_x         =Table2.x-0.2
                    self.base_y         =Table2.y
                    self.base_theta     =Table2.theta
                self.pose_to_object_x            = self.base_x -0.00 
                self.pose_to_object_y            = self.base_y+0.90
                self.pose_to_object_theta        =0

            elif self.destination=='Trash':
                self.base_x         =Pet.x
                self.base_y         =Pet.y
                self.base_theta     =Pet.theta
                self.pose_to_object_x       = self.base_x -0.00 
                self.pose_to_object_y       = self.base_y+0.80
                self.pose_to_object_theta   = 0
                
                 
        elif self.object_place == 'Table11' or self.object_place == 'Table12' or self.object_place == 'Table13' or self.object_place == 'Table14' or self.object_place == 'Table21' or self.object_place == 'Table22' or self.object_place == 'Table23' or self.object_place == 'Table24' or self.object_place == 'Table31' or self.object_place == 'Table32' or self.object_place == 'Table33' or self.object_place == 'Table34' or self.object_place == 'Table41' or self.object_place == 'Table42'or self.object_place == 'Table43' or self.object_place == 'Table44':
            if self.object_place == 'Table11' or self.object_place == 'Table12' or self.object_place == 'Table13' or self.object_place == 'Table14': 
                self.base_x         =Table1.x
                self.base_y         =Table1.y
                self.base_theta     =Table1.theta
            elif self.object_place == 'Table21' or self.object_place == 'Table22' or self.object_place == 'Table23' or self.object_place == 'Table24': 
                self.base_x         =Table2.x
                self.base_y         =Table2.y
                self.base_theta     =Table2.theta
            elif self.object_place == 'Table31' or self.object_place == 'Table32'or self.object_place == 'Table33' or self.object_place == 'Table34': 
                self.base_x         =Table3.x
                self.base_y         =Table3.y
                self.base_theta     =Table3.theta
            elif self.object_place == 'Table41' or self.object_place == 'Table42'or self.object_place == 'Table43' or self.object_place == 'Table44':
                self.base_x         =Table4.x
                self.base_y         =Table4.y
                self.base_theta     =Table4.theta
            self.pose_to_object_x       = self.base_x -0.7*math.cos(self.base_theta) 
            self.pose_to_object_y       = self.base_y-0.7*math.sin(self.base_theta) 
            self.pose_to_object_theta   = self.base_theta
       
        if self.destination == 'Cart1' or self.destination == 'Cart2' or self.destination == 'Cart3' or self.destination == 'Cart4':
            # CartFrom
            if  self.object_place == 'Table31' or self.object_place == 'Table32'or self.object_place == 'Table33' or self.object_place == 'Table34'or self.object_place == 'Table41' or self.object_place == 'Table42'or self.object_place == 'Table43' or self.object_place == 'Table44': 
                self.pose_to_destination_x       = self.base_x -0.00 
                self.pose_to_destination_y       = 0.3
                self.pose_to_destination_theta   = 0
            else:     
                self.pose_to_destination_x       = self.base_x -0.00 
                self.pose_to_destination_y       = self.base_y+0.65
                self.pose_to_destination_theta   = 0
        

        elif self.destination == 'Table11' or self.destination == 'Table12' or self.destination == 'Table13' or self.destination == 'Table14' or self.destination == 'Table21' or self.destination == 'Table22' or self.destination == 'Table23' or self.destination == 'Table24' or self.destination == 'Table31' or self.destination == 'Table32'or self.destination == 'Table33' or self.destination == 'Table34' or self.destination == 'Table41' or self.destination == 'Table42'  or self.destination == 'Table43' or self.destination == 'Table44'or self.destination == 'Trash':
            if self.destination == 'Table11' or self.destination == 'Table12' or self.destination == 'Table13' or self.destination == 'Table14':
                self.base_x         =Table1.x
                self.base_y         =Table1.y
                self.base_theta     =Table1.theta
            elif self.destination == 'Table21' or self.destination == 'Table22' or self.destination == 'Table23' or self.destination == 'Table24':
                self.base_x         =Table2.x
                self.base_y         =Table2.y
                self.base_theta     =Table2.theta
            elif self.destination == 'Table31' or self.destination == 'Table32'or self.destination == 'Table33' or self.destination == 'Table34':
                self.base_x         =Table3.x
                self.base_y         =Table3.y
                self.base_theta     =Table3.theta
            elif self.destination == 'Table41' or self.destination == 'Table42' or self.destination == 'Table43' or self.destination == 'Table44':
                self.base_x         =Table4.x
                self.base_y         =Table4.y
                self.base_theta     =Table4.theta
            elif self.destination == 'Trash':
                self.base_x             =Trash.x
                self.base_y             =Trash.y
                self.base_theta         =Trash.theta
            self.pose_to_destination_x       = self.base_x -0.8*math.cos(self.base_theta) 
            self.pose_to_destination_y       = self.base_y-0.8*math.sin(self.base_theta) 
            self.pose_to_destination_theta   = self.base_theta



        if self.object_place == 'Wagon1'or self.object_place == 'Wagon2'or self.object_place == 'Wagon3'or self.object_place == 'Wagon4':
            pass
        else:
            self.pose_to_object=geometry_msgs.msg.Pose2D()
            self.pose_to_object.x=self.pose_to_object_x
            self.pose_to_object.y=self.pose_to_object_y
            self.pose_to_object.theta=self.pose_to_object_theta

        if self.destination == 'Wagon1'or self.destination == 'Wagon2'or self.destination == 'Wagon3'or self.destination == 'Wagon4':
            pass
        else:
            self.pose_to_destination=geometry_msgs.msg.Pose2D()
            self.pose_to_destination.x=self.pose_to_destination_x
            self.pose_to_destination.y=self.pose_to_destination_y
            self.pose_to_destination.theta=self.pose_to_destination_theta

        #//////////////////////// LOG 開始 //////////////////////////////////////
        """
        logMotion.log=False
        logMotion.IMU=False
        logMotion.LRF=False
        logMotion.Wrist=False
        logMotion.Joint=False
        logMotion.TF=False
        
        sO=object.object_place;
        sD=object.destination
        sMode='PickAndPlace';
        sUnder='_';
        sTo='to';
        """
        # logMotion.mode=sMode+sUnder+sO+sTo+sD;

        # log_client(logMotion.log,logMotion.IMU,logMotion.LRF,logMotion.Wrist,logMotion.Joint,logMotion.TF,logMotion.mode)
        """
        logpMotion.log=True;
        logpMotion.PCD=False;
       
        """
        #logpMotion.mode=sMode+sUnder+sO+sTo+sD;

        # log_p_client(logpMotion.log,logpMotion.PCD,logpMotion.mode)




        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performPickAndPlace()
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

        # log_client(logMotion.log,logMotion.IMU,logMotion.LRF,logMotion.Wrist,logMotion.Joint,logMotion.TF,logMotion.mode)
        

        logpMotion.log=False
        logpMotion.PCD=False
       
        
        sO=object.object_place
        sD=object.destination
        sMode='PickAndPlace'
       
        
        logpMotion.mode=sMode

        # log_p_client(logpMotion.log,logpMotion.PCD,logpMotion.mode)
        """
        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "モジュールを実行しました\n"
            return HsrPickAndPlaceResponse(success=True)
        else:
            print "モジュールを実行に失敗しました\n"
            return HsrPickAndPlaceResponse(success=False)



    #===========================================================================
    #   Place Object
    #===========================================================================
    def performPickAndPlace(self):

      
      

        # 物体のある位置の前に移動する
        if self.object_place== 'Wagon1'or self.object_place == 'Wagon2'or self.object_place == 'Wagon3'or self.object_place == 'Wagon4':
            pass

        else:
            nav3Motion.pose = self.pose_to_object

            nav3Motion.obstacle_avoidance       = True
            nav3Motion.first_rot_limit          = 1.0
            nav3Motion.velocity                 = 0.6

        
            nav3_client(nav3Motion.pose,nav3Motion.obstacle_avoidance,nav3Motion.first_rot_limit,nav3Motion.velocity ) 
   

        # 物体をとる
        pickupMotion=self.object_place
        
        pick_up_client(pickupMotion) 
 
    
        # 目的地の前に移動する
        if self.destination == 'Wagon1'or self.destination == 'Wagon2'or self.destination == 'Wagon3'or self.destination == 'Wagon4':
            pass

        else:
            nav3Motion.pose                   =self.pose_to_destination

            nav3Motion.obstacle_avoidance       = True
            nav3Motion.first_rot_limit          = 1.0
            nav3Motion.velocity                 = 0.6
        
            nav3_client(nav3Motion.pose,nav3Motion.obstacle_avoidance,nav3Motion.first_rot_limit,nav3Motion.velocity ) 
      
        # 目的地に置く
        placeMotion.place_id = self.destination
        placeMotion.object_name = self.object_name
        
        place_client(placeMotion.place_id, placeMotion.object_name) 
        
    
        return True


################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRPickAndPlace()
    hsr.launchServer()
