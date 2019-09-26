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
from printeps_hsr_modules.msg   import HsrObstacle
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
from printeps_hsr_modules.srv   import HsrHandoverObject
from printeps_hsr_modules.srv   import HsrHandoverObjectResponse
from printeps_hsr_modules.msg   import HsrObstacleArray
from printeps_hsr_modules.msg   import HsrObstacle
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.srv   import HsrGlbNav
from printeps_hsr_modules.srv   import HsrGlbNavResponse
from printeps_hsr_modules.srv   import HsrMMNav
from printeps_hsr_modules.srv   import HsrMMNavResponse
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



# ServiceClient ------------------------------------------------------------

    # Navigation Server ----------------------------------------------------
glbNav_client   = rospy.ServiceProxy('hsr_global_navigation', HsrGlbNav)

    # Navigation Server ----------------------------------------------------
mmNav_client    = rospy.ServiceProxy('hsr_multimodal_navigation', HsrMMNav)

    # PickUpObject Server --------------------------------------------------------
pick_up_client  = rospy.ServiceProxy('hsr_pick_up_object', HsrPickUpObject)

    # Place Server --------------------------------------------------------
place_client    = rospy.ServiceProxy('hsr_place_object', HsrPlaceObject)

    # Handover Server --------------------------------------------------------
handover_client = rospy.ServiceProxy('hsr_handover_object', HsrHandoverObject)

    # Log Server ----------------------------------------------------
# log_client  = rospy.ServiceProxy('hsr_log', HsrLog)

    # LogP Server ----------------------------------------------------
# log_p_client  = rospy.ServiceProxy('hsr_log_p', HsrLogP)

tflistener      = tf.TransformListener()

glbNavMotion    =    HsrGlbNav()

pickupMotion    =    HsrPickUpObject()
placeMotion     =    HsrPlaceObject()
handoverMotion  =    HsrHandoverObject()

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
        # subscriber setting--------------------------------------------------------
        rospy.Subscriber("hsr_obstacles",HsrObstacleArray, self.obstacle_cb)
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
    #   Obstacle Callback
    #===========================================================================
    def obstacle_cb(self,data):
        self.Table=[]
        for table in data.obstacles:
            self.Table.append(table.table.pose)

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

        if self.object_place =='Hand':
            self.pose_to_object_x            = 0  
            self.pose_to_object_y            = 0
            self.pose_to_object_theta        = 0

        if  self.object_place == 'Pet':
            # PetFrom
            self.base_x                         = self.Table[6].x
            self.base_y                         = self.Table[6].y
            self.base_theta                     = self.Table[6].theta
            self.pose_to_object_x               = self.base_x  
            self.pose_to_object_y               = self.base_y-1.40
            self.pose_to_object_theta           = 1.57
        
        elif self.object_place == "Wagon1" or self.object_place == "Wagon2" or self.object_place == "Wagon3" or self.object_place == "Wagon4":
            try:
                (transH,rotH) = tflistener.lookupTransform('/map', '/hsr_wagon_tf', rospy.Time(0))
                eH = tf.transformations.euler_from_quaternion(rotH)
            except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                return False;   
            
            distanceFromWagon=0.7
            self.pose_to_object_x      = transH[0]+distanceFromWagon*math.sin(eH[2])
            self.pose_to_object_y      = transH[1]-distanceFromWagon*math.cos(eH[2])
            self.pose_to_object_theta  = eH[2]+math.pi/2

        elif self.object_place == 'Table1': 
            self.pose_to_object_x               = self.Table[0].x
            self.pose_to_object_y               = self.Table[0].y
            self.pose_to_object_theta           = self.Table[0].theta
        elif self.object_place == 'Table2': 
            self.pose_to_object_x               = self.Table[1].x
            self.pose_to_object_y               = self.Table[1].y
            self.pose_to_object_theta           = self.Table[1].theta
        elif self.object_place == 'Table3': 
            self.pose_to_object_x               = self.Table[2].x
            self.pose_to_object_y               = self.Table[2].y
            self.pose_to_object_theta           = self.Table[2].theta
        elif self.object_place == 'Table4':
            self.pose_to_object_x               = self.Table[3].x
            self.pose_to_object_y               = self.Table[3].y
            self.pose_to_object_theta           = self.Table[3].theta
        elif self.object_place == 'Table5':
            self.pose_to_object_x               = self.Table[4].x
            self.pose_to_objectn_y              = self.Table[4].y
            self.pose_to_object_theta           = self.Table[4].theta
        elif self.object_place == 'Table6':
            self.pose_to_object_x               = self.Table[5].x
            self.pose_to_object_y               = self.Table[5].y
            self.pose_to_object_theta           = self.Table[5].theta
        
        if self.destination == 'Table1': 
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

        elif self.destination =='Hand':
            self.pose_to_destination_x            = 0  
            self.pose_to_destination_y            = 0
            self.pose_to_destination_theta        = 0

        elif self.destination=='Trash':
            self.base_x                         = self.Table[7].x
            self.base_y                         = self.Table[7].y
            self.base_theta                     = self.Table[7].theta
            self.pose_to_destination_x          = self.base.x
            self.pose_to_destination_y          = self.base.y
            self.pose_to_destination_theta      = self.base.theta


        

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
        if self.object_place != 'Hand' :
            
            # 物体のある位置の前に移動する
            self.pose_to_object=geometry_msgs.msg.Pose2D()
            self.pose_to_object.x=self.pose_to_object_x
            self.pose_to_object.y=self.pose_to_object_y
            self.pose_to_object.theta=self.pose_to_object_theta
            glbNavMotion= self.pose_to_object
            glbNav_client(glbNavMotion) 

            # 物体をとる
            pickupMotion=self.object_place
            pick_up_client(pickupMotion) 
        

        if self.destination == 'Hand':
            return True

        else:
            # 目的地に移動する
            #物体の初期位置がワゴンの場合や物体の行き先がワゴンの場合はglb

            if self.object_place == 'Wagon1' or self.object_place == 'Wagon2' or self.object_place == 'Wagon3' or self.object_place == 'Wagon4' or self.destination == 'Wagon1' or self.destination == 'Wagon2' or self.destination == 'Wagon3' or self.destination == 'Wagon4':
                #globalNav
                print "globalNav"
                glbNavMotion   = self.pose_to_destination
                glbNav_client(glbNavMotion)
                
  
        
            # 目的地に置く
            if self.destination == "Table1" or self.destination == "Table2" or self.destination == "Table3" or self.destination == "Table4" or self.destination == "Table5" or self.destination == "Table6":
                handoverMotion.place_id = self.destination
                handoverMotion.object_name = self.object_name

                handover_client(handoverMotion.place_id,handoverMotion.object_name)

            else:
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
