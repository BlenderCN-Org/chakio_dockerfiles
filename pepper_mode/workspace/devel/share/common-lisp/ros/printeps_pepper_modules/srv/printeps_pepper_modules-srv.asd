
(cl:in-package :asdf)

(defsystem "printeps_pepper_modules-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "PathGenerator" :depends-on ("_package_PathGenerator"))
    (:file "_package_PathGenerator" :depends-on ("_package"))
    (:file "PepperGlbNav" :depends-on ("_package_PepperGlbNav"))
    (:file "_package_PepperGlbNav" :depends-on ("_package"))
    (:file "PepperNav" :depends-on ("_package_PepperNav"))
    (:file "_package_PepperNav" :depends-on ("_package"))
    (:file "PepperSpeak" :depends-on ("_package_PepperSpeak"))
    (:file "_package_PepperSpeak" :depends-on ("_package"))
  ))