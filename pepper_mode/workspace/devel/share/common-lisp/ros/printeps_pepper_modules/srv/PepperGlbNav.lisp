; Auto-generated. Do not edit!


(cl:in-package printeps_pepper_modules-srv)


;//! \htmlinclude PepperGlbNav-request.msg.html

(cl:defclass <PepperGlbNav-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D)))
)

(cl:defclass PepperGlbNav-request (<PepperGlbNav-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PepperGlbNav-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PepperGlbNav-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PepperGlbNav-request> is deprecated: use printeps_pepper_modules-srv:PepperGlbNav-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <PepperGlbNav-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:pose-val is deprecated.  Use printeps_pepper_modules-srv:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PepperGlbNav-request>) ostream)
  "Serializes a message object of type '<PepperGlbNav-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PepperGlbNav-request>) istream)
  "Deserializes a message object of type '<PepperGlbNav-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PepperGlbNav-request>)))
  "Returns string type for a service object of type '<PepperGlbNav-request>"
  "printeps_pepper_modules/PepperGlbNavRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperGlbNav-request)))
  "Returns string type for a service object of type 'PepperGlbNav-request"
  "printeps_pepper_modules/PepperGlbNavRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PepperGlbNav-request>)))
  "Returns md5sum for a message object of type '<PepperGlbNav-request>"
  "cfc42ebcb6ac1e961d822c446b9526a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PepperGlbNav-request)))
  "Returns md5sum for a message object of type 'PepperGlbNav-request"
  "cfc42ebcb6ac1e961d822c446b9526a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PepperGlbNav-request>)))
  "Returns full string definition for message of type '<PepperGlbNav-request>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PepperGlbNav-request)))
  "Returns full string definition for message of type 'PepperGlbNav-request"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PepperGlbNav-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PepperGlbNav-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PepperGlbNav-request
    (cl:cons ':pose (pose msg))
))
;//! \htmlinclude PepperGlbNav-response.msg.html

(cl:defclass <PepperGlbNav-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass PepperGlbNav-response (<PepperGlbNav-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PepperGlbNav-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PepperGlbNav-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PepperGlbNav-response> is deprecated: use printeps_pepper_modules-srv:PepperGlbNav-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PepperGlbNav-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:success-val is deprecated.  Use printeps_pepper_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PepperGlbNav-response>) ostream)
  "Serializes a message object of type '<PepperGlbNav-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PepperGlbNav-response>) istream)
  "Deserializes a message object of type '<PepperGlbNav-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PepperGlbNav-response>)))
  "Returns string type for a service object of type '<PepperGlbNav-response>"
  "printeps_pepper_modules/PepperGlbNavResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperGlbNav-response)))
  "Returns string type for a service object of type 'PepperGlbNav-response"
  "printeps_pepper_modules/PepperGlbNavResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PepperGlbNav-response>)))
  "Returns md5sum for a message object of type '<PepperGlbNav-response>"
  "cfc42ebcb6ac1e961d822c446b9526a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PepperGlbNav-response)))
  "Returns md5sum for a message object of type 'PepperGlbNav-response"
  "cfc42ebcb6ac1e961d822c446b9526a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PepperGlbNav-response>)))
  "Returns full string definition for message of type '<PepperGlbNav-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PepperGlbNav-response)))
  "Returns full string definition for message of type 'PepperGlbNav-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PepperGlbNav-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PepperGlbNav-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PepperGlbNav-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PepperGlbNav)))
  'PepperGlbNav-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PepperGlbNav)))
  'PepperGlbNav-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperGlbNav)))
  "Returns string type for a service object of type '<PepperGlbNav>"
  "printeps_pepper_modules/PepperGlbNav")