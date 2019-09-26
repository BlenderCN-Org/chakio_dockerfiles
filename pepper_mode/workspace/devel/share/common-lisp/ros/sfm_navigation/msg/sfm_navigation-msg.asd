
(cl:in-package :asdf)

(defsystem "sfm_navigation-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "Agent" :depends-on ("_package_Agent"))
    (:file "_package_Agent" :depends-on ("_package"))
    (:file "AgentArray" :depends-on ("_package_AgentArray"))
    (:file "_package_AgentArray" :depends-on ("_package"))
  ))