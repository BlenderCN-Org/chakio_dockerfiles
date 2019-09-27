;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrNav)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrNav (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAV")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAV"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAVREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAVREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAVRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass printeps_hsr_modules::HsrNavRequest
  :super ros::object
  :slots (_pose ))

(defmethod printeps_hsr_modules::HsrNavRequest
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose2D :init))
    )
   (send-super :init)
   (setq _pose __pose)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrNavResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrNavResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrNav
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrNav :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_hsr_modules::HsrNav :datatype-) "printeps_hsr_modules/HsrNav")
(setf (get printeps_hsr_modules::HsrNav :request) printeps_hsr_modules::HsrNavRequest)
(setf (get printeps_hsr_modules::HsrNav :response) printeps_hsr_modules::HsrNavResponse)

(defmethod printeps_hsr_modules::HsrNavRequest
  (:response () (instance printeps_hsr_modules::HsrNavResponse :init)))

(setf (get printeps_hsr_modules::HsrNavRequest :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_hsr_modules::HsrNavRequest :datatype-) "printeps_hsr_modules/HsrNavRequest")
(setf (get printeps_hsr_modules::HsrNavRequest :definition-)
      "
geometry_msgs/Pose2D pose

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
---
bool success

")

(setf (get printeps_hsr_modules::HsrNavResponse :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_hsr_modules::HsrNavResponse :datatype-) "printeps_hsr_modules/HsrNavResponse")
(setf (get printeps_hsr_modules::HsrNavResponse :definition-)
      "
geometry_msgs/Pose2D pose

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
---
bool success

")



(provide :printeps_hsr_modules/HsrNav "cfc42ebcb6ac1e961d822c446b9526a0")


