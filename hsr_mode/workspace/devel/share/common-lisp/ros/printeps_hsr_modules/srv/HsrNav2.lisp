; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrNav2-request.msg.html

(cl:defclass <HsrNav2-request> (roslisp-msg-protocol:ros-message)
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
   (first_rot
    :reader first_rot
    :initarg :first_rot
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrNav2-request (<HsrNav2-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrNav2-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrNav2-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrNav2-request> is deprecated: use printeps_hsr_modules-srv:HsrNav2-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <HsrNav2-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose-val is deprecated.  Use printeps_hsr_modules-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'obstacle_avoidance-val :lambda-list '(m))
(cl:defmethod obstacle_avoidance-val ((m <HsrNav2-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:obstacle_avoidance-val is deprecated.  Use printeps_hsr_modules-srv:obstacle_avoidance instead.")
  (obstacle_avoidance m))

(cl:ensure-generic-function 'first_rot-val :lambda-list '(m))
(cl:defmethod first_rot-val ((m <HsrNav2-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:first_rot-val is deprecated.  Use printeps_hsr_modules-srv:first_rot instead.")
  (first_rot m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrNav2-request>) ostream)
  "Serializes a message object of type '<HsrNav2-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'obstacle_avoidance) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'first_rot) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrNav2-request>) istream)
  "Deserializes a message object of type '<HsrNav2-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:setf (cl:slot-value msg 'obstacle_avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'first_rot) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrNav2-request>)))
  "Returns string type for a service object of type '<HsrNav2-request>"
  "printeps_hsr_modules/HsrNav2Request")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav2-request)))
  "Returns string type for a service object of type 'HsrNav2-request"
  "printeps_hsr_modules/HsrNav2Request")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrNav2-request>)))
  "Returns md5sum for a message object of type '<HsrNav2-request>"
  "659f5d58ec18e8cceedaf86bc551955b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrNav2-request)))
  "Returns md5sum for a message object of type 'HsrNav2-request"
  "659f5d58ec18e8cceedaf86bc551955b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrNav2-request>)))
  "Returns full string definition for message of type '<HsrNav2-request>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%bool                  obstacle_avoidance~%bool                  first_rot~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrNav2-request)))
  "Returns full string definition for message of type 'HsrNav2-request"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%bool                  obstacle_avoidance~%bool                  first_rot~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrNav2-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrNav2-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrNav2-request
    (cl:cons ':pose (pose msg))
    (cl:cons ':obstacle_avoidance (obstacle_avoidance msg))
    (cl:cons ':first_rot (first_rot msg))
))
;//! \htmlinclude HsrNav2-response.msg.html

(cl:defclass <HsrNav2-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrNav2-response (<HsrNav2-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrNav2-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrNav2-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrNav2-response> is deprecated: use printeps_hsr_modules-srv:HsrNav2-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrNav2-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrNav2-response>) ostream)
  "Serializes a message object of type '<HsrNav2-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrNav2-response>) istream)
  "Deserializes a message object of type '<HsrNav2-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrNav2-response>)))
  "Returns string type for a service object of type '<HsrNav2-response>"
  "printeps_hsr_modules/HsrNav2Response")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav2-response)))
  "Returns string type for a service object of type 'HsrNav2-response"
  "printeps_hsr_modules/HsrNav2Response")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrNav2-response>)))
  "Returns md5sum for a message object of type '<HsrNav2-response>"
  "659f5d58ec18e8cceedaf86bc551955b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrNav2-response)))
  "Returns md5sum for a message object of type 'HsrNav2-response"
  "659f5d58ec18e8cceedaf86bc551955b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrNav2-response>)))
  "Returns full string definition for message of type '<HsrNav2-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrNav2-response)))
  "Returns full string definition for message of type 'HsrNav2-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrNav2-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrNav2-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrNav2-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrNav2)))
  'HsrNav2-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrNav2)))
  'HsrNav2-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrNav2)))
  "Returns string type for a service object of type '<HsrNav2>"
  "printeps_hsr_modules/HsrNav2")