; Auto-generated. Do not edit!


(cl:in-package printeps_hsr_modules-srv)


;//! \htmlinclude HsrPlaceObject-request.msg.html

(cl:defclass <HsrPlaceObject-request> (roslisp-msg-protocol:ros-message)
  ((place_id
    :reader place_id
    :initarg :place_id
    :type cl:string
    :initform "")
   (object_name
    :reader object_name
    :initarg :object_name
    :type cl:string
    :initform ""))
)

(cl:defclass HsrPlaceObject-request (<HsrPlaceObject-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPlaceObject-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPlaceObject-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPlaceObject-request> is deprecated: use printeps_hsr_modules-srv:HsrPlaceObject-request instead.")))

(cl:ensure-generic-function 'place_id-val :lambda-list '(m))
(cl:defmethod place_id-val ((m <HsrPlaceObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:place_id-val is deprecated.  Use printeps_hsr_modules-srv:place_id instead.")
  (place_id m))

(cl:ensure-generic-function 'object_name-val :lambda-list '(m))
(cl:defmethod object_name-val ((m <HsrPlaceObject-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:object_name-val is deprecated.  Use printeps_hsr_modules-srv:object_name instead.")
  (object_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPlaceObject-request>) ostream)
  "Serializes a message object of type '<HsrPlaceObject-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'place_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'place_id))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPlaceObject-request>) istream)
  "Deserializes a message object of type '<HsrPlaceObject-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'place_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'place_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPlaceObject-request>)))
  "Returns string type for a service object of type '<HsrPlaceObject-request>"
  "printeps_hsr_modules/HsrPlaceObjectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPlaceObject-request)))
  "Returns string type for a service object of type 'HsrPlaceObject-request"
  "printeps_hsr_modules/HsrPlaceObjectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPlaceObject-request>)))
  "Returns md5sum for a message object of type '<HsrPlaceObject-request>"
  "2699cab027d5696828aa7d5692db4bfe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPlaceObject-request)))
  "Returns md5sum for a message object of type 'HsrPlaceObject-request"
  "2699cab027d5696828aa7d5692db4bfe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPlaceObject-request>)))
  "Returns full string definition for message of type '<HsrPlaceObject-request>"
  (cl:format cl:nil "~%string place_id~%string object_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPlaceObject-request)))
  "Returns full string definition for message of type 'HsrPlaceObject-request"
  (cl:format cl:nil "~%string place_id~%string object_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPlaceObject-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'place_id))
     4 (cl:length (cl:slot-value msg 'object_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPlaceObject-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPlaceObject-request
    (cl:cons ':place_id (place_id msg))
    (cl:cons ':object_name (object_name msg))
))
;//! \htmlinclude HsrPlaceObject-response.msg.html

(cl:defclass <HsrPlaceObject-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HsrPlaceObject-response (<HsrPlaceObject-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HsrPlaceObject-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HsrPlaceObject-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name printeps_hsr_modules-srv:<HsrPlaceObject-response> is deprecated: use printeps_hsr_modules-srv:HsrPlaceObject-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HsrPlaceObject-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader printeps_hsr_modules-srv:success-val is deprecated.  Use printeps_hsr_modules-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HsrPlaceObject-response>) ostream)
  "Serializes a message object of type '<HsrPlaceObject-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HsrPlaceObject-response>) istream)
  "Deserializes a message object of type '<HsrPlaceObject-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HsrPlaceObject-response>)))
  "Returns string type for a service object of type '<HsrPlaceObject-response>"
  "printeps_hsr_modules/HsrPlaceObjectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPlaceObject-response)))
  "Returns string type for a service object of type 'HsrPlaceObject-response"
  "printeps_hsr_modules/HsrPlaceObjectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HsrPlaceObject-response>)))
  "Returns md5sum for a message object of type '<HsrPlaceObject-response>"
  "2699cab027d5696828aa7d5692db4bfe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HsrPlaceObject-response)))
  "Returns md5sum for a message object of type 'HsrPlaceObject-response"
  "2699cab027d5696828aa7d5692db4bfe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HsrPlaceObject-response>)))
  "Returns full string definition for message of type '<HsrPlaceObject-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HsrPlaceObject-response)))
  "Returns full string definition for message of type 'HsrPlaceObject-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HsrPlaceObject-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HsrPlaceObject-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HsrPlaceObject-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HsrPlaceObject)))
  'HsrPlaceObject-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HsrPlaceObject)))
  'HsrPlaceObject-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HsrPlaceObject)))
  "Returns string type for a service object of type '<HsrPlaceObject>"
  "printeps_hsr_modules/HsrPlaceObject")