; Auto-generated. Do not edit!


(cl:in-package sfm_navigation-msg)


;//! \htmlinclude Agent.msg.html

(cl:defclass <Agent> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (twist
    :reader twist
    :initarg :twist
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist)))
)

(cl:defclass Agent (<Agent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Agent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Agent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sfm_navigation-msg:<Agent> is deprecated: use sfm_navigation-msg:Agent instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Agent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sfm_navigation-msg:pose-val is deprecated.  Use sfm_navigation-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'twist-val :lambda-list '(m))
(cl:defmethod twist-val ((m <Agent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sfm_navigation-msg:twist-val is deprecated.  Use sfm_navigation-msg:twist instead.")
  (twist m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Agent>) ostream)
  "Serializes a message object of type '<Agent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'twist) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Agent>) istream)
  "Deserializes a message object of type '<Agent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'twist) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Agent>)))
  "Returns string type for a message object of type '<Agent>"
  "sfm_navigation/Agent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Agent)))
  "Returns string type for a message object of type 'Agent"
  "sfm_navigation/Agent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Agent>)))
  "Returns md5sum for a message object of type '<Agent>"
  "2eefe8acf5ee2495da2ec42491d29a94")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Agent)))
  "Returns md5sum for a message object of type 'Agent"
  "2eefe8acf5ee2495da2ec42491d29a94")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Agent>)))
  "Returns full string definition for message of type '<Agent>"
  (cl:format cl:nil "geometry_msgs/Pose2D  pose~%geometry_msgs/Twist twist~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Agent)))
  "Returns full string definition for message of type 'Agent"
  (cl:format cl:nil "geometry_msgs/Pose2D  pose~%geometry_msgs/Twist twist~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Agent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'twist))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Agent>))
  "Converts a ROS message object to a list"
  (cl:list 'Agent
    (cl:cons ':pose (pose msg))
    (cl:cons ':twist (twist msg))
))
