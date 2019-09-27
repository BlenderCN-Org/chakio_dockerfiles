;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrReleaseObject)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrReleaseObject (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECT")
  (make-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECT"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECTREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECTREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECTRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRRELEASEOBJECTRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrReleaseObjectRequest
  :super ros::object
  :slots (_place_id ))

(defmethod printeps_hsr_modules::HsrReleaseObjectRequest
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

(defclass printeps_hsr_modules::HsrReleaseObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrReleaseObjectResponse
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

(defclass printeps_hsr_modules::HsrReleaseObject
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrReleaseObject :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrReleaseObject :datatype-) "printeps_hsr_modules/HsrReleaseObject")
(setf (get printeps_hsr_modules::HsrReleaseObject :request) printeps_hsr_modules::HsrReleaseObjectRequest)
(setf (get printeps_hsr_modules::HsrReleaseObject :response) printeps_hsr_modules::HsrReleaseObjectResponse)

(defmethod printeps_hsr_modules::HsrReleaseObjectRequest
  (:response () (instance printeps_hsr_modules::HsrReleaseObjectResponse :init)))

(setf (get printeps_hsr_modules::HsrReleaseObjectRequest :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrReleaseObjectRequest :datatype-) "printeps_hsr_modules/HsrReleaseObjectRequest")
(setf (get printeps_hsr_modules::HsrReleaseObjectRequest :definition-)
      "
string place_id
---
bool success

")

(setf (get printeps_hsr_modules::HsrReleaseObjectResponse :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrReleaseObjectResponse :datatype-) "printeps_hsr_modules/HsrReleaseObjectResponse")
(setf (get printeps_hsr_modules::HsrReleaseObjectResponse :definition-)
      "
string place_id
---
bool success

")



(provide :printeps_hsr_modules/HsrReleaseObject "f676f5c1cafe9b38346686b35969df08")


