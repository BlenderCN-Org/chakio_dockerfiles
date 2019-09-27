;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::PathGenerator)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'PathGenerator (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::PATHGENERATOR")
  (make-package "PRINTEPS_HSR_MODULES::PATHGENERATOR"))
(unless (find-package "PRINTEPS_HSR_MODULES::PATHGENERATORREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::PATHGENERATORREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::PATHGENERATORRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::PATHGENERATORRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass printeps_hsr_modules::PathGeneratorRequest
  :super ros::object
  :slots (_start _goal _dynamicObstacle _multimodalPathplanning _voiceImportance ))

(defmethod printeps_hsr_modules::PathGeneratorRequest
  (:init
   (&key
    ((:start __start) (instance geometry_msgs::Pose2D :init))
    ((:goal __goal) (instance geometry_msgs::Pose2D :init))
    ((:dynamicObstacle __dynamicObstacle) (instance geometry_msgs::PoseArray :init))
    ((:multimodalPathplanning __multimodalPathplanning) (instance std_msgs::Bool :init))
    ((:voiceImportance __voiceImportance) (instance std_msgs::Float64 :init))
    )
   (send-super :init)
   (setq _start __start)
   (setq _goal __goal)
   (setq _dynamicObstacle __dynamicObstacle)
   (setq _multimodalPathplanning __multimodalPathplanning)
   (setq _voiceImportance __voiceImportance)
   self)
  (:start
   (&rest __start)
   (if (keywordp (car __start))
       (send* _start __start)
     (progn
       (if __start (setq _start (car __start)))
       _start)))
  (:goal
   (&rest __goal)
   (if (keywordp (car __goal))
       (send* _goal __goal)
     (progn
       (if __goal (setq _goal (car __goal)))
       _goal)))
  (:dynamicObstacle
   (&rest __dynamicObstacle)
   (if (keywordp (car __dynamicObstacle))
       (send* _dynamicObstacle __dynamicObstacle)
     (progn
       (if __dynamicObstacle (setq _dynamicObstacle (car __dynamicObstacle)))
       _dynamicObstacle)))
  (:multimodalPathplanning
   (&rest __multimodalPathplanning)
   (if (keywordp (car __multimodalPathplanning))
       (send* _multimodalPathplanning __multimodalPathplanning)
     (progn
       (if __multimodalPathplanning (setq _multimodalPathplanning (car __multimodalPathplanning)))
       _multimodalPathplanning)))
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
    ;; geometry_msgs/Pose2D _start
    (send _start :serialization-length)
    ;; geometry_msgs/Pose2D _goal
    (send _goal :serialization-length)
    ;; geometry_msgs/PoseArray _dynamicObstacle
    (send _dynamicObstacle :serialization-length)
    ;; std_msgs/Bool _multimodalPathplanning
    (send _multimodalPathplanning :serialization-length)
    ;; std_msgs/Float64 _voiceImportance
    (send _voiceImportance :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _start
       (send _start :serialize s)
     ;; geometry_msgs/Pose2D _goal
       (send _goal :serialize s)
     ;; geometry_msgs/PoseArray _dynamicObstacle
       (send _dynamicObstacle :serialize s)
     ;; std_msgs/Bool _multimodalPathplanning
       (send _multimodalPathplanning :serialize s)
     ;; std_msgs/Float64 _voiceImportance
       (send _voiceImportance :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _start
     (send _start :deserialize buf ptr-) (incf ptr- (send _start :serialization-length))
   ;; geometry_msgs/Pose2D _goal
     (send _goal :deserialize buf ptr-) (incf ptr- (send _goal :serialization-length))
   ;; geometry_msgs/PoseArray _dynamicObstacle
     (send _dynamicObstacle :deserialize buf ptr-) (incf ptr- (send _dynamicObstacle :serialization-length))
   ;; std_msgs/Bool _multimodalPathplanning
     (send _multimodalPathplanning :deserialize buf ptr-) (incf ptr- (send _multimodalPathplanning :serialization-length))
   ;; std_msgs/Float64 _voiceImportance
     (send _voiceImportance :deserialize buf ptr-) (incf ptr- (send _voiceImportance :serialization-length))
   ;;
   self)
  )

(defclass printeps_hsr_modules::PathGeneratorResponse
  :super ros::object
  :slots (_path _length ))

(defmethod printeps_hsr_modules::PathGeneratorResponse
  (:init
   (&key
    ((:path __path) (instance geometry_msgs::PoseArray :init))
    ((:length __length) (instance std_msgs::Float32 :init))
    )
   (send-super :init)
   (setq _path __path)
   (setq _length __length)
   self)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:length
   (&rest __length)
   (if (keywordp (car __length))
       (send* _length __length)
     (progn
       (if __length (setq _length (car __length)))
       _length)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/PoseArray _path
    (send _path :serialization-length)
    ;; std_msgs/Float32 _length
    (send _length :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PoseArray _path
       (send _path :serialize s)
     ;; std_msgs/Float32 _length
       (send _length :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PoseArray _path
     (send _path :deserialize buf ptr-) (incf ptr- (send _path :serialization-length))
   ;; std_msgs/Float32 _length
     (send _length :deserialize buf ptr-) (incf ptr- (send _length :serialization-length))
   ;;
   self)
  )

(defclass printeps_hsr_modules::PathGenerator
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::PathGenerator :md5sum-) "da86772c5496ba414c78c020ceee2035")
(setf (get printeps_hsr_modules::PathGenerator :datatype-) "printeps_hsr_modules/PathGenerator")
(setf (get printeps_hsr_modules::PathGenerator :request) printeps_hsr_modules::PathGeneratorRequest)
(setf (get printeps_hsr_modules::PathGenerator :response) printeps_hsr_modules::PathGeneratorResponse)

(defmethod printeps_hsr_modules::PathGeneratorRequest
  (:response () (instance printeps_hsr_modules::PathGeneratorResponse :init)))

(setf (get printeps_hsr_modules::PathGeneratorRequest :md5sum-) "da86772c5496ba414c78c020ceee2035")
(setf (get printeps_hsr_modules::PathGeneratorRequest :datatype-) "printeps_hsr_modules/PathGeneratorRequest")
(setf (get printeps_hsr_modules::PathGeneratorRequest :definition-)
      "
geometry_msgs/Pose2D    start
geometry_msgs/Pose2D    goal
geometry_msgs/PoseArray dynamicObstacle
std_msgs/Bool           multimodalPathplanning
std_msgs/Float64         voiceImportance

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
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Bool
bool data
================================================================================
MSG: std_msgs/Float64
---
geometry_msgs/PoseArray path
std_msgs/Float32 length

================================================================================
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Float32
")

(setf (get printeps_hsr_modules::PathGeneratorResponse :md5sum-) "da86772c5496ba414c78c020ceee2035")
(setf (get printeps_hsr_modules::PathGeneratorResponse :datatype-) "printeps_hsr_modules/PathGeneratorResponse")
(setf (get printeps_hsr_modules::PathGeneratorResponse :definition-)
      "
geometry_msgs/Pose2D    start
geometry_msgs/Pose2D    goal
geometry_msgs/PoseArray dynamicObstacle
std_msgs/Bool           multimodalPathplanning
std_msgs/Float64         voiceImportance

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
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Bool
bool data
================================================================================
MSG: std_msgs/Float64
---
geometry_msgs/PoseArray path
std_msgs/Float32 length

================================================================================
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Float32
")



(provide :printeps_hsr_modules/PathGenerator "da86772c5496ba414c78c020ceee2035")


