;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrOpenpose)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrOpenpose (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSROPENPOSE")
  (make-package "PRINTEPS_HSR_MODULES::HSROPENPOSE"))

(in-package "ROS")
;;//! \htmlinclude HsrOpenpose.msg.html


(defclass printeps_hsr_modules::HsrOpenpose
  :super ros::object
  :slots (_people ))

(defmethod printeps_hsr_modules::HsrOpenpose
  (:init
   (&key
    ((:people __people) (let (r) (dotimes (i 0) (push (instance printeps_hsr_modules::HsrPerson :init) r)) r))
    )
   (send-super :init)
   (setq _people __people)
   self)
  (:people
   (&rest __people)
   (if (keywordp (car __people))
       (send* _people __people)
     (progn
       (if __people (setq _people (car __people)))
       _people)))
  (:serialization-length
   ()
   (+
    ;; printeps_hsr_modules/HsrPerson[] _people
    (apply #'+ (send-all _people :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; printeps_hsr_modules/HsrPerson[] _people
     (write-long (length _people) s)
     (dolist (elem _people)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; printeps_hsr_modules/HsrPerson[] _people
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _people (let (r) (dotimes (i n) (push (instance printeps_hsr_modules::HsrPerson :init) r)) r))
     (dolist (elem- _people)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get printeps_hsr_modules::HsrOpenpose :md5sum-) "a952aca51b6ba06cdce810f6825d8c74")
(setf (get printeps_hsr_modules::HsrOpenpose :datatype-) "printeps_hsr_modules/HsrOpenpose")
(setf (get printeps_hsr_modules::HsrOpenpose :definition-)
      "HsrPerson[] people
================================================================================
MSG: printeps_hsr_modules/HsrPerson

geometry_msgs/Pose2D  pose
float32 confidence
bool    isHandUp
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



(provide :printeps_hsr_modules/HsrOpenpose "a952aca51b6ba06cdce810f6825d8c74")


