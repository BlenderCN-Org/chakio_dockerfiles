;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrTableset)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrTableset (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRTABLESET")
  (make-package "PRINTEPS_HSR_MODULES::HSRTABLESET"))

(in-package "ROS")
;;//! \htmlinclude HsrTableset.msg.html


(defclass printeps_hsr_modules::HsrTableset
  :super ros::object
  :slots (_table _chairs ))

(defmethod printeps_hsr_modules::HsrTableset
  (:init
   (&key
    ((:table __table) (instance printeps_hsr_modules::HsrObstacle :init))
    ((:chairs __chairs) (let (r) (dotimes (i 0) (push (instance printeps_hsr_modules::HsrObstacle :init) r)) r))
    )
   (send-super :init)
   (setq _table __table)
   (setq _chairs __chairs)
   self)
  (:table
   (&rest __table)
   (if (keywordp (car __table))
       (send* _table __table)
     (progn
       (if __table (setq _table (car __table)))
       _table)))
  (:chairs
   (&rest __chairs)
   (if (keywordp (car __chairs))
       (send* _chairs __chairs)
     (progn
       (if __chairs (setq _chairs (car __chairs)))
       _chairs)))
  (:serialization-length
   ()
   (+
    ;; printeps_hsr_modules/HsrObstacle _table
    (send _table :serialization-length)
    ;; printeps_hsr_modules/HsrObstacle[] _chairs
    (apply #'+ (send-all _chairs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; printeps_hsr_modules/HsrObstacle _table
       (send _table :serialize s)
     ;; printeps_hsr_modules/HsrObstacle[] _chairs
     (write-long (length _chairs) s)
     (dolist (elem _chairs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; printeps_hsr_modules/HsrObstacle _table
     (send _table :deserialize buf ptr-) (incf ptr- (send _table :serialization-length))
   ;; printeps_hsr_modules/HsrObstacle[] _chairs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _chairs (let (r) (dotimes (i n) (push (instance printeps_hsr_modules::HsrObstacle :init) r)) r))
     (dolist (elem- _chairs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get printeps_hsr_modules::HsrTableset :md5sum-) "03ffed0b2ff00166a3c8658f40a325f8")
(setf (get printeps_hsr_modules::HsrTableset :datatype-) "printeps_hsr_modules/HsrTableset")
(setf (get printeps_hsr_modules::HsrTableset :definition-)
      "
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



(provide :printeps_hsr_modules/HsrTableset "03ffed0b2ff00166a3c8658f40a325f8")


