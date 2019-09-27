;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrPickUpObject)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrPickUpObject (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECT")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECT"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECTREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECTREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECTRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKUPOBJECTRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrPickUpObjectRequest
  :super ros::object
  :slots (_object_id ))

(defmethod printeps_hsr_modules::HsrPickUpObjectRequest
  (:init
   (&key
    ((:object_id __object_id) "")
    )
   (send-super :init)
   (setq _object_id (string __object_id))
   self)
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:serialization-length
   ()
   (+
    ;; string _object_id
    4 (length _object_id)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _object_id
       (write-long (length _object_id) s) (princ _object_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _object_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrPickUpObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrPickUpObjectResponse
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

(defclass printeps_hsr_modules::HsrPickUpObject
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrPickUpObject :md5sum-) "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(setf (get printeps_hsr_modules::HsrPickUpObject :datatype-) "printeps_hsr_modules/HsrPickUpObject")
(setf (get printeps_hsr_modules::HsrPickUpObject :request) printeps_hsr_modules::HsrPickUpObjectRequest)
(setf (get printeps_hsr_modules::HsrPickUpObject :response) printeps_hsr_modules::HsrPickUpObjectResponse)

(defmethod printeps_hsr_modules::HsrPickUpObjectRequest
  (:response () (instance printeps_hsr_modules::HsrPickUpObjectResponse :init)))

(setf (get printeps_hsr_modules::HsrPickUpObjectRequest :md5sum-) "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(setf (get printeps_hsr_modules::HsrPickUpObjectRequest :datatype-) "printeps_hsr_modules/HsrPickUpObjectRequest")
(setf (get printeps_hsr_modules::HsrPickUpObjectRequest :definition-)
      "
string object_id
---
bool success

")

(setf (get printeps_hsr_modules::HsrPickUpObjectResponse :md5sum-) "0e5e8f7cd51729cbdbf3dd95ac38dad1")
(setf (get printeps_hsr_modules::HsrPickUpObjectResponse :datatype-) "printeps_hsr_modules/HsrPickUpObjectResponse")
(setf (get printeps_hsr_modules::HsrPickUpObjectResponse :definition-)
      "
string object_id
---
bool success

")



(provide :printeps_hsr_modules/HsrPickUpObject "0e5e8f7cd51729cbdbf3dd95ac38dad1")


