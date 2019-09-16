;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::Float32ToPose2D)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'Float32ToPose2D (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2D")
  (make-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2D"))
(unless (find-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2DREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2DREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2DRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::FLOAT32TOPOSE2DRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass printeps_hsr_modules::Float32ToPose2DRequest
  :super ros::object
  :slots (_x _y _theta ))

(defmethod printeps_hsr_modules::Float32ToPose2DRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:theta __theta) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _theta (float __theta))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:theta
   (&optional __theta)
   (if __theta (setq _theta __theta)) _theta)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _theta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta
       (sys::poke _theta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta
     (setq _theta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass printeps_hsr_modules::Float32ToPose2DResponse
  :super ros::object
  :slots (_pose2d ))

(defmethod printeps_hsr_modules::Float32ToPose2DResponse
  (:init
   (&key
    ((:pose2d __pose2d) (instance geometry_msgs::Pose2D :init))
    )
   (send-super :init)
   (setq _pose2d __pose2d)
   self)
  (:pose2d
   (&rest __pose2d)
   (if (keywordp (car __pose2d))
       (send* _pose2d __pose2d)
     (progn
       (if __pose2d (setq _pose2d (car __pose2d)))
       _pose2d)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose2d
    (send _pose2d :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose2d
       (send _pose2d :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose2d
     (send _pose2d :deserialize buf ptr-) (incf ptr- (send _pose2d :serialization-length))
   ;;
   self)
  )

(defclass printeps_hsr_modules::Float32ToPose2D
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::Float32ToPose2D :md5sum-) "595198faf2d4ff1d9d56604b59c791ea")
(setf (get printeps_hsr_modules::Float32ToPose2D :datatype-) "printeps_hsr_modules/Float32ToPose2D")
(setf (get printeps_hsr_modules::Float32ToPose2D :request) printeps_hsr_modules::Float32ToPose2DRequest)
(setf (get printeps_hsr_modules::Float32ToPose2D :response) printeps_hsr_modules::Float32ToPose2DResponse)

(defmethod printeps_hsr_modules::Float32ToPose2DRequest
  (:response () (instance printeps_hsr_modules::Float32ToPose2DResponse :init)))

(setf (get printeps_hsr_modules::Float32ToPose2DRequest :md5sum-) "595198faf2d4ff1d9d56604b59c791ea")
(setf (get printeps_hsr_modules::Float32ToPose2DRequest :datatype-) "printeps_hsr_modules/Float32ToPose2DRequest")
(setf (get printeps_hsr_modules::Float32ToPose2DRequest :definition-)
      "


float32 x
float32 y
float32 theta
---
geometry_msgs/Pose2D pose2d

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
")

(setf (get printeps_hsr_modules::Float32ToPose2DResponse :md5sum-) "595198faf2d4ff1d9d56604b59c791ea")
(setf (get printeps_hsr_modules::Float32ToPose2DResponse :datatype-) "printeps_hsr_modules/Float32ToPose2DResponse")
(setf (get printeps_hsr_modules::Float32ToPose2DResponse :definition-)
      "


float32 x
float32 y
float32 theta
---
geometry_msgs/Pose2D pose2d

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
")



(provide :printeps_hsr_modules/Float32ToPose2D "595198faf2d4ff1d9d56604b59c791ea")


