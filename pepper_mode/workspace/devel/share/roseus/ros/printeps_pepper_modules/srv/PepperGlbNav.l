;; Auto-generated. Do not edit!


(when (boundp 'printeps_pepper_modules::PepperGlbNav)
  (if (not (find-package "PRINTEPS_PEPPER_MODULES"))
    (make-package "PRINTEPS_PEPPER_MODULES"))
  (shadow 'PepperGlbNav (find-package "PRINTEPS_PEPPER_MODULES")))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAV")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAV"))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAVREQUEST")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAVREQUEST"))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAVRESPONSE")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERGLBNAVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass printeps_pepper_modules::PepperGlbNavRequest
  :super ros::object
  :slots (_pose ))

(defmethod printeps_pepper_modules::PepperGlbNavRequest
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

(defclass printeps_pepper_modules::PepperGlbNavResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_pepper_modules::PepperGlbNavResponse
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

(defclass printeps_pepper_modules::PepperGlbNav
  :super ros::object
  :slots ())

(setf (get printeps_pepper_modules::PepperGlbNav :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_pepper_modules::PepperGlbNav :datatype-) "printeps_pepper_modules/PepperGlbNav")
(setf (get printeps_pepper_modules::PepperGlbNav :request) printeps_pepper_modules::PepperGlbNavRequest)
(setf (get printeps_pepper_modules::PepperGlbNav :response) printeps_pepper_modules::PepperGlbNavResponse)

(defmethod printeps_pepper_modules::PepperGlbNavRequest
  (:response () (instance printeps_pepper_modules::PepperGlbNavResponse :init)))

(setf (get printeps_pepper_modules::PepperGlbNavRequest :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_pepper_modules::PepperGlbNavRequest :datatype-) "printeps_pepper_modules/PepperGlbNavRequest")
(setf (get printeps_pepper_modules::PepperGlbNavRequest :definition-)
      "
geometry_msgs/Pose2D  pose

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

(setf (get printeps_pepper_modules::PepperGlbNavResponse :md5sum-) "cfc42ebcb6ac1e961d822c446b9526a0")
(setf (get printeps_pepper_modules::PepperGlbNavResponse :datatype-) "printeps_pepper_modules/PepperGlbNavResponse")
(setf (get printeps_pepper_modules::PepperGlbNavResponse :definition-)
      "
geometry_msgs/Pose2D  pose

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



(provide :printeps_pepper_modules/PepperGlbNav "cfc42ebcb6ac1e961d822c446b9526a0")


