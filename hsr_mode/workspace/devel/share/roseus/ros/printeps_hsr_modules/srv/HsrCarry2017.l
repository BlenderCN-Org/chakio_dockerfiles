;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrCarry2017)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrCarry2017 (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRY2017")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRY2017"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRY2017REQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRY2017REQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRCARRY2017RESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRCARRY2017RESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrCarry2017Request
  :super ros::object
  :slots (_pose_B _pose_D ))

(defmethod printeps_hsr_modules::HsrCarry2017Request
  (:init
   (&key
    ((:pose_B __pose_B) "")
    ((:pose_D __pose_D) "")
    )
   (send-super :init)
   (setq _pose_B (string __pose_B))
   (setq _pose_D (string __pose_D))
   self)
  (:pose_B
   (&optional __pose_B)
   (if __pose_B (setq _pose_B __pose_B)) _pose_B)
  (:pose_D
   (&optional __pose_D)
   (if __pose_D (setq _pose_D __pose_D)) _pose_D)
  (:serialization-length
   ()
   (+
    ;; string _pose_B
    4 (length _pose_B)
    ;; string _pose_D
    4 (length _pose_D)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _pose_B
       (write-long (length _pose_B) s) (princ _pose_B s)
     ;; string _pose_D
       (write-long (length _pose_D) s) (princ _pose_D s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _pose_B
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _pose_B (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _pose_D
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _pose_D (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrCarry2017Response
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrCarry2017Response
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

(defclass printeps_hsr_modules::HsrCarry2017
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrCarry2017 :md5sum-) "2dce38ab0b77cebc740f59d7c59f16d4")
(setf (get printeps_hsr_modules::HsrCarry2017 :datatype-) "printeps_hsr_modules/HsrCarry2017")
(setf (get printeps_hsr_modules::HsrCarry2017 :request) printeps_hsr_modules::HsrCarry2017Request)
(setf (get printeps_hsr_modules::HsrCarry2017 :response) printeps_hsr_modules::HsrCarry2017Response)

(defmethod printeps_hsr_modules::HsrCarry2017Request
  (:response () (instance printeps_hsr_modules::HsrCarry2017Response :init)))

(setf (get printeps_hsr_modules::HsrCarry2017Request :md5sum-) "2dce38ab0b77cebc740f59d7c59f16d4")
(setf (get printeps_hsr_modules::HsrCarry2017Request :datatype-) "printeps_hsr_modules/HsrCarry2017Request")
(setf (get printeps_hsr_modules::HsrCarry2017Request :definition-)
      "
string  pose_B
string  pose_D
---
bool success
")

(setf (get printeps_hsr_modules::HsrCarry2017Response :md5sum-) "2dce38ab0b77cebc740f59d7c59f16d4")
(setf (get printeps_hsr_modules::HsrCarry2017Response :datatype-) "printeps_hsr_modules/HsrCarry2017Response")
(setf (get printeps_hsr_modules::HsrCarry2017Response :definition-)
      "
string  pose_B
string  pose_D
---
bool success
")



(provide :printeps_hsr_modules/HsrCarry2017 "2dce38ab0b77cebc740f59d7c59f16d4")


