; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-msg)


;//! \htmlinclude HsrTableset.msg.html

(cl:defclass <HsrTableset> (roslisp-msg-protocol:ros-message)
  ((table
    :reader table
    :initarg :table
    :type printeps_hsr_modules-msg:HsrObstacle
    :initform (cl:make-instance 'printeps_hsr_modules-msg:HsrObstacle))
   (chairs
    :reader chairs
    :initarg :chairs
    :type (cl:vector printeps_hsr_modules-msg:HsrObstacle)
   :initform (cl:make-array 0 :element-type 'printeps_hsr_modules-msg:HsrObstacle :initial-element (cl:make-instance 'printeps_hsr_modules-msg:HsrObstacle))))
)

(cl:defclass HsrTableset (<HsrTableset>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrTableset>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrTableset)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-msg:<HsrTableset> is deprecated: use printeps_hsr_modules-msg:HsrTableset instead.")))

(cl:ensure-generic-function 'table-val :lambda-list '(m))
(cl:defmethod table-val ((m <HsrTableset>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:table-val is deprecated.  Use printeps_hsr_modules-msg:table instead.")
  (table m))

(cl:ensure-generic-function 'chairs-val :lambda-list '(m))
(cl:defmethod chairs-val ((m <HsrTableset>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-msg:chairs-val is deprecated.  Use printeps_hsr_modules-msg:chairs instead.")
  (chairs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrTableset>) ostream)
  "Serializes a message object of type '<HsrTableset>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'table) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'chairs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'chairs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrTableset>) istream)
  "Deserializes a message object of type '<HsrTableset>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'table) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'chairs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'chairs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'printeps_hsr_modules-msg:HsrObstacle))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrTableset>)))
  "Returns string type for a message object of type '<HsrTableset>"
  "printeps_hsr_modules/HsrTableset")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrTableset)))
  "Returns string type for a message object of type 'HsrTableset"
  "printeps_hsr_modules/HsrTableset")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrTableset>)))
  "Returns md5sum for a message object of type '<HsrTableset>"
  "03ffed0b2ff00166a3c8658f40a325f8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrTableset)))
  "Returns md5sum for a message object of type 'HsrTableset"
  "03ffed0b2ff00166a3c8658f40a325f8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrTableset>)))
  "Returns full string definition for message of type '<HsrTableset>"
  (cl:format cl:nil "~%HsrObstacle     table~%HsrObstacle[]   chairs~%================================================================================~%MSG: printeps_hsr_modules/HsrObstacle~%geometry_msgs/Pose2D  pose~%float32 width~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrTableset)))
  "Returns full string definition for message of type 'HsrTableset"
  (cl:format cl:nil "~%HsrObstacle     table~%HsrObstacle[]   chairs~%================================================================================~%MSG: printeps_hsr_modules/HsrObstacle~%geometry_msgs/Pose2D  pose~%float32 width~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrTableset>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'table))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'chairs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrTableset>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrTableset
    (cl:cons ':table (table msg))
    (cl:cons ':chairs (chairs msg))
))
