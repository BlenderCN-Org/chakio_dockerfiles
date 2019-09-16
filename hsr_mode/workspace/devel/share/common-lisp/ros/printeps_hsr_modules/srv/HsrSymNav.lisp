; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrSymNav-request.msg.html

(cl:defclass <HsrSymNav-request> (roslisp-msg-protocol:ros-message)
  ((destination
    :reader destination
    :initarg :destination
    :type cl:string
    :initform ""))
)

(cl:defclass HsrSymNav-request (<HsrSymNav-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrSymNav-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrSymNav-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrSymNav-request> is deprecated: use printeps_hsr_modules-srv:HsrSymNav-request instead.")))

(cl:ensure-generic-function 'destination-val :lambda-list '(m))
(cl:defmethod destination-val ((m <HsrSymNav-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:destination-val is deprecated.  Use printeps_hsr_modules-srv:destination instead.")
  (destination m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrSymNav-request>) ostream)
  "Serializes a message object of type '<HsrSymNav-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'destination))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'destination))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrSymNav-request>) istream)
  "Deserializes a message object of type '<HsrSymNav-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'destination) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'destination) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrSymNav-request>)))
  "Returns string type for a service object of type '<HsrSymNav-request>"
  "printeps_hsr_modules/HsrSymNavRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSymNav-request)))
  "Returns string type for a service object of type 'HsrSymNav-request"
  "printeps_hsr_modules/HsrSymNavRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrSymNav-request>)))
  "Returns md5sum for a message object of type '<HsrSymNav-request>"
  "a8b810758ea760dd74984f070e767d53")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrSymNav-request)))
  "Returns md5sum for a message object of type 'HsrSymNav-request"
  "a8b810758ea760dd74984f070e767d53")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrSymNav-request>)))
  "Returns full string definition for message of type '<HsrSymNav-request>"
  (cl:format cl:nil "~%string  destination~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrSymNav-request)))
  "Returns full string definition for message of type 'HsrSymNav-request"
  (cl:format cl:nil "~%string  destination~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrSymNav-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'destination))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrSymNav-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrSymNav-request
    (cl:cons ':destination (destination msg))
))
;//! \htmlinclude HsrSymNav-response.msg.html

(cl:defclass <HsrSymNav-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrSymNav-response (<HsrSymNav-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrSymNav-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrSymNav-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrSymNav-response> is deprecated: use printeps_hsr_modules-srv:HsrSymNav-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrSymNav-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrSymNav-response>) ostream)
  "Serializes a message object of type '<HsrSymNav-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrSymNav-response>) istream)
  "Deserializes a message object of type '<HsrSymNav-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrSymNav-response>)))
  "Returns string type for a service object of type '<HsrSymNav-response>"
  "printeps_hsr_modules/HsrSymNavResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSymNav-response)))
  "Returns string type for a service object of type 'HsrSymNav-response"
  "printeps_hsr_modules/HsrSymNavResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrSymNav-response>)))
  "Returns md5sum for a message object of type '<HsrSymNav-response>"
  "a8b810758ea760dd74984f070e767d53")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrSymNav-response)))
  "Returns md5sum for a message object of type 'HsrSymNav-response"
  "a8b810758ea760dd74984f070e767d53")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrSymNav-response>)))
  "Returns full string definition for message of type '<HsrSymNav-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrSymNav-response)))
  "Returns full string definition for message of type 'HsrSymNav-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrSymNav-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrSymNav-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrSymNav-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrSymNav)))
  'HsrSymNav-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrSymNav)))
  'HsrSymNav-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSymNav)))
  "Returns string type for a service object of type '<HsrSymNav>"
  "printeps_hsr_modules/HsrSymNav")