;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrNav2)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrNav2 (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAV2")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAV2"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAV2REQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAV2REQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRNAV2RESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRNAV2RESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass printeps_hsr_modules::HsrNav2Request
  :super ros::object
  :slots (_pose _obstacle_avoidance _first_rot ))

(defmethod printeps_hsr_modules::HsrNav2Request
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose2D :init))
    ((:obstacle_avoidance __obstacle_avoidance) nil)
    ((:first_rot __first_rot) nil)
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _obstacle_avoidance __obstacle_avoidance)
   (setq _first_rot __first_rot)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:obstacle_avoidance
   (&optional __obstacle_avoidance)
   (if __obstacle_avoidance (setq _obstacle_avoidance __obstacle_avoidance)) _obstacle_avoidance)
  (:first_rot
   (&optional __first_rot)
   (if __first_rot (setq _first_rot __first_rot)) _first_rot)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose
    (send _pose :serialization-length)
    ;; bool _obstacle_avoidance
    1
    ;; bool _first_rot
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose
       (send _pose :serialize s)
     ;; bool _obstacle_avoidance
       (if _obstacle_avoidance (write-byte -1 s) (write-byte 0 s))
     ;; bool _first_rot
       (if _first_rot (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; bool _obstacle_avoidance
     (setq _obstacle_avoidance (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _first_rot
     (setq _first_rot (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrNav2Response
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrNav2Response
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

(defclass printeps_hsr_modules::HsrNav2
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrNav2 :md5sum-) "659f5d58ec18e8cceedaf86bc551955b")
(setf (get printeps_hsr_modules::HsrNav2 :datatype-) "printeps_hsr_modules/HsrNav2")
(setf (get printeps_hsr_modules::HsrNav2 :request) printeps_hsr_modules::HsrNav2Request)
(setf (get printeps_hsr_modules::HsrNav2 :response) printeps_hsr_modules::HsrNav2Response)

(defmethod printeps_hsr_modules::HsrNav2Request
  (:response () (instance printeps_hsr_modules::HsrNav2Response :init)))

(setf (get printeps_hsr_modules::HsrNav2Request :md5sum-) "659f5d58ec18e8cceedaf86bc551955b")
(setf (get printeps_hsr_modules::HsrNav2Request :datatype-) "printeps_hsr_modules/HsrNav2Request")
(setf (get printeps_hsr_modules::HsrNav2Request :definition-)
      "
geometry_msgs/Pose2D  pose
bool                  obstacle_avoidance
bool                  first_rot

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

(setf (get printeps_hsr_modules::HsrNav2Response :md5sum-) "659f5d58ec18e8cceedaf86bc551955b")
(setf (get printeps_hsr_modules::HsrNav2Response :datatype-) "printeps_hsr_modules/HsrNav2Response")
(setf (get printeps_hsr_modules::HsrNav2Response :definition-)
      "
geometry_msgs/Pose2D  pose
bool                  obstacle_avoidance
bool                  first_rot

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



(provide :printeps_hsr_modules/HsrNav2 "659f5d58ec18e8cceedaf86bc551955b")


