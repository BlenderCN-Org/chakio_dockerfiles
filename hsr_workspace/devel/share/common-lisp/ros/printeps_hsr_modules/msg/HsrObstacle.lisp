; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-msg)


;//! \htmlinclude HsrObstacle.msg.html

(cl:defclass <HsrObstacle> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (width
    :reader width
    :initarg :width
    :type cl:float
    :initform 0.0))
)

(cl:defclass HsrObstacle (<HsrObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-msg:<HsrObstacle> is deprecated: use printeps_hsr_modules-msg:HsrObstacle instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <HsrObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:pose-val is deprecated.  Use printeps_hsr_modules-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <HsrObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:width-val is deprecated.  Use printeps_hsr_modules-msg:width instead.")
  (width m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrObstacle>) ostream)
  "Serializes a message object of type '<HsrObstacle>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrObstacle>) istream)
  "Deserializes a message object of type '<HsrObstacle>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'width) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrObstacle>)))
  "Returns string type for a message object of type '<HsrObstacle>"
  "printeps_hsr_modules/HsrObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrObstacle)))
  "Returns string type for a message object of type 'HsrObstacle"
  "printeps_hsr_modules/HsrObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrObstacle>)))
  "Returns md5sum for a message object of type '<HsrObstacle>"
  "1a9ed5a6d496973b5f1cb4ac9bbcb30a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrObstacle)))
  "Returns md5sum for a message object of type 'HsrObstacle"
  "1a9ed5a6d496973b5f1cb4ac9bbcb30a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrObstacle>)))
  "Returns full string definition for message of type '<HsrObstacle>"
  (cl:format cl:nil "geometry_msgs/Pose2D  pose~%float32 width~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrObstacle)))
  "Returns full string definition for message of type 'HsrObstacle"
  (cl:format cl:nil "geometry_msgs/Pose2D  pose~%float32 width~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrObstacle>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrObstacle
    (cl:cons ':pose (pose msg))
    (cl:cons ':width (width msg))
))
