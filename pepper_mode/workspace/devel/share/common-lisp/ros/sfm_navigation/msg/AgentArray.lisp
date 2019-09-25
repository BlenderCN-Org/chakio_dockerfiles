; Auto-generated. Do not edit!


(cl:in-package sfm_navigation-msg)


;//! \htmlinclude AgentArray.msg.html

(cl:defclass <AgentArray> (roslisp-msg-protocol:ros-message)
  ((agents
    :reader agents
    :initarg :agents
    :type (cl:vector sfm_navigation-msg:Agent)
   :initform (cl:make-array 0 :element-type 'sfm_navigation-msg:Agent :initial-element (cl:make-instance 'sfm_navigation-msg:Agent))))
)

(cl:defclass AgentArray (<AgentArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AgentArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AgentArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sfm_navigation-msg:<AgentArray> is deprecated: use sfm_navigation-msg:AgentArray instead.")))

(cl:ensure-generic-function 'agents-val :lambda-list '(m))
(cl:defmethod agents-val ((m <AgentArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sfm_navigation-msg:agents-val is deprecated.  Use sfm_navigation-msg:agents instead.")
  (agents m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AgentArray>) ostream)
  "Serializes a message object of type '<AgentArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'agents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'agents))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AgentArray>) istream)
  "Deserializes a message object of type '<AgentArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'agents) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'agents)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'sfm_navigation-msg:Agent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AgentArray>)))
  "Returns string type for a message object of type '<AgentArray>"
  "sfm_navigation/AgentArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AgentArray)))
  "Returns string type for a message object of type 'AgentArray"
  "sfm_navigation/AgentArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AgentArray>)))
  "Returns md5sum for a message object of type '<AgentArray>"
  "a42d8b787a4b74273a3d435730aaf001")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AgentArray)))
  "Returns md5sum for a message object of type 'AgentArray"
  "a42d8b787a4b74273a3d435730aaf001")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AgentArray>)))
  "Returns full string definition for message of type '<AgentArray>"
  (cl:format cl:nil "sfm_navigation/Agent[] agents~%================================================================================~%MSG: sfm_navigation/Agent~%geometry_msgs/Pose2D  pose~%geometry_msgs/Twist twist~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AgentArray)))
  "Returns full string definition for message of type 'AgentArray"
  (cl:format cl:nil "sfm_navigation/Agent[] agents~%================================================================================~%MSG: sfm_navigation/Agent~%geometry_msgs/Pose2D  pose~%geometry_msgs/Twist twist~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AgentArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'agents) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AgentArray>))
  "Converts a ROS message object to a list"
  (cl:list 'AgentArray
    (cl:cons ':agents (agents msg))
))
