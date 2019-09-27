
(cl:in-package :asdf)

(defsystem "printeps_hsr_modules-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "HsrObstacle" :depends-on ("_package_HsrObstacle"))
    (:file "_package_HsrObstacle" :depends-on ("_package"))
    (:file "HsrObstacleArray" :depends-on ("_package_HsrObstacleArray"))
    (:file "_package_HsrObstacleArray" :depends-on ("_package"))
    (:file "HsrOpenpose" :depends-on ("_package_HsrOpenpose"))
    (:file "_package_HsrOpenpose" :depends-on ("_package"))
    (:file "HsrPerson" :depends-on ("_package_HsrPerson"))
    (:file "_package_HsrPerson" :depends-on ("_package"))
    (:file "HsrTableset" :depends-on ("_package_HsrTableset"))
    (:file "_package_HsrTableset" :depends-on ("_package"))
  ))