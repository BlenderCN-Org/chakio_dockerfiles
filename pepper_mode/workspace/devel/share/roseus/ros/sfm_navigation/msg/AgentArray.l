;; Auto-generated. Do not edit!


(when (boundp 'sfm_navigation::AgentArray)
  (if (not (find-package "SFM_NAVIGATION"))
    (make-package "SFM_NAVIGATION"))
  (shadow 'AgentArray (find-package "SFM_NAVIGATION")))
(unless (find-package "SFM_NAVIGATION::AGENTARRAY")
  (make-package "SFM_NAVIGATION::AGENTARRAY"))

(in-package "ROS")
;;//! \htmlinclude AgentArray.msg.html


(defclass sfm_navigation::AgentArray
  :super ros::object
  :slots (_agents ))

(defmethod sfm_navigation::AgentArray
  (:init
   (&key
    ((:agents __agents) (let (r) (dotimes (i 0) (push (instance sfm_navigation::Agent :init) r)) r))
    )
   (send-super :init)
   (setq _agents __agents)
   self)
  (:agents
   (&rest __agents)
   (if (keywordp (car __agents))
       (send* _agents __agents)
     (progn
       (if __agents (setq _agents (car __agents)))
       _agents)))
  (:serialization-length
   ()
   (+
    ;; sfm_navigation/Agent[] _agents
    (apply #'+ (send-all _agents :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sfm_navigation/Agent[] _agents
     (write-long (length _agents) s)
     (dolist (elem _agents)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sfm_navigation/Agent[] _agents
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _agents (let (r) (dotimes (i n) (push (instance sfm_navigation::Agent :init) r)) r))
     (dolist (elem- _agents)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get sfm_navigation::AgentArray :md5sum-) "a42d8b787a4b74273a3d435730aaf001")
(setf (get sfm_navigation::AgentArray :datatype-) "sfm_navigation/AgentArray")
(setf (get sfm_navigation::AgentArray :definition-)
      "sfm_navigation/Agent[] agents
================================================================================
MSG: sfm_navigation/Agent
geometry_msgs/Pose2D  pose
geometry_msgs/Twist twist

================================================================================
MSG: geometry_msgs/Pose2D
# Deprecated
# Please use the full 3D pose.

# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.

# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.


# This expresses a position and orientation on a 2D manifold.

float64 x
float64 y
float64 theta

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :sfm_navigation/AgentArray "a42d8b787a4b74273a3d435730aaf001")


