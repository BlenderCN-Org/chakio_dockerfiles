;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrHandRelease)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrHandRelease (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASE")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASE"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASEREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASEREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASERESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRHANDRELEASERESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrHandReleaseRequest
  :super ros::object
  :slots (_place_id ))

(defmethod printeps_hsr_modules::HsrHandReleaseRequest
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

(defclass printeps_hsr_modules::HsrHandReleaseResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrHandReleaseResponse
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

(defclass printeps_hsr_modules::HsrHandRelease
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrHandRelease :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHandRelease :datatype-) "printeps_hsr_modules/HsrHandRelease")
(setf (get printeps_hsr_modules::HsrHandRelease :request) printeps_hsr_modules::HsrHandReleaseRequest)
(setf (get printeps_hsr_modules::HsrHandRelease :response) printeps_hsr_modules::HsrHandReleaseResponse)

(defmethod printeps_hsr_modules::HsrHandReleaseRequest
  (:response () (instance printeps_hsr_modules::HsrHandReleaseResponse :init)))

(setf (get printeps_hsr_modules::HsrHandReleaseRequest :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHandReleaseRequest :datatype-) "printeps_hsr_modules/HsrHandReleaseRequest")
(setf (get printeps_hsr_modules::HsrHandReleaseRequest :definition-)
      "
string place_id
---
bool success

")

(setf (get printeps_hsr_modules::HsrHandReleaseResponse :md5sum-) "f676f5c1cafe9b38346686b35969df08")
(setf (get printeps_hsr_modules::HsrHandReleaseResponse :datatype-) "printeps_hsr_modules/HsrHandReleaseResponse")
(setf (get printeps_hsr_modules::HsrHandReleaseResponse :definition-)
      "
string place_id
---
bool success

")



(provide :printeps_hsr_modules/HsrHandRelease "f676f5c1cafe9b38346686b35969df08")


