; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrCarry2017-request.msg.html

(cl:defclass <HsrCarry2017-request> (roslisp-msg-protocol:ros-message)
  ((pose_B
    :reader pose_B
    :initarg :pose_B
    :type cl:string
    :initform "")
   (pose_D
    :reader pose_D
    :initarg :pose_D
    :type cl:string
    :initform ""))
)

(cl:defclass HsrCarry2017-request (<HsrCarry2017-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrCarry2017-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrCarry2017-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrCarry2017-request> is deprecated: use printeps_hsr_modules-srv:HsrCarry2017-request instead.")))

(cl:ensure-generic-function 'pose_B-val :lambda-list '(m))
(cl:defmethod pose_B-val ((m <HsrCarry2017-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose_B-val is deprecated.  Use printeps_hsr_modules-srv:pose_B instead.")
  (pose_B m))

(cl:ensure-generic-function 'pose_D-val :lambda-list '(m))
(cl:defmethod pose_D-val ((m <HsrCarry2017-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:pose_D-val is deprecated.  Use printeps_hsr_modules-srv:pose_D instead.")
  (pose_D m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrCarry2017-request>) ostream)
  "Serializes a message object of type '<HsrCarry2017-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'pose_B))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'pose_B))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'pose_D))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'pose_D))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrCarry2017-request>) istream)
  "Deserializes a message object of type '<HsrCarry2017-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pose_B) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'pose_B) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pose_D) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'pose_D) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrCarry2017-request>)))
  "Returns string type for a service object of type '<HsrCarry2017-request>"
  "printeps_hsr_modules/HsrCarry2017Request")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrCarry2017-request)))
  "Returns string type for a service object of type 'HsrCarry2017-request"
  "printeps_hsr_modules/HsrCarry2017Request")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrCarry2017-request>)))
  "Returns md5sum for a message object of type '<HsrCarry2017-request>"
  "2dce38ab0b77cebc740f59d7c59f16d4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrCarry2017-request)))
  "Returns md5sum for a message object of type 'HsrCarry2017-request"
  "2dce38ab0b77cebc740f59d7c59f16d4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrCarry2017-request>)))
  "Returns full string definition for message of type '<HsrCarry2017-request>"
  (cl:format cl:nil "~%string  pose_B~%string  pose_D~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrCarry2017-request)))
  "Returns full string definition for message of type 'HsrCarry2017-request"
  (cl:format cl:nil "~%string  pose_B~%string  pose_D~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrCarry2017-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'pose_B))
     4 (cl:length (cl:slot-value msg 'pose_D))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrCarry2017-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrCarry2017-request
    (cl:cons ':pose_B (pose_B msg))
    (cl:cons ':pose_D (pose_D msg))
))
;//! \htmlinclude HsrCarry2017-response.msg.html

(cl:defclass <HsrCarry2017-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrCarry2017-response (<HsrCarry2017-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrCarry2017-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrCarry2017-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrCarry2017-response> is deprecated: use printeps_hsr_modules-srv:HsrCarry2017-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrCarry2017-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrCarry2017-response>) ostream)
  "Serializes a message object of type '<HsrCarry2017-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrCarry2017-response>) istream)
  "Deserializes a message object of type '<HsrCarry2017-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrCarry2017-response>)))
  "Returns string type for a service object of type '<HsrCarry2017-response>"
  "printeps_hsr_modules/HsrCarry2017Response")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrCarry2017-response)))
  "Returns string type for a service object of type 'HsrCarry2017-response"
  "printeps_hsr_modules/HsrCarry2017Response")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrCarry2017-response>)))
  "Returns md5sum for a message object of type '<HsrCarry2017-response>"
  "2dce38ab0b77cebc740f59d7c59f16d4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrCarry2017-response)))
  "Returns md5sum for a message object of type 'HsrCarry2017-response"
  "2dce38ab0b77cebc740f59d7c59f16d4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrCarry2017-response>)))
  "Returns full string definition for message of type '<HsrCarry2017-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrCarry2017-response)))
  "Returns full string definition for message of type 'HsrCarry2017-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrCarry2017-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrCarry2017-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrCarry2017-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrCarry2017)))
  'HsrCarry2017-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrCarry2017)))
  'HsrCarry2017-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrCarry2017)))
  "Returns string type for a service object of type '<HsrCarry2017>"
  "printeps_hsr_modules/HsrCarry2017")