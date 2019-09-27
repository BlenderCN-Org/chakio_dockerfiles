#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from geometry_msgs.msg  import Pose2D
from printeps_hsr_modules.srv  import Float32ToPose2D
from printeps_hsr_modules.srv  import Float32ToPose2DResponse

def handleService(req):
    rospy.loginfo('called!')
    pose = Pose2D()
    pose.x      = req.x
    pose.y      = req.y
    pose.theta  = req.theta
    return Float32ToPose2DResponse(pose2d = pose)

def float32ToPose2dServer():
    rospy.init_node('printeps_float32_to_pose2d_server')
    s = rospy.Service('printeps/float32_to_pose2d', Float32ToPose2D, handleService)
    print "Ready to serve."
    rospy.spin()

if __name__ == "__main__":
    float32ToPose2dServer()
