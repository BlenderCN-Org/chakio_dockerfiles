; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrPickAndPlace-request.msg.html

(cl:defclass <HsrPickAndPlace-request> (roslisp-msg-protocol:ros-message)
  ((object_place
    :reader object_place
    :initarg :object_place
    :type cl:string
    :initform "")
   (destination
    :reader destination
    :initarg :destination
    :type cl:string
    :initform "")
   (object_name
    :reader object_name
    :initarg :object_name
    :type cl:string
    :initform ""))
)

(cl:defclass HsrPickAndPlace-request (<HsrPickAndPlace-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPickAndPlace-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPickAndPlace-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPickAndPlace-request> is deprecated: use printeps_hsr_modules-srv:HsrPickAndPlace-request instead.")))

(cl:ensure-generic-function 'object_place-val :lambda-list '(m))
(cl:defmethod object_place-val ((m <HsrPickAndPlace-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:object_place-val is deprecated.  Use printeps_hsr_modules-srv:object_place instead.")
  (object_place m))

(cl:ensure-generic-function 'destination-val :lambda-list '(m))
(cl:defmethod destination-val ((m <HsrPickAndPlace-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:destination-val is deprecated.  Use printeps_hsr_modules-srv:destination instead.")
  (destination m))

(cl:ensure-generic-function 'object_name-val :lambda-list '(m))
(cl:defmethod object_name-val ((m <HsrPickAndPlace-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:object_name-val is deprecated.  Use printeps_hsr_modules-srv:object_name instead.")
  (object_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPickAndPlace-request>) ostream)
  "Serializes a message object of type '<HsrPickAndPlace-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_place))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_place))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'destination))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'destination))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPickAndPlace-request>) istream)
  "Deserializes a message object of type '<HsrPickAndPlace-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_place) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object_place) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'destination) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'destination) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPickAndPlace-request>)))
  "Returns string type for a service object of type '<HsrPickAndPlace-request>"
  "printeps_hsr_modules/HsrPickAndPlaceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickAndPlace-request)))
  "Returns string type for a service object of type 'HsrPickAndPlace-request"
  "printeps_hsr_modules/HsrPickAndPlaceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPickAndPlace-request>)))
  "Returns md5sum for a message object of type '<HsrPickAndPlace-request>"
  "ad863b503ce673c2257d5090716e8cbd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPickAndPlace-request)))
  "Returns md5sum for a message object of type 'HsrPickAndPlace-request"
  "ad863b503ce673c2257d5090716e8cbd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPickAndPlace-request>)))
  "Returns full string definition for message of type '<HsrPickAndPlace-request>"
  (cl:format cl:nil "~%string                object_place~%string                destination~%string                object_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPickAndPlace-request)))
  "Returns full string definition for message of type 'HsrPickAndPlace-request"
  (cl:format cl:nil "~%string                object_place~%string                destination~%string                object_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPickAndPlace-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'object_place))
     4 (cl:length (cl:slot-value msg 'destination))
     4 (cl:length (cl:slot-value msg 'object_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPickAndPlace-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPickAndPlace-request
    (cl:cons ':object_place (object_place msg))
    (cl:cons ':destination (destination msg))
    (cl:cons ':object_name (object_name msg))
))
;//! \htmlinclude HsrPickAndPlace-response.msg.html

(cl:defclass <HsrPickAndPlace-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrPickAndPlace-response (<HsrPickAndPlace-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPickAndPlace-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPickAndPlace-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPickAndPlace-response> is deprecated: use printeps_hsr_modules-srv:HsrPickAndPlace-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrPickAndPlace-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPickAndPlace-response>) ostream)
  "Serializes a message object of type '<HsrPickAndPlace-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPickAndPlace-response>) istream)
  "Deserializes a message object of type '<HsrPickAndPlace-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPickAndPlace-response>)))
  "Returns string type for a service object of type '<HsrPickAndPlace-response>"
  "printeps_hsr_modules/HsrPickAndPlaceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickAndPlace-response)))
  "Returns string type for a service object of type 'HsrPickAndPlace-response"
  "printeps_hsr_modules/HsrPickAndPlaceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPickAndPlace-response>)))
  "Returns md5sum for a message object of type '<HsrPickAndPlace-response>"
  "ad863b503ce673c2257d5090716e8cbd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPickAndPlace-response)))
  "Returns md5sum for a message object of type 'HsrPickAndPlace-response"
  "ad863b503ce673c2257d5090716e8cbd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPickAndPlace-response>)))
  "Returns full string definition for message of type '<HsrPickAndPlace-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPickAndPlace-response)))
  "Returns full string definition for message of type 'HsrPickAndPlace-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPickAndPlace-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPickAndPlace-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPickAndPlace-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrPickAndPlace)))
  'HsrPickAndPlace-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrPickAndPlace)))
  'HsrPickAndPlace-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPickAndPlace)))
  "Returns string type for a service object of type '<HsrPickAndPlace>"
  "printeps_hsr_modules/HsrPickAndPlace")