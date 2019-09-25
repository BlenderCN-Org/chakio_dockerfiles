; Auto-generated. Do not edit!


(cl:in-package printeps_pepper_modules-srv)


;//! \htmlinclude PepperSpeak-request.msg.html

(cl:defclass <PepperSpeak-request> (roslisp-msg-protocol:ros-message)
  ((ip_address
    :reader ip_address
    :initarg :ip_address
    :type cl:string
    :initform "")
   (contents
    :reader contents
    :initarg :contents
    :type cl:string
    :initform ""))
)

(cl:defclass PepperSpeak-request (<PepperSpeak-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PepperSpeak-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PepperSpeak-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PepperSpeak-request> is deprecated: use printeps_pepper_modules-srv:PepperSpeak-request instead.")))

(cl:ensure-generic-function 'ip_address-val :lambda-list '(m))
(cl:defmethod ip_address-val ((m <PepperSpeak-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:ip_address-val is deprecated.  Use printeps_pepper_modules-srv:ip_address instead.")
  (ip_address m))

(cl:ensure-generic-function 'contents-val :lambda-list '(m))
(cl:defmethod contents-val ((m <PepperSpeak-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:contents-val is deprecated.  Use printeps_pepper_modules-srv:contents instead.")
  (contents m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PepperSpeak-request>) ostream)
  "Serializes a message object of type '<PepperSpeak-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'ip_address))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'ip_address))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'contents))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'contents))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PepperSpeak-request>) istream)
  "Deserializes a message object of type '<PepperSpeak-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ip_address) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'ip_address) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'contents) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'contents) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PepperSpeak-request>)))
  "Returns string type for a service object of type '<PepperSpeak-request>"
  "printeps_pepper_modules/PepperSpeakRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperSpeak-request)))
  "Returns string type for a service object of type 'PepperSpeak-request"
  "printeps_pepper_modules/PepperSpeakRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PepperSpeak-request>)))
  "Returns md5sum for a message object of type '<PepperSpeak-request>"
  "4a951ed513207e655699b507ebeda279")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PepperSpeak-request)))
  "Returns md5sum for a message object of type 'PepperSpeak-request"
  "4a951ed513207e655699b507ebeda279")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PepperSpeak-request>)))
  "Returns full string definition for message of type '<PepperSpeak-request>"
  (cl:format cl:nil "~%~%~%string ip_address~%string contents~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PepperSpeak-request)))
  "Returns full string definition for message of type 'PepperSpeak-request"
  (cl:format cl:nil "~%~%~%string ip_address~%string contents~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PepperSpeak-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'ip_address))
     4 (cl:length (cl:slot-value msg 'contents))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PepperSpeak-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PepperSpeak-request
    (cl:cons ':ip_address (ip_address msg))
    (cl:cons ':contents (contents msg))
))
;//! \htmlinclude PepperSpeak-response.msg.html

(cl:defclass <PepperSpeak-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass PepperSpeak-response (<PepperSpeak-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PepperSpeak-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PepperSpeak-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_pepper_modules-srv:<PepperSpeak-response> is deprecated: use printeps_pepper_modules-srv:PepperSpeak-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PepperSpeak-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_pepper_modules-srv:success-val is deprecated.  Use printeps_pepper_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PepperSpeak-response>) ostream)
  "Serializes a message object of type '<PepperSpeak-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PepperSpeak-response>) istream)
  "Deserializes a message object of type '<PepperSpeak-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PepperSpeak-response>)))
  "Returns string type for a service object of type '<PepperSpeak-response>"
  "printeps_pepper_modules/PepperSpeakResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperSpeak-response)))
  "Returns string type for a service object of type 'PepperSpeak-response"
  "printeps_pepper_modules/PepperSpeakResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PepperSpeak-response>)))
  "Returns md5sum for a message object of type '<PepperSpeak-response>"
  "4a951ed513207e655699b507ebeda279")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PepperSpeak-response)))
  "Returns md5sum for a message object of type 'PepperSpeak-response"
  "4a951ed513207e655699b507ebeda279")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PepperSpeak-response>)))
  "Returns full string definition for message of type '<PepperSpeak-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PepperSpeak-response)))
  "Returns full string definition for message of type 'PepperSpeak-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PepperSpeak-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PepperSpeak-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PepperSpeak-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PepperSpeak)))
  'PepperSpeak-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PepperSpeak)))
  'PepperSpeak-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PepperSpeak)))
  "Returns string type for a service object of type '<PepperSpeak>"
  "printeps_pepper_modules/PepperSpeak")