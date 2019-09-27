;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrHoldObject)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrHoldObject (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECT")
  (make-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECT"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECTREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECTREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECTRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRHOLDOBJECTRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrHoldObjectRequest
  :super ros::object
  :slots (_place_id ))

(defmethod printeps_hsr_modules::HsrHoldObjectRequest
  (:init
   (&key
    ((:place_id __place_id) "")
    )
   (send-super :init)
   (setq _place_id (string __place_id))
   self)
  (:place_id
   (&optional __place_id)
   (if __place_id (setq _place_id __place_id)) _place_id)
  (:serialization-length
   ()
   (+
    ;; string _place_id
    4 (length _place_id)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _place_id
       (write-long (length _place_id) s) (princ _place_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _place_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _place_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrHoldObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrHoldObjectResponse
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

(defclass printeps_hsr_modules::HsrHoldObject
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrHoldObject :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHoldObject :datatype-) "printeps_hsr_modules/HsrHoldObject")
(setf (get printeps_hsr_modules::HsrHoldObject :request) printeps_hsr_modules::HsrHoldObjectRequest)
(setf (get printeps_hsr_modules::HsrHoldObject :response) printeps_hsr_modules::HsrHoldObjectResponse)

(defmethod printeps_hsr_modules::HsrHoldObjectRequest
  (:response () (instance printeps_hsr_modules::HsrHoldObjectResponse :init)))

(setf (get printeps_hsr_modules::HsrHoldObjectRequest :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHoldObjectRequest :datatype-) "printeps_hsr_modules/HsrHoldObjectRequest")
(setf (get printeps_hsr_modules::HsrHoldObjectRequest :definition-)
      "
string place_id
---
bool success

")

(setf (get printeps_hsr_modules::HsrHoldObjectResponse :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHoldObjectResponse :datatype-) "printeps_hsr_modules/HsrHoldObjectResponse")
(setf (get printeps_hsr_modules::HsrHoldObjectResponse :definition-)
      "
string place_id
---
bool success

")



(provide :printeps_hsr_modules/HsrHoldObject "f676f5c1cafe9b38346686b35969df08")


