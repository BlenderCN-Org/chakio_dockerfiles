; Auto-generated. Do not edit!


(cl:in-package printeps_pepper_modules-srv)


;//! \htmlinclude PathGenerator-request.msg.html

(cl:defclass <PathGenerator-request> (roslisp-msg-protocol:ros-message)
  ((start
    :reader start
    :initarg :start
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (dynamicObstacle
    :reader dynamicObstacle
    :initarg :dynamicObstacle
    :type geometry_msgs-msg:PoseArray
    :initform (cl:make-instance 'geometry_msgs-msg:PoseArray)))
)

(cl:defclass PathGenerator-request (<PathGenerator-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PathGenerator-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PathGenerator-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PathGenerator-request> is deprecated: use printeps_pepper_modules-srv:PathGenerator-request instead.")))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <PathGenerator-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:start-val is deprecated.  Use printeps_pepper_modules-srv:start instead.")
  (start m))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <PathGenerator-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:goal-val is deprecated.  Use printeps_pepper_modules-srv:goal instead.")
  (goal m))

(cl:ensure-generic-function 'dynamicObstacle-val :lambda-list '(m))
(cl:defmethod dynamicObstacle-val ((m <PathGenerator-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:dynamicObstacle-val is deprecated.  Use printeps_pepper_modules-srv:dynamicObstacle instead.")
  (dynamicObstacle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PathGenerator-request>) ostream)
  "Serializes a message object of type '<PathGenerator-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'start) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'dynamicObstacle) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PathGenerator-request>) istream)
  "Deserializes a message object of type '<PathGenerator-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'start) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'dynamicObstacle) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PathGenerator-request>)))
  "Returns string type for a service object of type '<PathGenerator-request>"
  "printeps_pepper_modules/PathGeneratorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathGenerator-request)))
  "Returns string type for a service object of type 'PathGenerator-request"
  "printeps_pepper_modules/PathGeneratorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PathGenerator-request>)))
  "Returns md5sum for a message object of type '<PathGenerator-request>"
  "3a7361f4077151c10d6f43ed28f73c44")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PathGenerator-request)))
  "Returns md5sum for a message object of type 'PathGenerator-request"
  "3a7361f4077151c10d6f43ed28f73c44")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PathGenerator-request>)))
  "Returns full string definition for message of type '<PathGenerator-request>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D start~%geometry_msgs/Pose2D goal~%geometry_msgs/PoseArray dynamicObstacle~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/PoseArray~%# An array of poses with a header for global reference.~%~%Header header~%~%Pose[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PathGenerator-request)))
  "Returns full string definition for message of type 'PathGenerator-request"
  (cl:format cl:nil "~%geometry_msgs/Pose2D start~%geometry_msgs/Pose2D goal~%geometry_msgs/PoseArray dynamicObstacle~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/PoseArray~%# An array of poses with a header for global reference.~%~%Header header~%~%Pose[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PathGenerator-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'start))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'dynamicObstacle))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PathGenerator-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PathGenerator-request
    (cl:cons ':start (start msg))
    (cl:cons ':goal (goal msg))
    (cl:cons ':dynamicObstacle (dynamicObstacle msg))
))
;//! \htmlinclude PathGenerator-response.msg.html

(cl:defclass <PathGenerator-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type geometry_msgs-msg:PoseArray
    :initform (cl:make-instance 'geometry_msgs-msg:PoseArray))
   (length
    :reader length
    :initarg :length
    :type std_msgs-msg:Float32
    :initform (cl:make-instance 'std_msgs-msg:Float32)))
)

(cl:defclass PathGenerator-response (<PathGenerator-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PathGenerator-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PathGenerator-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PathGenerator-response> is deprecated: use printeps_pepper_modules-srv:PathGenerator-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <PathGenerator-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:path-val is deprecated.  Use printeps_pepper_modules-srv:path instead.")
  (path m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <PathGenerator-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:length-val is deprecated.  Use printeps_pepper_modules-srv:length instead.")
  (length m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PathGenerator-response>) ostream)
  "Serializes a message object of type '<PathGenerator-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'path) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'length) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PathGenerator-response>) istream)
  "Deserializes a message object of type '<PathGenerator-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'path) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'length) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PathGenerator-response>)))
  "Returns string type for a service object of type '<PathGenerator-response>"
  "printeps_pepper_modules/PathGeneratorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathGenerator-response)))
  "Returns string type for a service object of type 'PathGenerator-response"
  "printeps_pepper_modules/PathGeneratorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PathGenerator-response>)))
  "Returns md5sum for a message object of type '<PathGenerator-response>"
  "3a7361f4077151c10d6f43ed28f73c44")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PathGenerator-response)))
  "Returns md5sum for a message object of type 'PathGenerator-response"
  "3a7361f4077151c10d6f43ed28f73c44")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PathGenerator-response>)))
  "Returns full string definition for message of type '<PathGenerator-response>"
  (cl:format cl:nil "geometry_msgs/PoseArray path~%std_msgs/Float32 length~%~%================================================================================~%MSG: geometry_msgs/PoseArray~%# An array of poses with a header for global reference.~%~%Header header~%~%Pose[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/Float32~%float32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PathGenerator-response)))
  "Returns full string definition for message of type 'PathGenerator-response"
  (cl:format cl:nil "geometry_msgs/PoseArray path~%std_msgs/Float32 length~%~%================================================================================~%MSG: geometry_msgs/PoseArray~%# An array of poses with a header for global reference.~%~%Header header~%~%Pose[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/Float32~%float32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PathGenerator-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'path))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'length))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PathGenerator-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PathGenerator-response
    (cl:cons ':path (path msg))
    (cl:cons ':length (length msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PathGenerator)))
  'PathGenerator-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PathGenerator)))
  'PathGenerator-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathGenerator)))
  "Returns string type for a service object of type '<PathGenerator>"
  "printeps_pepper_modules/PathGenerator")