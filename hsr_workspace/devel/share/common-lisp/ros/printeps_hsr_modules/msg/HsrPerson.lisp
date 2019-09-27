; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-msg)


;//! \htmlinclude HsrPerson.msg.html

(cl:defclass <HsrPerson> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (confidence
    :reader confidence
    :initarg :confidence
    :type cl:float
    :initform 0.0)
   (isHandUp
    :reader isHandUp
    :initarg :isHandUp
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrPerson (<HsrPerson>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPerson>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPerson)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-msg:<HsrPerson> is deprecated: use printeps_hsr_modules-msg:HsrPerson instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <HsrPerson>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:pose-val is deprecated.  Use printeps_hsr_modules-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'confidence-val :lambda-list '(m))
(cl:defmethod confidence-val ((m <HsrPerson>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:confidence-val is deprecated.  Use printeps_hsr_modules-msg:confidence instead.")
  (confidence m))

(cl:ensure-generic-function 'isHandUp-val :lambda-list '(m))
(cl:defmethod isHandUp-val ((m <HsrPerson>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:isHandUp-val is deprecated.  Use printeps_hsr_modules-msg:isHandUp instead.")
  (isHandUp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPerson>) ostream)
  "Serializes a message object of type '<HsrPerson>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'confidence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isHandUp) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPerson>) istream)
  "Deserializes a message object of type '<HsrPerson>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'confidence) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'isHandUp) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPerson>)))
  "Returns string type for a message object of type '<HsrPerson>"
  "printeps_hsr_modules/HsrPerson")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPerson)))
  "Returns string type for a message object of type 'HsrPerson"
  "printeps_hsr_modules/HsrPerson")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPerson>)))
  "Returns md5sum for a message object of type '<HsrPerson>"
  "37f248d54fedc2638eca426e3e06dea6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPerson)))
  "Returns md5sum for a message object of type 'HsrPerson"
  "37f248d54fedc2638eca426e3e06dea6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPerson>)))
  "Returns full string definition for message of type '<HsrPerson>"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%float32 confidence~%bool    isHandUp~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPerson)))
  "Returns full string definition for message of type 'HsrPerson"
  (cl:format cl:nil "~%geometry_msgs/Pose2D  pose~%float32 confidence~%bool    isHandUp~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPerson>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPerson>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPerson
    (cl:cons ':pose (pose msg))
    (cl:cons ':confidence (confidence msg))
    (cl:cons ':isHandUp (isHandUp msg))
))
