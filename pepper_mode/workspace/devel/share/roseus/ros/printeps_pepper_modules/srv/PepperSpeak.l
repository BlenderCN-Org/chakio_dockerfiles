;; Auto-generated. Do not edit!


(when (boundp 'printeps_pepper_modules::PepperSpeak)
  (if (not (find-package "PRINTEPS_PEPPER_MODULES"))
    (make-package "PRINTEPS_PEPPER_MODULES"))
  (shadow 'PepperSpeak (find-package "PRINTEPS_PEPPER_MODULES")))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAK")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAK"))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAKREQUEST")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAKREQUEST"))
(unless (find-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAKRESPONSE")
  (make-package "PRINTEPS_PEPPER_MODULES::PEPPERSPEAKRESPONSE"))

(in-package "ROS")





(defclass printeps_pepper_modules::PepperSpeakRequest
  :super ros::object
  :slots (_ip_address _contents ))

(defmethod printeps_pepper_modules::PepperSpeakRequest
  (:init
   (&key
    ((:ip_address __ip_address) "")
    ((:contents __contents) "")
    )
   (send-super :init)
   (setq _ip_address (string __ip_address))
   (setq _contents (string __contents))
   self)
  (:ip_address
   (&optional __ip_address)
   (if __ip_address (setq _ip_address __ip_address)) _ip_address)
  (:contents
   (&optional __contents)
   (if __contents (setq _contents __contents)) _contents)
  (:serialization-length
   ()
   (+
    ;; string _ip_address
    4 (length _ip_address)
    ;; string _contents
    4 (length _contents)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _ip_address
       (write-long (length _ip_address) s) (princ _ip_address s)
     ;; string _contents
       (write-long (length _contents) s) (princ _contents s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _ip_address
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _ip_address (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _contents
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _contents (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass printeps_pepper_modules::PepperSpeakResponse
  :super ros::object
  :slots (_success ))

(defmethod printeps_pepper_modules::PepperSpeakResponse
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

(defclass printeps_pepper_modules::PepperSpeak
  :super ros::object
  :slots ())

(setf (get printeps_pepper_modules::PepperSpeak :md5sum-) "4a951ed513207e655699b507ebeda279")
(setf (get printeps_pepper_modules::PepperSpeak :datatype-) "printeps_pepper_modules/PepperSpeak")
(setf (get printeps_pepper_modules::PepperSpeak :request) printeps_pepper_modules::PepperSpeakRequest)
(setf (get printeps_pepper_modules::PepperSpeak :response) printeps_pepper_modules::PepperSpeakResponse)

(defmethod printeps_pepper_modules::PepperSpeakRequest
  (:response () (instance printeps_pepper_modules::PepperSpeakResponse :init)))

(setf (get printeps_pepper_modules::PepperSpeakRequest :md5sum-) "4a951ed513207e655699b507ebeda279")
(setf (get printeps_pepper_modules::PepperSpeakRequest :datatype-) "printeps_pepper_modules/PepperSpeakRequest")
(setf (get printeps_pepper_modules::PepperSpeakRequest :definition-)
      "


string ip_address
string contents
---
bool success

")

(setf (get printeps_pepper_modules::PepperSpeakResponse :md5sum-) "4a951ed513207e655699b507ebeda279")
(setf (get printeps_pepper_modules::PepperSpeakResponse :datatype-) "printeps_pepper_modules/PepperSpeakResponse")
(setf (get printeps_pepper_modules::PepperSpeakResponse :definition-)
      "


string ip_address
string contents
---
bool success

")



(provide :printeps_pepper_modules/PepperSpeak "4a951ed513207e655699b507ebeda279")


