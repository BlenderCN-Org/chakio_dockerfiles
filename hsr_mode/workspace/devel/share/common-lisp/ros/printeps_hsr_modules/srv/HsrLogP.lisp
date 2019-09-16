; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrLogP-request.msg.html

(cl:defclass <HsrLogP-request> (roslisp-msg-protocol:ros-message)
  ((log
    :reader log
    :initarg :log
    :type cl:boolean
    :initform cl:nil)
   (PCD
    :reader PCD
    :initarg :PCD
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform ""))
)

(cl:defclass HsrLogP-request (<HsrLogP-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrLogP-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrLogP-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrLogP-request> is deprecated: use printeps_hsr_modules-srv:HsrLogP-request instead.")))

(cl:ensure-generic-function 'log-val :lambda-list '(m))
(cl:defmethod log-val ((m <HsrLogP-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:log-val is deprecated.  Use printeps_hsr_modules-srv:log instead.")
  (log m))

(cl:ensure-generic-function 'PCD-val :lambda-list '(m))
(cl:defmethod PCD-val ((m <HsrLogP-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:PCD-val is deprecated.  Use printeps_hsr_modules-srv:PCD instead.")
  (PCD m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <HsrLogP-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:mode-val is deprecated.  Use printeps_hsr_modules-srv:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrLogP-request>) ostream)
  "Serializes a message object of type '<HsrLogP-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'log) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'PCD) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrLogP-request>) istream)
  "Deserializes a message object of type '<HsrLogP-request>"
    (cl:setf (cl:slot-value msg 'log) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'PCD) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrLogP-request>)))
  "Returns string type for a service object of type '<HsrLogP-request>"
  "printeps_hsr_modules/HsrLogPRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLogP-request)))
  "Returns string type for a service object of type 'HsrLogP-request"
  "printeps_hsr_modules/HsrLogPRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrLogP-request>)))
  "Returns md5sum for a message object of type '<HsrLogP-request>"
  "3bab9c5fbe194c77b98025ec2f78083a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrLogP-request)))
  "Returns md5sum for a message object of type 'HsrLogP-request"
  "3bab9c5fbe194c77b98025ec2f78083a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrLogP-request>)))
  "Returns full string definition for message of type '<HsrLogP-request>"
  (cl:format cl:nil "~%~%bool log~%bool PCD~%string mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrLogP-request)))
  "Returns full string definition for message of type 'HsrLogP-request"
  (cl:format cl:nil "~%~%bool log~%bool PCD~%string mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrLogP-request>))
  (cl:+ 0
     1
     1
     4 (cl:length (cl:slot-value msg 'mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrLogP-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrLogP-request
    (cl:cons ':log (log msg))
    (cl:cons ':PCD (PCD msg))
    (cl:cons ':mode (mode msg))
))
;//! \htmlinclude HsrLogP-response.msg.html

(cl:defclass <HsrLogP-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrLogP-response (<HsrLogP-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrLogP-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrLogP-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrLogP-response> is deprecated: use printeps_hsr_modules-srv:HsrLogP-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrLogP-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrLogP-response>) ostream)
  "Serializes a message object of type '<HsrLogP-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrLogP-response>) istream)
  "Deserializes a message object of type '<HsrLogP-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrLogP-response>)))
  "Returns string type for a service object of type '<HsrLogP-response>"
  "printeps_hsr_modules/HsrLogPResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLogP-response)))
  "Returns string type for a service object of type 'HsrLogP-response"
  "printeps_hsr_modules/HsrLogPResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrLogP-response>)))
  "Returns md5sum for a message object of type '<HsrLogP-response>"
  "3bab9c5fbe194c77b98025ec2f78083a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrLogP-response)))
  "Returns md5sum for a message object of type 'HsrLogP-response"
  "3bab9c5fbe194c77b98025ec2f78083a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrLogP-response>)))
  "Returns full string definition for message of type '<HsrLogP-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrLogP-response)))
  "Returns full string definition for message of type 'HsrLogP-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrLogP-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrLogP-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrLogP-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrLogP)))
  'HsrLogP-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrLogP)))
  'HsrLogP-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLogP)))
  "Returns string type for a service object of type '<HsrLogP>"
  "printeps_hsr_modules/HsrLogP")