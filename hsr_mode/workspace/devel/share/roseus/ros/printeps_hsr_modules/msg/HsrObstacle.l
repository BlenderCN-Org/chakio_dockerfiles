;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrObstacle)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrObstacle (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSROBSTACLE")
  (make-package "PRINTEPS_HSR_MODULES::HSROBSTACLE"))

(in-package "ROS")
;;//! \htmlinclude HsrObstacle.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass printeps_hsr_modules::HsrObstacle
  :super ros::object
  :slots (_pose _width ))

(defmethod printeps_hsr_modules::HsrObstacle
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose2D :init))
    ((:width __width) 0.0)
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _width (float __width))
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose
    (send _pose :serialization-length)
    ;; float32 _width
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose
       (send _pose :serialize s)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get printeps_hsr_modules::HsrObstacle :md5sum-) "1a9ed5a6d496973b5f1cb4ac9bbcb30a")
(setf (get printeps_hsr_modules::HsrObstacle :datatype-) "printeps_hsr_modules/HsrObstacle")
(setf (get printeps_hsr_modules::HsrObstacle :definition-)
      "geometry_msgs/Pose2D  pose
float32 width
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



(provide :printeps_hsr_modules/HsrObstacle "1a9ed5a6d496973b5f1cb4ac9bbcb30a")


