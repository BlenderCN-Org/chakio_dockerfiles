;; Auto-generated. Do not edit!


(when (boundp 'printeps_hsr_modules::HsrSay)
  (if (not (find-package "PRINTEPS_HSR_MODULES"))
    (make-package "PRINTEPS_HSR_MODULES"))
  (shadow 'HsrSay (find-package "PRINTEPS_HSR_MODULES")))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSAY")
  (make-package "PRINTEPS_HSR_MODULES::HSRSAY"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSAYREQUEST")
  (make-package "PRINTEPS_HSR_MODULES::HSRSAYREQUEST"))
(unless (find-package "PRINTEPS_HSR_MODULES::HSRSAYRESPONSE")
  (make-package "PRINTEPS_HSR_MODULES::HSRSAYRESPONSE"))

(in-package "ROS")





(defclass printeps_hsr_modules::HsrSayRequest
  :super ros::object
  :slots (_words ))

(defmethod printeps_hsr_modules::HsrSayRequest
  (:init
   (&key
    ((:words __words) "")
    )
   (send-super :init)
   (setq _words (string __words))
   self)
  (:words
   (&optional __words)
   (if __words (setq _words __words)) _words)
  (:serialization-length
   ()
   (+
    ;; string _words
    4 (length _words)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _words
       (write-long (length _words) s) (princ _words s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _words
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _words (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_hsr_modules::HsrSayResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_hsr_modules::HsrSayResponse
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

(defclass printeps_hsr_modules::HsrSay
  :super ros::object
  :slots ())

(setf (get printeps_hsr_modules::HsrSay :md5sum-) "e42289734831209d7d09ddbae327bbad")
(setf (get printeps_hsr_modules::HsrSay :datatype-) "printeps_hsr_modules/HsrSay")
(setf (get printeps_hsr_modules::HsrSay :request) printeps_hsr_modules::HsrSayRequest)
(setf (get printeps_hsr_modules::HsrSay :response) printeps_hsr_modules::HsrSayResponse)

(defmethod printeps_hsr_modules::HsrSayRequest
  (:response () (instance printeps_hsr_modules::HsrSayResponse :init)))

(setf (get printeps_hsr_modules::HsrSayRequest :md5sum-) "e42289734831209d7d09ddbae327bbad")
(setf (get printeps_hsr_modules::HsrSayRequest :datatype-) "printeps_hsr_modules/HsrSayRequest")
(setf (get printeps_hsr_modules::HsrSayRequest :definition-)
      "
string words
---
bool success

")

(setf (get printeps_hsr_modules::HsrSayResponse :md5sum-) "e42289734831209d7d09ddbae327bbad")
(setf (get printeps_hsr_modules::HsrSayResponse :datatype-) "printeps_hsr_modules/HsrSayResponse")
(setf (get printeps_hsr_modules::HsrSayResponse :definition-)
      "
string words
---
bool success

")



(provide :printeps_hsr_modules/HsrSay "e42289734831209d7d09ddbae327bbad")


