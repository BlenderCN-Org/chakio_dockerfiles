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
from std_msgs.msg import String
from std_msgs.msg import Bool
from sensor_msgs.msg    import LaserScan
from geometry_msgs.msg  import PoseStamped, Point, Quaternion
from geometry_msgs.msg  import PoseWithCovarianceStamped
from hsrb_interface     import geometry
from printeps_hsr_modules.srv   import HsrHandoverObject
from printeps_hsr_modules.srv   import HsrHandoverObjectResponse
from printeps_hsr_modules.msg   import HsrObstacleArray
from printeps_hsr_modules.msg   import HsrObstacle
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.msg   import HsrTableset
from printeps_hsr_modules.msg   import HsrOpenpose
from printeps_hsr_modules.msg   import HsrPerson
from geometry_msgs.msg  import WrenchStamped
from sensor_msgs.msg  import JointState

import controller_manager_msgs.srv
import trajectory_msgs.msg

################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')

TF_Checker=True;

# 把持のためのパラメータ ----------------------------------------------------------
GRASP_TORQUE                = -0.01         # 把持トルク[Nm]
GRASP_TORQUE_MAX            = -0.02         # 把持トルク[Nm]

(PET,MENU,CART, TABLE1,TABLE2,TABLE3,TABLE4,TABLE5,TABLE6,HANDOVER,TRASH,WAGON)    = range(0, 12)   # ペットボトル、メニュー、 カート、テーブル
(no1,no2,no3,no4,no5,no6,handover,trash)  = range(0, 8)   # ペット ボトルの番号fh
(PICKUP, PLACE,HOLD,RELEASE)        = range(0, 4)   # PickUp, Place
(BEFORE, CONTACT, AFTER,)   = range(0, 3)   # 事前姿勢、接触、事後姿勢


TF_OBJECT   = ['ar_marker/15','ar_marker/14','ar_marker/14', 'ar_marker/8','ar_marker/9','ar_marker/10','ar_marker/11','ar_marker/12','ar_marker/13','ar_marker/11','ar_marker/14','hsr_wagon_tf']   # つかむ物体のtf: ペットボトル、メニュー(棚)# 物体を置く場所のtf
TF_HAND     = 'hand_palm_link'                  # グリッパのtf

TARGET_POSE = [[[[geometry.pose() for i in range(3)] for j in range(4)]for k in range(8)] for l in range(10)]
#TARGET_POSE[PET][PICKUP][BEFORE]    = geometry.pose(y=-0.05, z=-0.12, ek=-math.pi/2.0)   # 物体の手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][CONTACT]   = geometry.pose(z=-0.01, ek=-math.pi/2.0)           # 物体の手前0.02[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PICKUP][AFTER]     = geometry.pose(x=0.12, z=-0.2)                     # 物体を把持した後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢
#TARGET_POSE[PET][PLACE][BEFORE]     = geometry.pose(y=-0.15, z=-0.18, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][CONTACT]    = geometry.pose(y=-0.11, z=0.1, ek=-math.pi/2.0)     # テーブルの位置,z軸回に-90[deg]回転させた姿勢
#TARGET_POSE[PET][PLACE][AFTER]      = geometry.pose(x=0.08, z=-0.25)                    # 物体を置いた後ハンドを0.08[m]上に移動させ、0.2[m]後退した姿勢

PetHeight=0.05

# 置くのためのパラメータ(PLACE　HANDOVER) ---------------------------------------------------------
TARGET_POSE[HANDOVER][no1][PLACE][BEFORE]     = geometry.pose(x=-0.1,y=-0.05-PetHeight-0.1, z=-0.1, ei=math.pi/4,ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[HANDOVER][no2][PLACE][BEFORE]     = geometry.pose(x=-0.1,y=-0.05-PetHeight-0.1, z=0.35,ei=math.pi/6, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[HANDOVER][no3][PLACE][BEFORE]     = geometry.pose(x=0.1,y=-0.05-PetHeight-0.1, z=0.35,ei=-math.pi/6, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[HANDOVER][no4][PLACE][BEFORE]     = geometry.pose(x=0.1,y=-0.05-PetHeight-0.1, z=-0.1,ei=-math.pi/4, ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢
TARGET_POSE[HANDOVER][no5][PLACE][BEFORE]     = geometry.pose(x=-0.0,y=-0.05-PetHeight-0.1, z=0.1,ek=-math.pi/2.0)   # テーブルの手前0.12[m],z軸回に-90[deg]回転させた姿勢

TARGET_POSE[HANDOVER][no1][PLACE][AFTER]      = geometry.pose(x=-0.1, z=-0.1)
TARGET_POSE[HANDOVER][no2][PLACE][AFTER]      = geometry.pose(x=-0.1, z=-0.4)
TARGET_POSE[HANDOVER][no3][PLACE][AFTER]      = geometry.pose(x=-0.1, z=-0.4)
TARGET_POSE[HANDOVER][no4][PLACE][AFTER]      = geometry.pose(x=-0.1, z=-0.1)
TARGET_POSE[HANDOVER][no5][PLACE][AFTER]      = geometry.pose(x=-0.1, z=-0.15)

publog          = rospy.Publisher("handover",String,queue_size=30)
pubopenposestart= rospy.Publisher("/hsr_openpose_start",String,queue_size=10)
pubtrj          = rospy.Publisher('/hsrb/arm_trajectory_controller/command',
                      trajectory_msgs.msg.JointTrajectory, queue_size=10)
tfListener      = tf.TransformListener()
tfBroadcaster   = tf.TransformBroadcaster()

class PeopleAroundTable:
    def __init__(self,x,y,reliability,isHandUp):
        self.x          = x
        self.y          = y
        self.reliability = reliability
        self.isHandUp   = isHandUp
        self.directNum  = 0

################################################################################
#                               HSR Place Object                               #
################################################################################
class HSRHandoverObject:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Handover Object ================="
        rospy.Subscriber("/hsrb/wrist_wrench/raw", WrenchStamped, self.hand_cb)
        rospy.Subscriber("/hsrb/joint_states", JointState, self.lift_cb)
        rospy.Subscriber("hsr_obstacles",HsrObstacleArray, self.obstacle_cb)
        rospy.Subscriber("hsr_openpose_status",Bool, self.openpose_status_cb)
        rospy.Subscriber("hsr_observed_people",HsrOpenpose, self.openpose_cb)
        rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.amcl_cb)
        rospy.Timer(rospy.Duration(0.1), self.timer_cb)
        self.setTF          = False
        self.getObstacle    = False
        self.getOpenpose    = False
        self.startTask      = False
        
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
        for n in range(0,len(data.name)):
            #print data.name[n]
            if data.name[n]=='arm_lift_joint':
                self.liftDigree=data.position[n]
                #print data.name[n]
            elif data.name[n]=='arm_flex_joint':
                self.flexDigree=data.position[n]
                #print data.name[n]
            elif data.name[n]=='arm_roll_joint':
                self.rollDigree=data.position[n]
                #print data.name[n]
            elif data.name[n]=='wrist_flex_joint':
                self.wflexDigree=data.position[n]
                #print data.name[n]
            elif data.name[n]=='wrist_roll_joint':
                self.wrollDigree=data.position[n]
                #print data.name[n]
            elif data.name[n]=='hand_motor_joint':
                self.gripperDigree=data.position[n]
                # print self.gripperDigree
    #===========================================================================
    #   timer callback
    #===========================================================================
    def timer_cb(self,event):
        if self.setTF:
            tfBroadcaster.sendTransform(self.targetTrans,self.targetRot,rospy.Time.now(),'hsr_target_TF','odom')

    #===========================================================================
    #   obstacle callback
    #===========================================================================
    def obstacle_cb(self,data):
        self.obstacle       = data
        self.getObstacle    = True
    #===========================================================================
    #   openpose callback
    #===========================================================================
    def openpose_cb(self,data):
        self.openpose        = data
        if self.getObstacle and self.startTask:
            self.checkPeople()

    #===========================================================================
    #   openpose status_callback
    #===========================================================================
    def openpose_status_cb(self,data):
        self.openpose_status        = data.data
        print self.openpose_status

    #===========================================================================
    #   Get Current Pose
    #===========================================================================
    def amcl_cb(self, amcl):

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
    #===========================================================================
    #   get chair
    #===========================================================================
    def getChair(self):
        #各椅子とテーブルの位置の取得
        self.people=[]
        for chair in self.obstacle.obstacles[self.tableIndex].chairs:
            self.people.append(PeopleAroundTable(chair.pose.x,chair.pose.y,0,False))

    #===========================================================================
    #   check people
    #===========================================================================
    def checkPeople(self):
        #各椅子から近い人で、各椅子の信頼度と手を上げているかの更新
        #更新フラグ　複数人ゲート内にいた場合は椅子に近い方を信じる
        gate =0.7
        minimumDistance=[]
        
        for i in range(len(self.people)):
            minimumDistance.append(gate)
        for person in self.openpose.people:
            #print "person:x :"+str(person.pose.x)+" y :"+str(person.pose.y)
            for chairNum,chair in enumerate(self.people):
                #print "chair:x :"+str(chair.x)+" y :"+str(chair.y)
                distance=math.sqrt(math.pow(person.pose.x-chair.x,2)+math.pow(person.pose.y-chair.y,2))
                if distance<gate and distance<minimumDistance[chairNum]:
                    minimumDistance[chairNum]=distance
                    if self.people[chairNum].reliability<person.confidence:
                        self.people[chairNum].reliability   = person.confidence
                        self.people[chairNum].isHandUp      = person.isHandUp
        """
        dummyIndex=2
        self.people[dummyIndex].isHandUp = True
        print "x:"+str(self.people[dummyIndex].x)+"  y:"+str(self.people[dummyIndex].y)
        """
    #===========================================================================
    #   check handover direction
    #===========================================================================
    def checkHandoverDirection(self):

        #手を上げている人が1人の場合に、どこに渡すべきかを決定する
        #イレギュラーの場合 5で返す
        #左手前の場合   :1
        #左奥の場合     :2
        #右奥の場合     :3
        #右手前の場合   :4

        #認識している人の方向を確認と手を上げている人が一人か確認
        tablePos            = self.obstacle.obstacles[self.tableIndex].table.pose
        robotDeg            = math.atan2(self.current_pose.y-tablePos.y,self.current_pose.x-tablePos.x)/math.pi*180
        HandUpNum           = 0
        HandUpPersonIndex   = 0
        print "---------------------------------"
        for personNum in range(len(self.people)):
            print "personIndex:"+str(personNum)+"   :"+str(self.people[personNum].isHandUp)
            personDeg       = math.atan2(self.people[personNum].y-tablePos.y,self.people[personNum].x-tablePos.x)/math.pi*180
            differenceDeg   = personDeg-robotDeg
            if differenceDeg > 360:
                differenceDeg -= 360
            elif  differenceDeg < 0:
                differenceDeg += 360
            
            #角度に基づき人の決定
            if differenceDeg    > 270:
                directNum   = no1
            elif differenceDeg  > 180:
                directNum   = no2
            elif differenceDeg  > 90:
                directNum   = no3
            else:
                directNum   = no4
            self.people[personNum].directNum = directNum
            print "directNum"+str(directNum)
            print "Reliablity;"+str(self.people[personNum].reliability)
            #手を上げている人の確認
            if self.people[personNum].isHandUp:
                HandUpNum = HandUpNum+1
                HandUpPersonIndex = personNum
            print
        print "---------------------------------"
        #directNumが2,3の場合、手前側1,4に人がいると危険であるため、ハンドオーバーするかどうかを判定する
        #手を上げている人の方向に対して、存在するとき変な人の方向を決定
        
        
        
        directNum = no5
        dangerous = False
        if HandUpNum ==1:
            directNum = self.people[HandUpPersonIndex].directNum
            if directNum == no2:
                dangerousNum = no1
            elif directNum == no3:
                dangerousNum = no4
            else: 
                #危険な方向がない場合はno5で回避
                dangerousNum =no5
            for personNum in range(len(self.people)):
                if self.people[personNum].reliability>0.1 and self.people[personNum].directNum==dangerousNum:
                    dangerous = True

            print "---------------------------------"
            print "personNum:"+str(HandUpPersonIndex)
            print "directNum;"+str(self.people[HandUpPersonIndex].directNum)
            print "dangerousNum:"+str(dangerousNum)
            print "---------------------------------"
        return directNum,dangerous

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
            while count<800:
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
    #   downing lift
    #===========================================================================
    """
    def downingLift(self,waight,height):
        print "waitingTouch"
        self.difference_waight=0
        self.targetLift=0
        self.count=0
        while self.difference_waight<waight:
            
            
            self.movedigree=(height-self.count*0.5)*0.01
            self.count+=1
            if self.movedigree<=0.005:
                self.movedigree=0.01
         
            self.targetLift=self.liftDigree-self.movedigree
           
            if self.targetLift<0:
                self.targetLift=0
            print self.targetLift
            whole_body.move_to_joint_positions({'arm_lift_joint': self.targetLift})


            self.difference_x=self._force_data_x-self.calib_x
            self.difference_y=self._force_data_y-self.calib_y
            self.difference_z=self._force_data_z-self.calib_z
            self.difference_all=math.sqrt(self.difference_x*self.difference_x+self.difference_y*self.difference_y+self.difference_z*self.difference_z)
            self.difference_waight=round(self.difference_all / 9.81 * 1000, 1)
        print "Touch!!"

    """

    def downingLift(self,waight):
        print "waitingTouch"
        self.difference_waight=0
        self.targetLift=0
        while self.difference_waight<waight:
            self.movedigree=0.005
     
            self.targetLift=self.liftDigree-self.movedigree
            if self.targetLift<0:
                self.targetLift=0
            print self.targetLift

            rospy.wait_for_service('/hsrb/controller_manager/list_controllers')
            list_controllers = (rospy.ServiceProxy('/hsrb/controller_manager/list_controllers',controller_manager_msgs.srv.ListControllers))
            running = False
            while running is False:
                for c in list_controllers().controller:
                    if c.name == 'arm_trajectory_controller' and c.state == 'running':
                        running = True
           
            # fill ROS message
            traj = trajectory_msgs.msg.JointTrajectory()
            traj.joint_names = ["arm_lift_joint", "arm_flex_joint",
                                "arm_roll_joint", "wrist_flex_joint", "wrist_roll_joint"]
            p = trajectory_msgs.msg.JointTrajectoryPoint()
            p.positions = [self.targetLift, self.flexDigree, self.rollDigree, self.wflexDigree, self.wrollDigree]
            p.velocities = [0, 0, 0, 0, -0.00]
            p.time_from_start = rospy.Time(0.1)
            traj.points = [p]

            # publish ROS message
            pubtrj.publish(traj)


            self.difference_x=self._force_data_x-self.calib_x
            self.difference_y=self._force_data_y-self.calib_y
            self.difference_z=self._force_data_z-self.calib_z
            self.difference_all=math.sqrt(self.difference_x*self.difference_x+self.difference_y*self.difference_y+self.difference_z*self.difference_z)
            self.difference_waight=round(self.difference_all / 9.81 * 1000, 1)
            print self.difference_waight
        print "Touch!!"

    #===========================================================================
    #   waiting touch
    #===========================================================================
    def waitingTouch(self,waight,waittime=None):
        if waittime==None:
            
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
                return True
            except KeyboardInterrupt:
                print "aaaa"
                pass
        else:
            print "waitingTouch"
            self.difference_waight=0
            starttime=rospy.get_time()
            try:

                while self.difference_waight<waight:
                    self.difference_x=self._force_data_x-self.calib_x
                    self.difference_y=self._force_data_y-self.calib_y
                    self.difference_z=self._force_data_z-self.calib_z
                    self.difference_all=math.sqrt(self.difference_x*self.difference_x+self.difference_y*self.difference_y+self.difference_z*self.difference_z)
                    self.difference_waight=round(self.difference_all / 9.81 * 1000, 1)
                    if rospy.get_time()-starttime>waittime:
                        return False
                print "Touch!!"
                return True
            except KeyboardInterrupt:
                print "aaaa"
                pass       # 目的地に移動する
            if self.object_place!="Cart1" and self.object_place!="Cart2" and self.object_place!="Cart3" and self.object_place!="Cart4":
                #multimodalNav
                mmNavMotion.pose    = self.pose_to_destination
                mmNav_client(mmNavMotion) 
            else:
                #globalNav
                glbNavMotion.pose   = self.pose_to_destination
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
    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Handover Server --------------------------------------------------------
        handover_server = rospy.Service('hsr_handover_object', HsrHandoverObject, self.handoverObjectHandler)
        

        rospy.loginfo("Ready to serve command.")
        rospy.spin()

    

    #===========================================================================
    #   Handover Object Handler
    #===========================================================================
    def handoverObjectHandler(self, object):
        
        print "----------- Handover Object --------------"
        self.setTF=False
        self.object_name = object.object_name
        self.startTask = True
        
        #///////////////////// Service からパラメータを設定 /////////////////////////
        # 置く物体ID -------------------------------------------------------------
        
        #Table1
        if object.place_id  == 'Table1':
            self.place_id   = TABLE1
            self.tableIndex = 0
            print "Target Place: TABLE1"
            print TF_OBJECT[self.place_id]
        #Table2
        elif object.place_id    == 'Table2':
            self.place_id       = TABLE2
            self.tableIndex     = 1
            print "Target Place: TABLE2"
        #Table3
        elif object.place_id    == 'Table3':
            self.place_id       = TABLE3
            self.tableIndex     = 2
            print "Target Place: TABLE3"
        #Table4
        elif object.place_id    == 'Table4':
            self.place_id       = TABLE4
            self.tableIndex     = 3
            print "Target Place: TABLE4"
        #Table5
        elif object.place_id    == 'Table5':
            self.place_id       = TABLE5
            self.tableIndex     = 4
            print "Target Place: TABLE5"
        #Table6
        elif object.place_id    == 'Table6':
            self.place_id       = TABLE6
            self.tableIndex     = 5
            print "Target Place: TABLE6"
        else:
            print object.place_id + " is an illegal object id"
            return HsrHandoverObjectResponse(success=False)

        self.getChair()
        #//////////////////////// Pick And Placeを実行 //////////////////////////
        the_success = self.performHandoverObject()
        self.startTask = False
        

        #//////////////////////////// 実行結果を送信 /////////////////////////////
        if the_success == True:
            print "物体を置きました\n"
            return HsrHandoverObjectResponse(success=True)
        else:
            print "物体を置くことに失敗しました\n"
            return HsrHandoverObjectResponse(success=False)

    #===========================================================================
    #   Handover Object
    #===========================================================================
    def performHandoverObject(self):
        #self.HandUPCheckerのリセット
        self.HandUPChecker=False

        #一旦TFが見えているかチェック
        checkTF= False

        try:
            (self.targetTrans,self.targetRot) = tfListener.lookupTransform('odom',TF_OBJECT[self.place_id],  rospy.Time(0))
            distance = math.sqrt( math.pow(self.targetTrans[0],2)+math.pow(self.targetTrans[1],2) )
            if distance>1.0:
                checkTF=True
                self.setTF = True

        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            pass
        
        #見えなかったら首を振る
        if not checkTF:
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
            (self.targetTrans,self.targetRot) = tfListener.lookupTransform('odom',TF_OBJECT[self.place_id],  rospy.Time(0))
            distance = math.sqrt( math.pow(self.targetTrans[0],2)+math.pow(self.targetTrans[1],2) )
            if distance>1.0:
                checkTF=True
                self.setTF = True

        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            pass

        if not checkTF:
            #首を降っても見えなかった場合、諦める 
            whole_body.move_to_neutral()
            self.calibration()
            tts.say('ものを置けませんでした')
            tts.say('だれか助けてください')
            self.waitingTouch(200)
            gripper.command(1.2)
            tts.say('ありがとうございます')
            whole_body.move_to_go()
            print '物体を置きました'
            publog.publish("end,end")
            return True


        #手渡し開始
        openposeCommand="start"
        pubopenposestart.publish(openposeCommand)
        self.openpose_status=False
        rospy.sleep(0.5)
        dangerous = False

        if self.openpose_status:
        
            for i in range(2):
                self.getChair()
                #これを注文したのは誰ですか？と問いかける
                talkingWords= "こちらの"+self.object_name + "を注文された人は,"
                tts.say(talkingWords)
                rospy.sleep(2)
                talkingWords= "まうえに、まっすぐ手を上げてください"
                tts.say(talkingWords)
                rospy.sleep(4)
                #[self.no,dangerous]=self.checkHandoverDirection()
                #if self.no != no5:
                #    break
                
                #手を上げている人を探す
                whole_body.move_to_joint_positions({'head_pan_joint': 0.6})
                rospy.sleep(1) 
                whole_body.move_to_joint_positions({'head_pan_joint': -0.6})
                rospy.sleep(1)
                self.no,dangerous=self.checkHandoverDirection()
                if self.no != no5:
                    break    
                whole_body.move_to_joint_positions({'head_pan_joint': 0.0})
            print "---------------------------------"
            print "no"+str(self.no)
            print "dangerous:"+str(dangerous)
            print "---------------------------------"
            openposeCommand="end"
            pubopenposestart.publish(openposeCommand)
            if self.no == no5:
                talkingWords= "判別できませんでした"
            else:
                talkingWords= "かしこまりました"
            tts.say(talkingWords) 
            whole_body.move_to_joint_positions({'head_pan_joint': 0.0})
        else:
            self.no = no5

        if dangerous:
            if self.no == no2:
                self.no = no1
            else:
                self.no = no4
            whole_body.linear_weight=(5)
            whole_body.move_end_effector_pose(TARGET_POSE[HANDOVER][self.no][PLACE][BEFORE], 'hsr_target_TF')
            self.calibration()
            tts.say('奥のかたに回していただけますか' )
            print '奥のかたに回していただけますか' 
        else:
            if self.no == no2 or self.no == no3:
                whole_body.linear_weight=(20)
            else:
                whole_body.linear_weight=(5)
            whole_body.move_end_effector_pose(TARGET_POSE[HANDOVER][self.no][PLACE][BEFORE], 'hsr_target_TF')
            self.calibration()
            tts.say('どうぞ、お受け取りください' )
            print 'どうぞ、お受け取りください' 

        if self.waitingTouch(250):
            tts.say('恐れいります')
        else:
            tts.say('机に置きます')
            self.downingLift(250)
            
        gripper.command(1.2)
        print '物体を置きました'   

        
            #/////////////////////////// 移動姿勢に移行 //////////////////////////////
            
        try:
            whole_body.linear_weight=(4)
            whole_body.move_end_effector_pose(TARGET_POSE[HANDOVER][self.no][PLACE][AFTER], TF_HAND)
            publog.publish("end,end")
            whole_body.move_to_go()
            print '移動姿勢をとりました'

            return True

        except:
            tts.say('移動姿勢をとれませんでした')
            print '移動姿勢をとれませんでした'
            try:
                whole_body.move_to_go()
            except:
                tts.say('移動姿勢をとれませんでした')
                print '移動姿勢をとれませんでした'
            publog.publish("end,end")

            return False
    
################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRHandoverObject()
    hsr.launchServer()
