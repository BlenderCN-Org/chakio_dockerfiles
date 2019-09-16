;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrObstacleArray)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrObstacleArray (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSROBSTACLEARRAY")
  (make-package "PRINTEPS_HSR_MODULES::HSROBSTACLEARRAY"))

(in-package "ROS")
;;//! \htmlinclude HsrObstacleArray.msg.html


(defclass printeps_hsr_modules::HsrObstacleArray
  :super ros::object
  :slots (_obstacles ))

(defmethod printeps_hsr_modules::HsrObstacleArray
  (:init
   (&key
    ((:obstacles __obstacles) (let (r) (dotimes (i 0) (push (instance printeps_hsr_modules::HsrTableset :init) r)) r))
    )
   (send-super :init)
   (setq _obstacles __obstacles)
   self)
  (:obstacles
   (&rest __obstacles)
   (if (keywordp (car __obstacles))
       (send* _obstacles __obstacles)
     (progn
       (if __obstacles (setq _obstacles (car __obstacles)))
       _obstacles)))
  (:serialization-length
   ()
   (+
    ;; printeps_hsr_modules/HsrTableset[] _obstacles
    (apply #'+ (send-all _obstacles :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; printeps_hsr_modules/HsrTableset[] _obstacles
     (write-long (length _obstacles) s)
     (dolist (elem _obstacles)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; printeps_hsr_modules/HsrTableset[] _obstacles
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _obstacles (let (r) (dotimes (i n) (push (instance printeps_hsr_modules::HsrTableset :init) r)) r))
     (dolist (elem- _obstacles)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get printeps_hsr_modules::HsrObstacleArray :md5sum-) "7e3b0fff0352a3b8fd7f25ac5227d549")
(setf (get printeps_hsr_modules::HsrObstacleArray :datatype-) "printeps_hsr_modules/HsrObstacleArray")
(setf (get printeps_hsr_modules::HsrObstacleArray :definition-)
      "HsrTableset[]   obstacles
================================================================================
MSG: printeps_hsr_modules/HsrTableset

HsrObstacle     table
HsrObstacle[]   chairs
================================================================================
MSG: printeps_hsr_modules/HsrObstacle
geometry_msgs/Pose2D  pose
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



(provide :printeps_hsr_modules/HsrObstacleArray "7e3b0fff0352a3b8fd7f25ac5227d549")


