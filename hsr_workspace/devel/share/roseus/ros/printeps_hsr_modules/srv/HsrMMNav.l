;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrMMNav)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrMMNav (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRMMNAV")
  (make-package "PRINTEPS_HSR_MODULES::HSRMMNAV"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRMMNAVREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRMMNAVREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRMMNAVRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRMMNAVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))




(defclass printeps_hsr_modules::HsrMMNavRequest
  :super ros::object
  :slots (_pose _voiceImportance ))

(defmethod printeps_hsr_modules::HsrMMNavRequest
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose2D :init))
    ((:voiceImportance __voiceImportance) (instance std_msgs::Float64 :init))
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _voiceImportance __voiceImportance)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:voiceImportance
   (&rest __voiceImportance)
   (if (keywordp (car __voiceImportance))
       (send* _voiceImportance __voiceImportance)
     (progn
       (if __voiceImportance (setq _voiceImportance (car __voiceImportance)))
       _voiceImportance)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose
    (send _pose :serialization-length)
    ;; std_msgs/Float64 _voiceImportance
    (send _voiceImportance :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose
       (send _pose :serialize s)
     ;; std_msgs/Float64 _voiceImportance
       (send _voiceImportance :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; std_msgs/Float64 _voiceImportance
     (send _voiceImportance :deserialize buf ptr-) (incf ptr- (send _voiceImportance :serialization-length))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrMMNavResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrMMNavResponse
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

(defclass printeps_hsr_modules::HsrMMNav
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrMMNav :md5sum-) "6c1ad0746ba7a1849f6940921095b943")
(setf (get printeps_hsr_modules::HsrMMNav :datatype-) "printeps_hsr_modules/HsrMMNav")
(setf (get printeps_hsr_modules::HsrMMNav :request) printeps_hsr_modules::HsrMMNavRequest)
(setf (get printeps_hsr_modules::HsrMMNav :response) printeps_hsr_modules::HsrMMNavResponse)

(defmethod printeps_hsr_modules::HsrMMNavRequest
  (:response () (instance printeps_hsr_modules::HsrMMNavResponse :init)))

(setf (get printeps_hsr_modules::HsrMMNavRequest :md5sum-) "6c1ad0746ba7a1849f6940921095b943")
(setf (get printeps_hsr_modules::HsrMMNavRequest :datatype-) "printeps_hsr_modules/HsrMMNavRequest")
(setf (get printeps_hsr_modules::HsrMMNavRequest :definition-)
      "
geometry_msgs/Pose2D    pose
std_msgs/Float64        voiceImportance

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
MSG: std_msgs/Float64
---
bool success
")

(setf (get printeps_hsr_modules::HsrMMNavResponse :md5sum-) "6c1ad0746ba7a1849f6940921095b943")
(setf (get printeps_hsr_modules::HsrMMNavResponse :datatype-) "printeps_hsr_modules/HsrMMNavResponse")
(setf (get printeps_hsr_modules::HsrMMNavResponse :definition-)
      "
geometry_msgs/Pose2D    pose
std_msgs/Float64        voiceImportance

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
MSG: std_msgs/Float64
---
bool success
")



(provide :printeps_hsr_modules/HsrMMNav "6c1ad0746ba7a1849f6940921095b943")


