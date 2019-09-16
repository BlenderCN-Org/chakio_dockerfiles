; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrMMNav-request.msg.html

(cl:defclass <HsrMMNav-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (voiceImportance
    :reader voiceImportance
    :initarg :voiceImportance
    :type std_msgs-msg:Float64
    :initform (cl:make-instance 'std_msgs-msg:Float64)))
)

(cl:defclass HsrMMNav-request (<HsrMMNav-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrMMNav-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrMMNav-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrMMNav-request> is deprecated: use printeps_hsr_modules-srv:HsrMMNav-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <HsrMMNav-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose-val is deprecated.  Use printeps_hsr_modules-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'voiceImportance-val :lambda-list '(m))
(cl:defmethod voiceImportance-val ((m <HsrMMNav-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:voiceImportance-val is deprecated.  Use printeps_hsr_modules-srv:voiceImportance instead.")
  (voiceImportance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrMMNav-request>) ostream)
  "Serializes a message object of type '<HsrMMNav-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'voiceImportance) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrMMNav-request>) istream)
  "Deserializes a message object of type '<HsrMMNav-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'voiceImportance) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrMMNav-request>)))
  "Returns string type for a service object of type '<HsrMMNav-request>"
  "printeps_hsr_modules/HsrMMNavRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrMMNav-request)))
  "Returns string type for a service object of type 'HsrMMNav-request"
  "printeps_hsr_modules/HsrMMNavRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrMMNav-request>)))
  "Returns md5sum for a message object of type '<HsrMMNav-request>"
  "6c1ad0746ba7a1849f6940921095b943")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrMMNav-request)))
  "Returns md5sum for a message object of type 'HsrMMNav-request"
  "6c1ad0746ba7a1849f6940921095b943")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrMMNav-request>)))
  "Returns full string definition for message of type '<HsrMMNav-request>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D    pose~%std_msgs/Float64        voiceImportance~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: std_msgs/Float64~%float64 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrMMNav-request)))
  "Returns full string definition for message of type 'HsrMMNav-request"
  (cl:format cl:nil "~%geometry_msgs/Pose2D    pose~%std_msgs/Float64        voiceImportance~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: std_msgs/Float64~%float64 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrMMNav-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'voiceImportance))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrMMNav-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrMMNav-request
    (cl:cons ':pose (pose msg))
    (cl:cons ':voiceImportance (voiceImportance msg))
))
;//! \htmlinclude HsrMMNav-response.msg.html

(cl:defclass <HsrMMNav-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrMMNav-response (<HsrMMNav-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrMMNav-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrMMNav-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrMMNav-response> is deprecated: use printeps_hsr_modules-srv:HsrMMNav-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrMMNav-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrMMNav-response>) ostream)
  "Serializes a message object of type '<HsrMMNav-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrMMNav-response>) istream)
  "Deserializes a message object of type '<HsrMMNav-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrMMNav-response>)))
  "Returns string type for a service object of type '<HsrMMNav-response>"
  "printeps_hsr_modules/HsrMMNavResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrMMNav-response)))
  "Returns string type for a service object of type 'HsrMMNav-response"
  "printeps_hsr_modules/HsrMMNavResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrMMNav-response>)))
  "Returns md5sum for a message object of type '<HsrMMNav-response>"
  "6c1ad0746ba7a1849f6940921095b943")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrMMNav-response)))
  "Returns md5sum for a message object of type 'HsrMMNav-response"
  "6c1ad0746ba7a1849f6940921095b943")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrMMNav-response>)))
  "Returns full string definition for message of type '<HsrMMNav-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrMMNav-response)))
  "Returns full string definition for message of type 'HsrMMNav-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrMMNav-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrMMNav-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrMMNav-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrMMNav)))
  'HsrMMNav-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrMMNav)))
  'HsrMMNav-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrMMNav)))
  "Returns string type for a service object of type '<HsrMMNav>"
  "printeps_hsr_modules/HsrMMNav")