;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrCarry)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrCarry (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRY")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRY"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRYREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRYREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRYRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRYRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrCarryRequest
  :super ros::object
  :slots (_destination ))

(defmethod printeps_hsr_modules::HsrCarryRequest
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

(defclass printeps_hsr_modules::HsrCarryResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrCarryResponse
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

(defclass printeps_hsr_modules::HsrCarry
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrCarry :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrCarry :datatype-) "printeps_hsr_modules/HsrCarry")
(setf (get printeps_hsr_modules::HsrCarry :request) printeps_hsr_modules::HsrCarryRequest)
(setf (get printeps_hsr_modules::HsrCarry :response) printeps_hsr_modules::HsrCarryResponse)

(defmethod printeps_hsr_modules::HsrCarryRequest
  (:response () (instance printeps_hsr_modules::HsrCarryResponse :init)))

(setf (get printeps_hsr_modules::HsrCarryRequest :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrCarryRequest :datatype-) "printeps_hsr_modules/HsrCarryRequest")
(setf (get printeps_hsr_modules::HsrCarryRequest :definition-)
      "
string  destination
---
bool success
")

(setf (get printeps_hsr_modules::HsrCarryResponse :md5sum-) "a8b810758ea760dd74984f070e767d53")
(setf (get printeps_hsr_modules::HsrCarryResponse :datatype-) "printeps_hsr_modules/HsrCarryResponse")
(setf (get printeps_hsr_modules::HsrCarryResponse :definition-)
      "
string  destination
---
bool success
")



(provide :printeps_hsr_modules/HsrCarry "a8b810758ea760dd74984f070e767d53")


