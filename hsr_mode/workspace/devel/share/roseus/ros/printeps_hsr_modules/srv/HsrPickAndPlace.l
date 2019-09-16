;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrPickAndPlace)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrPickAndPlace (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACE")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACE"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACEREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACEREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACERESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRPICKANDPLACERESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrPickAndPlaceRequest
  :super ros::object
  :slots (_object_place _destination _object_name ))

(defmethod printeps_hsr_modules::HsrPickAndPlaceRequest
  (:init
   (&key
    ((:object_place __object_place) "")
    ((:destination __destination) "")
    ((:object_name __object_name) "")
    )
   (send-super :init)
   (setq _object_place (string __object_place))
   (setq _destination (string __destination))
   (setq _object_name (string __object_name))
   self)
  (:object_place
   (&optional __object_place)
   (if __object_place (setq _object_place __object_place)) _object_place)
  (:destination
   (&optional __destination)
   (if __destination (setq _destination __destination)) _destination)
  (:object_name
   (&optional __object_name)
   (if __object_name (setq _object_name __object_name)) _object_name)
  (:serialization-length
   ()
   (+
    ;; string _object_place
    4 (length _object_place)
    ;; string _destination
    4 (length _destination)
    ;; string _object_name
    4 (length _object_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _object_place
       (write-long (length _object_place) s) (princ _object_place s)
     ;; string _destination
       (write-long (length _destination) s) (princ _destination s)
     ;; string _object_name
       (write-long (length _object_name) s) (princ _object_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _object_place
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_place (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _destination
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _destination (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _object_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrPickAndPlaceResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrPickAndPlaceResponse
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

(defclass printeps_hsr_modules::HsrPickAndPlace
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrPickAndPlace :md5sum-) "ad863b503ce673c2257d5090716e8cbd")
(setf (get printeps_hsr_modules::HsrPickAndPlace :datatype-) "printeps_hsr_modules/HsrPickAndPlace")
(setf (get printeps_hsr_modules::HsrPickAndPlace :request) printeps_hsr_modules::HsrPickAndPlaceRequest)
(setf (get printeps_hsr_modules::HsrPickAndPlace :response) printeps_hsr_modules::HsrPickAndPlaceResponse)

(defmethod printeps_hsr_modules::HsrPickAndPlaceRequest
  (:response () (instance printeps_hsr_modules::HsrPickAndPlaceResponse :init)))

(setf (get printeps_hsr_modules::HsrPickAndPlaceRequest :md5sum-) "ad863b503ce673c2257d5090716e8cbd")
(setf (get printeps_hsr_modules::HsrPickAndPlaceRequest :datatype-) "printeps_hsr_modules/HsrPickAndPlaceRequest")
(setf (get printeps_hsr_modules::HsrPickAndPlaceRequest :definition-)
      "
string                object_place
string                destination
string                object_name
---
bool success
")

(setf (get printeps_hsr_modules::HsrPickAndPlaceResponse :md5sum-) "ad863b503ce673c2257d5090716e8cbd")
(setf (get printeps_hsr_modules::HsrPickAndPlaceResponse :datatype-) "printeps_hsr_modules/HsrPickAndPlaceResponse")
(setf (get printeps_hsr_modules::HsrPickAndPlaceResponse :definition-)
      "
string                object_place
string                destination
string                object_name
---
bool success
")



(provide :printeps_hsr_modules/HsrPickAndPlace "ad863b503ce673c2257d5090716e8cbd")


