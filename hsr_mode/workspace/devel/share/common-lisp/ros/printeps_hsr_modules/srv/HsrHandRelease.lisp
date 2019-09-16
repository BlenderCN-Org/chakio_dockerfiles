; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrHandRelease-request.msg.html

(cl:defclass <HsrHandRelease-request> (roslisp-msg-protocol:ros-message)
  ((place_id
    :reader place_id
    :initarg :place_id
    :type cl:string
    :initform ""))
)

(cl:defclass HsrHandRelease-request (<HsrHandRelease-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrHandRelease-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrHandRelease-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrHandRelease-request> is deprecated: use printeps_hsr_modules-srv:HsrHandRelease-request instead.")))

(cl:ensure-generic-function 'place_id-val :lambda-list '(m))
(cl:defmethod place_id-val ((m <HsrHandRelease-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:place_id-val is deprecated.  Use printeps_hsr_modules-srv:place_id instead.")
  (place_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrHandRelease-request>) ostream)
  "Serializes a message object of type '<HsrHandRelease-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'place_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'place_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrHandRelease-request>) istream)
  "Deserializes a message object of type '<HsrHandRelease-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'place_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'place_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrHandRelease-request>)))
  "Returns string type for a service object of type '<HsrHandRelease-request>"
  "printeps_hsr_modules/HsrHandReleaseRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrHandRelease-request)))
  "Returns string type for a service object of type 'HsrHandRelease-request"
  "printeps_hsr_modules/HsrHandReleaseRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrHandRelease-request>)))
  "Returns md5sum for a message object of type '<HsrHandRelease-request>"
  "f676f5c1cafe9b38346686b35969df08")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrHandRelease-request)))
  "Returns md5sum for a message object of type 'HsrHandRelease-request"
  "f676f5c1cafe9b38346686b35969df08")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrHandRelease-request>)))
  "Returns full string definition for message of type '<HsrHandRelease-request>"
  (cl:format cl:nil "~%string place_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrHandRelease-request)))
  "Returns full string definition for message of type 'HsrHandRelease-request"
  (cl:format cl:nil "~%string place_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrHandRelease-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'place_id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrHandRelease-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrHandRelease-request
    (cl:cons ':place_id (place_id msg))
))
;//! \htmlinclude HsrHandRelease-response.msg.html

(cl:defclass <HsrHandRelease-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrHandRelease-response (<HsrHandRelease-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrHandRelease-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrHandRelease-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrHandRelease-response> is deprecated: use printeps_hsr_modules-srv:HsrHandRelease-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrHandRelease-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrHandRelease-response>) ostream)
  "Serializes a message object of type '<HsrHandRelease-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrHandRelease-response>) istream)
  "Deserializes a message object of type '<HsrHandRelease-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrHandRelease-response>)))
  "Returns string type for a service object of type '<HsrHandRelease-response>"
  "printeps_hsr_modules/HsrHandReleaseResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrHandRelease-response)))
  "Returns string type for a service object of type 'HsrHandRelease-response"
  "printeps_hsr_modules/HsrHandReleaseResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrHandRelease-response>)))
  "Returns md5sum for a message object of type '<HsrHandRelease-response>"
  "f676f5c1cafe9b38346686b35969df08")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrHandRelease-response)))
  "Returns md5sum for a message object of type 'HsrHandRelease-response"
  "f676f5c1cafe9b38346686b35969df08")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrHandRelease-response>)))
  "Returns full string definition for message of type '<HsrHandRelease-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrHandRelease-response)))
  "Returns full string definition for message of type 'HsrHandRelease-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrHandRelease-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrHandRelease-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrHandRelease-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrHandRelease)))
  'HsrHandRelease-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrHandRelease)))
  'HsrHandRelease-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrHandRelease)))
  "Returns string type for a service object of type '<HsrHandRelease>"
  "printeps_hsr_modules/HsrHandRelease")