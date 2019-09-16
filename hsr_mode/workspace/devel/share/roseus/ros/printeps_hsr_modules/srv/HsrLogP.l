;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrLogP)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrLogP (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOGP")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOGP"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOGPREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOGPREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOGPRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOGPRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrLogPRequest
  :super ros::object
  :slots (_log _PCD _mode ))

(defmethod printeps_hsr_modules::HsrLogPRequest
  (:init
   (&key
    ((:log __log) nil)
    ((:PCD __PCD) nil)
    ((:mode __mode) "")
    )
   (send-super :init)
   (setq _log __log)
   (setq _PCD __PCD)
   (setq _mode (string __mode))
   self)
  (:log
   (&optional __log)
   (if __log (setq _log __log)) _log)
  (:PCD
   (&optional __PCD)
   (if __PCD (setq _PCD __PCD)) _PCD)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; bool _log
    1
    ;; bool _PCD
    1
    ;; string _mode
    4 (length _mode)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _log
       (if _log (write-byte -1 s) (write-byte 0 s))
     ;; bool _PCD
       (if _PCD (write-byte -1 s) (write-byte 0 s))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _log
     (setq _log (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _PCD
     (setq _PCD (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrLogPResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrLogPResponse
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

(defclass printeps_hsr_modules::HsrLogP
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrLogP :md5sum-) "3bab9c5fbe194c77b98025ec2f78083a")
(setf (get printeps_hsr_modules::HsrLogP :datatype-) "printeps_hsr_modules/HsrLogP")
(setf (get printeps_hsr_modules::HsrLogP :request) printeps_hsr_modules::HsrLogPRequest)
(setf (get printeps_hsr_modules::HsrLogP :response) printeps_hsr_modules::HsrLogPResponse)

(defmethod printeps_hsr_modules::HsrLogPRequest
  (:response () (instance printeps_hsr_modules::HsrLogPResponse :init)))

(setf (get printeps_hsr_modules::HsrLogPRequest :md5sum-) "3bab9c5fbe194c77b98025ec2f78083a")
(setf (get printeps_hsr_modules::HsrLogPRequest :datatype-) "printeps_hsr_modules/HsrLogPRequest")
(setf (get printeps_hsr_modules::HsrLogPRequest :definition-)
      "

bool log
bool PCD
string mode
---
bool success
")

(setf (get printeps_hsr_modules::HsrLogPResponse :md5sum-) "3bab9c5fbe194c77b98025ec2f78083a")
(setf (get printeps_hsr_modules::HsrLogPResponse :datatype-) "printeps_hsr_modules/HsrLogPResponse")
(setf (get printeps_hsr_modules::HsrLogPResponse :definition-)
      "

bool log
bool PCD
string mode
---
bool success
")



(provide :printeps_hsr_modules/HsrLogP "3bab9c5fbe194c77b98025ec2f78083a")


