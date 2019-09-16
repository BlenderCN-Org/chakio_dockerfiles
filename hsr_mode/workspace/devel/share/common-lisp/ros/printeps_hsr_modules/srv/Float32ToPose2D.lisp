; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude Float32ToPose2D-request.msg.html

(cl:defclass <Float32ToPose2D-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (theta
    :reader theta
    :initarg :theta
    :type cl:float
    :initform 0.0))
)

(cl:defclass Float32ToPose2D-request (<Float32ToPose2D-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Float32ToPose2D-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Float32ToPose2D-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<Float32ToPose2D-request> is deprecated: use printeps_hsr_modules-srv:Float32ToPose2D-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <Float32ToPose2D-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:x-val is deprecated.  Use printeps_hsr_modules-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <Float32ToPose2D-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:y-val is deprecated.  Use printeps_hsr_modules-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'theta-val :lambda-list '(m))
(cl:defmethod theta-val ((m <Float32ToPose2D-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:theta-val is deprecated.  Use printeps_hsr_modules-srv:theta instead.")
  (theta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Float32ToPose2D-request>) ostream)
  "Serializes a message object of type '<Float32ToPose2D-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Float32ToPose2D-request>) istream)
  "Deserializes a message object of type '<Float32ToPose2D-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Float32ToPose2D-request>)))
  "Returns string type for a service object of type '<Float32ToPose2D-request>"
  "printeps_hsr_modules/Float32ToPose2DRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Float32ToPose2D-request)))
  "Returns string type for a service object of type 'Float32ToPose2D-request"
  "printeps_hsr_modules/Float32ToPose2DRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Float32ToPose2D-request>)))
  "Returns md5sum for a message object of type '<Float32ToPose2D-request>"
  "595198faf2d4ff1d9d56604b59c791ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Float32ToPose2D-request)))
  "Returns md5sum for a message object of type 'Float32ToPose2D-request"
  "595198faf2d4ff1d9d56604b59c791ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Float32ToPose2D-request>)))
  "Returns full string definition for message of type '<Float32ToPose2D-request>"
  (cl:format cl:nil "~%~%~%float32 x~%float32 y~%float32 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Float32ToPose2D-request)))
  "Returns full string definition for message of type 'Float32ToPose2D-request"
  (cl:format cl:nil "~%~%~%float32 x~%float32 y~%float32 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Float32ToPose2D-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Float32ToPose2D-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Float32ToPose2D-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':theta (theta msg))
))
;//! \htmlinclude Float32ToPose2D-response.msg.html

(cl:defclass <Float32ToPose2D-response> (roslisp-msg-protocol:ros-message)
  ((pose2d
    :reader pose2d
    :initarg :pose2d
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D)))
)

(cl:defclass Float32ToPose2D-response (<Float32ToPose2D-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Float32ToPose2D-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Float32ToPose2D-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<Float32ToPose2D-response> is deprecated: use printeps_hsr_modules-srv:Float32ToPose2D-response instead.")))

(cl:ensure-generic-function 'pose2d-val :lambda-list '(m))
(cl:defmethod pose2d-val ((m <Float32ToPose2D-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose2d-val is deprecated.  Use printeps_hsr_modules-srv:pose2d instead.")
  (pose2d m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Float32ToPose2D-response>) ostream)
  "Serializes a message object of type '<Float32ToPose2D-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose2d) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Float32ToPose2D-response>) istream)
  "Deserializes a message object of type '<Float32ToPose2D-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose2d) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Float32ToPose2D-response>)))
  "Returns string type for a service object of type '<Float32ToPose2D-response>"
  "printeps_hsr_modules/Float32ToPose2DResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Float32ToPose2D-response)))
  "Returns string type for a service object of type 'Float32ToPose2D-response"
  "printeps_hsr_modules/Float32ToPose2DResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Float32ToPose2D-response>)))
  "Returns md5sum for a message object of type '<Float32ToPose2D-response>"
  "595198faf2d4ff1d9d56604b59c791ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Float32ToPose2D-response)))
  "Returns md5sum for a message object of type 'Float32ToPose2D-response"
  "595198faf2d4ff1d9d56604b59c791ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Float32ToPose2D-response>)))
  "Returns full string definition for message of type '<Float32ToPose2D-response>"
  (cl:format cl:nil "geometry_msgs/Pose2D pose2d~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Float32ToPose2D-response)))
  "Returns full string definition for message of type 'Float32ToPose2D-response"
  (cl:format cl:nil "geometry_msgs/Pose2D pose2d~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Float32ToPose2D-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose2d))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Float32ToPose2D-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Float32ToPose2D-response
    (cl:cons ':pose2d (pose2d msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Float32ToPose2D)))
  'Float32ToPose2D-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Float32ToPose2D)))
  'Float32ToPose2D-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Float32ToPose2D)))
  "Returns string type for a service object of type '<Float32ToPose2D>"
  "printeps_hsr_modules/Float32ToPose2D")