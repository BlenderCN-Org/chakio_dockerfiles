; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrSay-request.msg.html

(cl:defclass <HsrSay-request> (roslisp-msg-protocol:ros-message)
  ((words
    :reader words
    :initarg :words
    :type cl:string
    :initform ""))
)

(cl:defclass HsrSay-request (<HsrSay-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrSay-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrSay-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrSay-request> is deprecated: use printeps_hsr_modules-srv:HsrSay-request instead.")))

(cl:ensure-generic-function 'words-val :lambda-list '(m))
(cl:defmethod words-val ((m <HsrSay-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:words-val is deprecated.  Use printeps_hsr_modules-srv:words instead.")
  (words m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrSay-request>) ostream)
  "Serializes a message object of type '<HsrSay-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'words))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'words))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrSay-request>) istream)
  "Deserializes a message object of type '<HsrSay-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'words) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'words) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrSay-request>)))
  "Returns string type for a service object of type '<HsrSay-request>"
  "printeps_hsr_modules/HsrSayRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSay-request)))
  "Returns string type for a service object of type 'HsrSay-request"
  "printeps_hsr_modules/HsrSayRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrSay-request>)))
  "Returns md5sum for a message object of type '<HsrSay-request>"
  "e42289734831209d7d09ddbae327bbad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrSay-request)))
  "Returns md5sum for a message object of type 'HsrSay-request"
  "e42289734831209d7d09ddbae327bbad")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrSay-request>)))
  "Returns full string definition for message of type '<HsrSay-request>"
  (cl:format cl:nil "~%string words~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrSay-request)))
  "Returns full string definition for message of type 'HsrSay-request"
  (cl:format cl:nil "~%string words~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrSay-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'words))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrSay-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrSay-request
    (cl:cons ':words (words msg))
))
;//! \htmlinclude HsrSay-response.msg.html

(cl:defclass <HsrSay-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrSay-response (<HsrSay-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrSay-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrSay-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrSay-response> is deprecated: use printeps_hsr_modules-srv:HsrSay-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrSay-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrSay-response>) ostream)
  "Serializes a message object of type '<HsrSay-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrSay-response>) istream)
  "Deserializes a message object of type '<HsrSay-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrSay-response>)))
  "Returns string type for a service object of type '<HsrSay-response>"
  "printeps_hsr_modules/HsrSayResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSay-response)))
  "Returns string type for a service object of type 'HsrSay-response"
  "printeps_hsr_modules/HsrSayResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrSay-response>)))
  "Returns md5sum for a message object of type '<HsrSay-response>"
  "e42289734831209d7d09ddbae327bbad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrSay-response)))
  "Returns md5sum for a message object of type 'HsrSay-response"
  "e42289734831209d7d09ddbae327bbad")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrSay-response>)))
  "Returns full string definition for message of type '<HsrSay-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrSay-response)))
  "Returns full string definition for message of type 'HsrSay-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrSay-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrSay-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrSay-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrSay)))
  'HsrSay-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrSay)))
  'HsrSay-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrSay)))
  "Returns string type for a service object of type '<HsrSay>"
  "printeps_hsr_modules/HsrSay")