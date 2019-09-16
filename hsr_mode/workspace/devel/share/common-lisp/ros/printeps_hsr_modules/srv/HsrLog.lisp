; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrLog-request.msg.html

(cl:defclass <HsrLog-request> (roslisp-msg-protocol:ros-message)
  ((log
    :reader log
    :initarg :log
    :type cl:boolean
    :initform cl:nil)
   (IMU
    :reader IMU
    :initarg :IMU
    :type cl:boolean
    :initform cl:nil)
   (LRF
    :reader LRF
    :initarg :LRF
    :type cl:boolean
    :initform cl:nil)
   (Wrist
    :reader Wrist
    :initarg :Wrist
    :type cl:boolean
    :initform cl:nil)
   (Joint
    :reader Joint
    :initarg :Joint
    :type cl:boolean
    :initform cl:nil)
   (TF
    :reader TF
    :initarg :TF
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform ""))
)

(cl:defclass HsrLog-request (<HsrLog-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrLog-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrLog-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrLog-request> is deprecated: use printeps_hsr_modules-srv:HsrLog-request instead.")))

(cl:ensure-generic-function 'log-val :lambda-list '(m))
(cl:defmethod log-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:log-val is deprecated.  Use printeps_hsr_modules-srv:log instead.")
  (log m))

(cl:ensure-generic-function 'IMU-val :lambda-list '(m))
(cl:defmethod IMU-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:IMU-val is deprecated.  Use printeps_hsr_modules-srv:IMU instead.")
  (IMU m))

(cl:ensure-generic-function 'LRF-val :lambda-list '(m))
(cl:defmethod LRF-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:LRF-val is deprecated.  Use printeps_hsr_modules-srv:LRF instead.")
  (LRF m))

(cl:ensure-generic-function 'Wrist-val :lambda-list '(m))
(cl:defmethod Wrist-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:Wrist-val is deprecated.  Use printeps_hsr_modules-srv:Wrist instead.")
  (Wrist m))

(cl:ensure-generic-function 'Joint-val :lambda-list '(m))
(cl:defmethod Joint-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:Joint-val is deprecated.  Use printeps_hsr_modules-srv:Joint instead.")
  (Joint m))

(cl:ensure-generic-function 'TF-val :lambda-list '(m))
(cl:defmethod TF-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:TF-val is deprecated.  Use printeps_hsr_modules-srv:TF instead.")
  (TF m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <HsrLog-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:mode-val is deprecated.  Use printeps_hsr_modules-srv:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrLog-request>) ostream)
  "Serializes a message object of type '<HsrLog-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'log) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'IMU) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'LRF) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Wrist) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Joint) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'TF) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrLog-request>) istream)
  "Deserializes a message object of type '<HsrLog-request>"
    (cl:setf (cl:slot-value msg 'log) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'IMU) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'LRF) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Wrist) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Joint) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'TF) (cl:not (cl:zerop (cl:read-byte istream))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrLog-request>)))
  "Returns string type for a service object of type '<HsrLog-request>"
  "printeps_hsr_modules/HsrLogRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLog-request)))
  "Returns string type for a service object of type 'HsrLog-request"
  "printeps_hsr_modules/HsrLogRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrLog-request>)))
  "Returns md5sum for a message object of type '<HsrLog-request>"
  "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrLog-request)))
  "Returns md5sum for a message object of type 'HsrLog-request"
  "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrLog-request>)))
  "Returns full string definition for message of type '<HsrLog-request>"
  (cl:format cl:nil "~%~%bool log~%bool IMU~%bool LRF~%bool Wrist~%bool Joint~%bool TF~%string mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrLog-request)))
  "Returns full string definition for message of type 'HsrLog-request"
  (cl:format cl:nil "~%~%bool log~%bool IMU~%bool LRF~%bool Wrist~%bool Joint~%bool TF~%string mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrLog-request>))
  (cl:+ 0
     1
     1
     1
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrLog-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrLog-request
    (cl:cons ':log (log msg))
    (cl:cons ':IMU (IMU msg))
    (cl:cons ':LRF (LRF msg))
    (cl:cons ':Wrist (Wrist msg))
    (cl:cons ':Joint (Joint msg))
    (cl:cons ':TF (TF msg))
    (cl:cons ':mode (mode msg))
))
;//! \htmlinclude HsrLog-response.msg.html

(cl:defclass <HsrLog-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrLog-response (<HsrLog-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrLog-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrLog-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrLog-response> is deprecated: use printeps_hsr_modules-srv:HsrLog-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrLog-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrLog-response>) ostream)
  "Serializes a message object of type '<HsrLog-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrLog-response>) istream)
  "Deserializes a message object of type '<HsrLog-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrLog-response>)))
  "Returns string type for a service object of type '<HsrLog-response>"
  "printeps_hsr_modules/HsrLogResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLog-response)))
  "Returns string type for a service object of type 'HsrLog-response"
  "printeps_hsr_modules/HsrLogResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrLog-response>)))
  "Returns md5sum for a message object of type '<HsrLog-response>"
  "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrLog-response)))
  "Returns md5sum for a message object of type 'HsrLog-response"
  "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrLog-response>)))
  "Returns full string definition for message of type '<HsrLog-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrLog-response)))
  "Returns full string definition for message of type 'HsrLog-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrLog-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrLog-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrLog-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrLog)))
  'HsrLog-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrLog)))
  'HsrLog-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrLog)))
  "Returns string type for a service object of type '<HsrLog>"
  "printeps_hsr_modules/HsrLog")