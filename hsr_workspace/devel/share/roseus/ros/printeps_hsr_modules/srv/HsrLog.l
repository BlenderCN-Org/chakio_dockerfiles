;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrLog)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrLog (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOG")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOG"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOGREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOGREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRLOGRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRLOGRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrLogRequest
  :super ros::object
  :slots (_log _IMU _LRF _Wrist _Joint _TF _mode ))

(defmethod printeps_hsr_modules::HsrLogRequest
  (:init
   (&key
    ((:log __log) nil)
    ((:IMU __IMU) nil)
    ((:LRF __LRF) nil)
    ((:Wrist __Wrist) nil)
    ((:Joint __Joint) nil)
    ((:TF __TF) nil)
    ((:mode __mode) "")
    )
   (send-super :init)
   (setq _log __log)
   (setq _IMU __IMU)
   (setq _LRF __LRF)
   (setq _Wrist __Wrist)
   (setq _Joint __Joint)
   (setq _TF __TF)
   (setq _mode (string __mode))
   self)
  (:log
   (&optional __log)
   (if __log (setq _log __log)) _log)
  (:IMU
   (&optional __IMU)
   (if __IMU (setq _IMU __IMU)) _IMU)
  (:LRF
   (&optional __LRF)
   (if __LRF (setq _LRF __LRF)) _LRF)
  (:Wrist
   (&optional __Wrist)
   (if __Wrist (setq _Wrist __Wrist)) _Wrist)
  (:Joint
   (&optional __Joint)
   (if __Joint (setq _Joint __Joint)) _Joint)
  (:TF
   (&optional __TF)
   (if __TF (setq _TF __TF)) _TF)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; bool _log
    1
    ;; bool _IMU
    1
    ;; bool _LRF
    1
    ;; bool _Wrist
    1
    ;; bool _Joint
    1
    ;; bool _TF
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
     ;; bool _IMU
       (if _IMU (write-byte -1 s) (write-byte 0 s))
     ;; bool _LRF
       (if _LRF (write-byte -1 s) (write-byte 0 s))
     ;; bool _Wrist
       (if _Wrist (write-byte -1 s) (write-byte 0 s))
     ;; bool _Joint
       (if _Joint (write-byte -1 s) (write-byte 0 s))
     ;; bool _TF
       (if _TF (write-byte -1 s) (write-byte 0 s))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _log
     (setq _log (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _IMU
     (setq _IMU (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _LRF
     (setq _LRF (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _Wrist
     (setq _Wrist (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _Joint
     (setq _Joint (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _TF
     (setq _TF (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrLogResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrLogResponse
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

(defclass printeps_hsr_modules::HsrLog
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrLog :md5sum-) "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(setf (get printeps_hsr_modules::HsrLog :datatype-) "printeps_hsr_modules/HsrLog")
(setf (get printeps_hsr_modules::HsrLog :request) printeps_hsr_modules::HsrLogRequest)
(setf (get printeps_hsr_modules::HsrLog :response) printeps_hsr_modules::HsrLogResponse)

(defmethod printeps_hsr_modules::HsrLogRequest
  (:response () (instance printeps_hsr_modules::HsrLogResponse :init)))

(setf (get printeps_hsr_modules::HsrLogRequest :md5sum-) "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(setf (get printeps_hsr_modules::HsrLogRequest :datatype-) "printeps_hsr_modules/HsrLogRequest")
(setf (get printeps_hsr_modules::HsrLogRequest :definition-)
      "

bool log
bool IMU
bool LRF
bool Wrist
bool Joint
bool TF
string mode
---
bool success
")

(setf (get printeps_hsr_modules::HsrLogResponse :md5sum-) "9e0a21f8f1cdf5a53b46ee0aee2923c4")
(setf (get printeps_hsr_modules::HsrLogResponse :datatype-) "printeps_hsr_modules/HsrLogResponse")
(setf (get printeps_hsr_modules::HsrLogResponse :definition-)
      "

bool log
bool IMU
bool LRF
bool Wrist
bool Joint
bool TF
string mode
---
bool success
")



(provide :printeps_hsr_modules/HsrLog "9e0a21f8f1cdf5a53b46ee0aee2923c4")


