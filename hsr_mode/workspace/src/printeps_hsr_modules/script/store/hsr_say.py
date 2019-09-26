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
###                             hsr_say.py                                ###
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
from printeps_hsr_modules.srv  import HsrSay
from printeps_hsr_modules.srv  import HsrSayResponse


################################################################################
#                             Grobal Definition                                #
################################################################################
# ロボット機能の初期化 ----------------------------------------------------------
robot       = hsrb_interface.Robot()
omni_base   = robot.get('omni_base')
whole_body  = robot.get('whole_body')
gripper     = robot.get('gripper')
tts         = robot.get('default_tts')



################################################################################
#                                   HSR Say                                    #
################################################################################
class HSRSay:

    #===========================================================================
    #   Constructor
    #===========================================================================
    def __init__(self):
        print "\n================ HSR Say ================="

        # Initialize node ------------------------------------------------------
        #rospy.init_node("hsr_say")



    #===========================================================================
    #   Launch Server
    #===========================================================================
    def launchServer(self):

        # Say Server -----------------------------------------------------------
        tts_server = rospy.Service('hsr_say', HsrSay, self.ttsHandler)

        rospy.loginfo("Ready to serve command.")
        rospy.spin()



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




################################################################################
#                               Main Function                                  #
################################################################################
if __name__ == '__main__':

    hsr   = HSRSay()
    hsr.launchServer()
