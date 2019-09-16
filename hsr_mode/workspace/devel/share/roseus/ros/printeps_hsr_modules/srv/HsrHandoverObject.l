;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrHandoverObject)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrHandoverObject (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECT")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECT"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECTREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECTREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECTRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDOVEROBJECTRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrHandoverObjectRequest
  :super ros::object
  :slots (_place_id _object_name ))

(defmethod printeps_hsr_modules::HsrHandoverObjectRequest
  (:init
   (&key
    ((:place_id __place_id) "")
    ((:object_name __object_name) "")
    )
   (send-super :init)
   (setq _place_id (string __place_id))
   (setq _object_name (string __object_name))
   self)
  (:place_id
   (&optional __place_id)
   (if __place_id (setq _place_id __place_id)) _place_id)
  (:object_name
   (&optional __object_name)
   (if __object_name (setq _object_name __object_name)) _object_name)
  (:serialization-length
   ()
   (+
    ;; string _place_id
    4 (length _place_id)
    ;; string _object_name
    4 (length _object_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _place_id
       (write-long (length _place_id) s) (princ _place_id s)
     ;; string _object_name
       (write-long (length _object_name) s) (princ _object_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _place_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _place_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _object_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrHandoverObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrHandoverObjectResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrHandoverObject
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrHandoverObject :md5sum-) "2699cab027d5696828aa7d5692db4bfe")
(setf (get printeps_hsr_modules::HsrHandoverObject :datatype-) "printeps_hsr_modules/HsrHandoverObject")
(setf (get printeps_hsr_modules::HsrHandoverObject :request) printeps_hsr_modules::HsrHandoverObjectRequest)
(setf (get printeps_hsr_modules::HsrHandoverObject :response) printeps_hsr_modules::HsrHandoverObjectResponse)

(defmethod printeps_hsr_modules::HsrHandoverObjectRequest
  (:response () (instance printeps_hsr_modules::HsrHandoverObjectResponse :init)))

(setf (get printeps_hsr_modules::HsrHandoverObjectRequest :md5sum-) "2699cab027d5696828aa7d5692db4bfe")
(setf (get printeps_hsr_modules::HsrHandoverObjectRequest :datatype-) "printeps_hsr_modules/HsrHandoverObjectRequest")
(setf (get printeps_hsr_modules::HsrHandoverObjectRequest :definition-)
      "
string place_id
string object_name
---
bool success

")

(setf (get printeps_hsr_modules::HsrHandoverObjectResponse :md5sum-) "2699cab027d5696828aa7d5692db4bfe")
(setf (get printeps_hsr_modules::HsrHandoverObjectResponse :datatype-) "printeps_hsr_modules/HsrHandoverObjectResponse")
(setf (get printeps_hsr_modules::HsrHandoverObjectResponse :definition-)
      "
string place_id
string object_name
---
bool success

")



(provide :printeps_hsr_modules/HsrHandoverObject "2699cab027d5696828aa7d5692db4bfe")


