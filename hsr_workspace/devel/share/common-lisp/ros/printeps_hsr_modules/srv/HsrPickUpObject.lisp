; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrPickUpObject-request.msg.html

(cl:defclass <HsrPickUpObject-request> (roslisp-msg-protocol:ros-message)
  ((object_id
    :reader object_id
    :initarg :object_id
    :type cl:string
    :initform ""))
)

(cl:defclass HsrPickUpObject-request (<HsrPickUpObject-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPickUpObject-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPickUpObject-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPickUpObject-request> is deprecated: use printeps_hsr_modules-srv:HsrPickUpObject-request instead.")))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <HsrPickUpObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:object_id-val is deprecated.  Use printeps_hsr_modules-srv:object_id instead.")
  (object_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPickUpObject-request>) ostream)
  "Serializes a message object of type '<HsrPickUpObject-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPickUpObject-request>) istream)
  "Deserializes a message object of type '<HsrPickUpObject-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPickUpObject-request>)))
  "Returns string type for a service object of type '<HsrPickUpObject-request>"
  "printeps_hsr_modules/HsrPickUpObjectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickUpObject-request)))
  "Returns string type for a service object of type 'HsrPickUpObject-request"
  "printeps_hsr_modules/HsrPickUpObjectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPickUpObject-request>)))
  "Returns md5sum for a message object of type '<HsrPickUpObject-request>"
  "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPickUpObject-request)))
  "Returns md5sum for a message object of type 'HsrPickUpObject-request"
  "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPickUpObject-request>)))
  "Returns full string definition for message of type '<HsrPickUpObject-request>"
  (cl:format cl:nil "~%string object_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPickUpObject-request)))
  "Returns full string definition for message of type 'HsrPickUpObject-request"
  (cl:format cl:nil "~%string object_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPickUpObject-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'object_id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPickUpObject-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPickUpObject-request
    (cl:cons ':object_id (object_id msg))
))
;//! \htmlinclude HsrPickUpObject-response.msg.html

(cl:defclass <HsrPickUpObject-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrPickUpObject-response (<HsrPickUpObject-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPickUpObject-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPickUpObject-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPickUpObject-response> is deprecated: use printeps_hsr_modules-srv:HsrPickUpObject-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrPickUpObject-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPickUpObject-response>) ostream)
  "Serializes a message object of type '<HsrPickUpObject-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPickUpObject-response>) istream)
  "Deserializes a message object of type '<HsrPickUpObject-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPickUpObject-response>)))
  "Returns string type for a service object of type '<HsrPickUpObject-response>"
  "printeps_hsr_modules/HsrPickUpObjectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickUpObject-response)))
  "Returns string type for a service object of type 'HsrPickUpObject-response"
  "printeps_hsr_modules/HsrPickUpObjectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPickUpObject-response>)))
  "Returns md5sum for a message object of type '<HsrPickUpObject-response>"
  "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPickUpObject-response)))
  "Returns md5sum for a message object of type 'HsrPickUpObject-response"
  "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPickUpObject-response>)))
  "Returns full string definition for message of type '<HsrPickUpObject-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPickUpObject-response)))
  "Returns full string definition for message of type 'HsrPickUpObject-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPickUpObject-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPickUpObject-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPickUpObject-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrPickUpObject)))
  'HsrPickUpObject-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrPickUpObject)))
  'HsrPickUpObject-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickUpObject)))
  "Returns string type for a service object of type '<HsrPickUpObject>"
  "printeps_hsr_modules/HsrPickUpObject")