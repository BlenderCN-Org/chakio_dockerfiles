; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrNav3-request.msg.html

(cl:defclass <HsrNav3-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (obstacle_avoidance
    :reader obstacle_avoidance
    :initarg :obstacle_avoidance
    :type cl:boolean
    :initform cl:nil)
   (first_rot_limit
    :reader first_rot_limit
    :initarg :first_rot_limit
    :type cl:float
    :initform 0.0)
   (velocity
    :reader velocity
    :initarg :velocity
    :type cl:float
    :initform 0.0))
)

(cl:defclass HsrNav3-request (<HsrNav3-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrNav3-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrNav3-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrNav3-request> is deprecated: use printeps_hsr_modules-srv:HsrNav3-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <HsrNav3-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose-val is deprecated.  Use printeps_hsr_modules-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'obstacle_avoidance-val :lambda-list '(m))
(cl:defmethod obstacle_avoidance-val ((m <HsrNav3-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:obstacle_avoidance-val is deprecated.  Use printeps_hsr_modules-srv:obstacle_avoidance instead.")
  (obstacle_avoidance m))

(cl:ensure-generic-function 'first_rot_limit-val :lambda-list '(m))
(cl:defmethod first_rot_limit-val ((m <HsrNav3-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:first_rot_limit-val is deprecated.  Use printeps_hsr_modules-srv:first_rot_limit instead.")
  (first_rot_limit m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <HsrNav3-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:velocity-val is deprecated.  Use printeps_hsr_modules-srv:velocity instead.")
  (velocity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrNav3-request>) ostream)
  "Serializes a message object of type '<HsrNav3-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'obstacle_avoidance) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'first_rot_limit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrNav3-request>) istream)
  "Deserializes a message object of type '<HsrNav3-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:setf (cl:slot-value msg 'obstacle_avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'first_rot_limit) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'velocity) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrNav3-request>)))
  "Returns string type for a service object of type '<HsrNav3-request>"
  "printeps_hsr_modules/HsrNav3Request")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav3-request)))
  "Returns string type for a service object of type 'HsrNav3-request"
  "printeps_hsr_modules/HsrNav3Request")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrNav3-request>)))
  "Returns md5sum for a message object of type '<HsrNav3-request>"
  "ec5d44f130a88575c5041c2bf0711e81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrNav3-request)))
  "Returns md5sum for a message object of type 'HsrNav3-request"
  "ec5d44f130a88575c5041c2bf0711e81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrNav3-request>)))
  "Returns full string definition for message of type '<HsrNav3-request>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%bool                  obstacle_avoidance~%float32               first_rot_limit~%float32               velocity~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrNav3-request)))
  "Returns full string definition for message of type 'HsrNav3-request"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%bool                  obstacle_avoidance~%float32               first_rot_limit~%float32               velocity~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrNav3-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrNav3-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrNav3-request
    (cl:cons ':pose (pose msg))
    (cl:cons ':obstacle_avoidance (obstacle_avoidance msg))
    (cl:cons ':first_rot_limit (first_rot_limit msg))
    (cl:cons ':velocity (velocity msg))
))
;//! \htmlinclude HsrNav3-response.msg.html

(cl:defclass <HsrNav3-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrNav3-response (<HsrNav3-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrNav3-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrNav3-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrNav3-response> is deprecated: use printeps_hsr_modules-srv:HsrNav3-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrNav3-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrNav3-response>) ostream)
  "Serializes a message object of type '<HsrNav3-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrNav3-response>) istream)
  "Deserializes a message object of type '<HsrNav3-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrNav3-response>)))
  "Returns string type for a service object of type '<HsrNav3-response>"
  "printeps_hsr_modules/HsrNav3Response")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav3-response)))
  "Returns string type for a service object of type 'HsrNav3-response"
  "printeps_hsr_modules/HsrNav3Response")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrNav3-response>)))
  "Returns md5sum for a message object of type '<HsrNav3-response>"
  "ec5d44f130a88575c5041c2bf0711e81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrNav3-response)))
  "Returns md5sum for a message object of type 'HsrNav3-response"
  "ec5d44f130a88575c5041c2bf0711e81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrNav3-response>)))
  "Returns full string definition for message of type '<HsrNav3-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrNav3-response)))
  "Returns full string definition for message of type 'HsrNav3-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrNav3-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrNav3-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrNav3-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrNav3)))
  'HsrNav3-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrNav3)))
  'HsrNav3-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav3)))
  "Returns string type for a service object of type '<HsrNav3>"
  "printeps_hsr_modules/HsrNav3")