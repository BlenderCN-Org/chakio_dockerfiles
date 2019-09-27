;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrPerson)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrPerson (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPERSON")
  (make-package "PRINTEPS_HSR_MODULES::HSRPERSON"))

(in-package "ROS")
;;//! \htmlinclude HsrPerson.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass printeps_hsr_modules::HsrPerson
  :super ros::object
  :slots (_pose _confidence _isHandUp ))

(defmethod printeps_hsr_modules::HsrPerson
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose2D :init))
    ((:confidence __confidence) 0.0)
    ((:isHandUp __isHandUp) nil)
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _confidence (float __confidence))
   (setq _isHandUp __isHandUp)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:isHandUp
   (&optional __isHandUp)
   (if __isHandUp (setq _isHandUp __isHandUp)) _isHandUp)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _pose
    (send _pose :serialization-length)
    ;; float32 _confidence
    4
    ;; bool _isHandUp
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _pose
       (send _pose :serialize s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _isHandUp
       (if _isHandUp (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _isHandUp
     (setq _isHandUp (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get printeps_hsr_modules::HsrPerson :md5sum-) "37f248d54fedc2638eca426e3e06dea6")
(setf (get printeps_hsr_modules::HsrPerson :datatype-) "printeps_hsr_modules/HsrPerson")
(setf (get printeps_hsr_modules::HsrPerson :definition-)
      "
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



(provide :printeps_hsr_modules/HsrPerson "37f248d54fedc2638eca426e3e06dea6")


