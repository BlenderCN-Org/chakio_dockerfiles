;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrSymNav)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrSymNav (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSYMNAV")
  (make-package "PRINTEPS_HSR_MODULES::HSRSYMNAV"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSYMNAVREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRSYMNAVREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSYMNAVRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRSYMNAVRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrSymNavRequest
  :super ros::object
  :slots (_destination ))

(defmethod printeps_hsr_modules::HsrSymNavRequest
  (:init
   (&key
    ((:destination __destination) "")
    )
   (send-super :init)
   (setq _destination (string __destination))
   self)
  (:destination
   (&optional __destination)
   (if __destination (setq _destination __destination)) _destination)
  (:serialization-length
   ()
   (+
    ;; string _destination
    4 (length _destination)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _destination
       (write-long (length _destination) s) (princ _destination s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _destination
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _destination (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrSymNavResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrSymNavResponse
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

(defclass printeps_hsr_modules::HsrSymNav
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrSymNav :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrSymNav :datatype-) "printeps_hsr_modules/HsrSymNav")
(setf (get printeps_hsr_modules::HsrSymNav :request) printeps_hsr_modules::HsrSymNavRequest)
(setf (get printeps_hsr_modules::HsrSymNav :response) printeps_hsr_modules::HsrSymNavResponse)

(defmethod printeps_hsr_modules::HsrSymNavRequest
  (:response () (instance printeps_hsr_modules::HsrSymNavResponse :init)))

(setf (get printeps_hsr_modules::HsrSymNavRequest :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrSymNavRequest :datatype-) "printeps_hsr_modules/HsrSymNavRequest")
(setf (get printeps_hsr_modules::HsrSymNavRequest :definition-)
      "
string  destination
---
bool success
")

(setf (get printeps_hsr_modules::HsrSymNavResponse :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrSymNavResponse :datatype-) "printeps_hsr_modules/HsrSymNavResponse")
(setf (get printeps_hsr_modules::HsrSymNavResponse :definition-)
      "
string  destination
---
bool success
")



(provide :printeps_hsr_modules/HsrSymNav "a8b810758ea760dd74984f070e767d53")


