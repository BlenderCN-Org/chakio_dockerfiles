; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-msg)


;//! \htmlinclude HsrOpenpose.msg.html

(cl:defclass <HsrOpenpose> (roslisp-msg-protocol:ros-message)
  ((people
    :reader people
    :initarg :people
    :type (cl:vector printeps_hsr_modules-msg:HsrPerson)
   :initform (cl:make-array 0 :element-type 'printeps_hsr_modules-msg:HsrPerson :initial-element (cl:make-instance 'printeps_hsr_modules-msg:HsrPerson))))
)

(cl:defclass HsrOpenpose (<HsrOpenpose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrOpenpose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrOpenpose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-msg:<HsrOpenpose> is deprecated: use printeps_hsr_modules-msg:HsrOpenpose instead.")))

(cl:ensure-generic-function 'people-val :lambda-list '(m))
(cl:defmethod people-val ((m <HsrOpenpose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:people-val is deprecated.  Use printeps_hsr_modules-msg:people instead.")
  (people m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrOpenpose>) ostream)
  "Serializes a message object of type '<HsrOpenpose>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'people))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'people))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrOpenpose>) istream)
  "Deserializes a message object of type '<HsrOpenpose>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'people) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'people)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'printeps_hsr_modules-msg:HsrPerson))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrOpenpose>)))
  "Returns string type for a message object of type '<HsrOpenpose>"
  "printeps_hsr_modules/HsrOpenpose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrOpenpose)))
  "Returns string type for a message object of type 'HsrOpenpose"
  "printeps_hsr_modules/HsrOpenpose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrOpenpose>)))
  "Returns md5sum for a message object of type '<HsrOpenpose>"
  "a952aca51b6ba06cdce810f6825d8c74")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrOpenpose)))
  "Returns md5sum for a message object of type 'HsrOpenpose"
  "a952aca51b6ba06cdce810f6825d8c74")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrOpenpose>)))
  "Returns full string definition for message of type '<HsrOpenpose>"
  (cl:format cl:nil "HsrPerson[] people~%================================================================================~%MSG: printeps_hsr_modules/HsrPerson~%~%geometry_msgs/Pose2D  pose~%float32 confidence~%bool    isHandUp~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrOpenpose)))
  "Returns full string definition for message of type 'HsrOpenpose"
  (cl:format cl:nil "HsrPerson[] people~%================================================================================~%MSG: printeps_hsr_modules/HsrPerson~%~%geometry_msgs/Pose2D  pose~%float32 confidence~%bool    isHandUp~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrOpenpose>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'people) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrOpenpose>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrOpenpose
    (cl:cons ':people (people msg))
))
