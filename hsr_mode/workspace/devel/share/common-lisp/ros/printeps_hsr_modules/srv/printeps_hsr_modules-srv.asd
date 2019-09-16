
(cl:in-package :asdf)

(defsystem "printeps_hsr_modules-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Float32ToPose2D" :depends-on ("_package_Float32ToPose2D"))
    (:file "_package_Float32ToPose2D" :depends-on ("_package"))
    (:file "HsrCarry" :depends-on ("_package_HsrCarry"))
    (:file "_package_HsrCarry" :depends-on ("_package"))
    (:file "HsrCarry2017" :depends-on ("_package_HsrCarry2017"))
    (:file "_package_HsrCarry2017" :depends-on ("_package"))
    (:file "HsrGlbNav" :depends-on ("_package_HsrGlbNav"))
    (:file "_package_HsrGlbNav" :depends-on ("_package"))
    (:file "HsrHandRelease" :depends-on ("_package_HsrHandRelease"))
    (:file "_package_HsrHandRelease" :depends-on ("_package"))
    (:file "HsrHandoverObject" :depends-on ("_package_HsrHandoverObject"))
    (:file "_package_HsrHandoverObject" :depends-on ("_package"))
    (:file "HsrHoldObject" :depends-on ("_package_HsrHoldObject"))
    (:file "_package_HsrHoldObject" :depends-on ("_package"))
    (:file "HsrLog" :depends-on ("_package_HsrLog"))
    (:file "_package_HsrLog" :depends-on ("_package"))
    (:file "HsrLogP" :depends-on ("_package_HsrLogP"))
    (:file "_package_HsrLogP" :depends-on ("_package"))
    (:file "HsrMMNav" :depends-on ("_package_HsrMMNav"))
    (:file "_package_HsrMMNav" :depends-on ("_package"))
    (:file "HsrNav" :depends-on ("_package_HsrNav"))
    (:file "_package_HsrNav" :depends-on ("_package"))
    (:file "HsrNav2" :depends-on ("_package_HsrNav2"))
    (:file "_package_HsrNav2" :depends-on ("_package"))
    (:file "HsrNav3" :depends-on ("_package_HsrNav3"))
    (:file "_package_HsrNav3" :depends-on ("_package"))
    (:file "HsrPickAndPlace" :depends-on ("_package_HsrPickAndPlace"))
    (:file "_package_HsrPickAndPlace" :depends-on ("_package"))
    (:file "HsrPickUpObject" :depends-on ("_package_HsrPickUpObject"))
    (:file "_package_HsrPickUpObject" :depends-on ("_package"))
    (:file "HsrPlaceObject" :depends-on ("_package_HsrPlaceObject"))
    (:file "_package_HsrPlaceObject" :depends-on ("_package"))
    (:file "HsrReleaseObject" :depends-on ("_package_HsrReleaseObject"))
    (:file "_package_HsrReleaseObject" :depends-on ("_package"))
    (:file "HsrSay" :depends-on ("_package_HsrSay"))
    (:file "_package_HsrSay" :depends-on ("_package"))
    (:file "HsrSymNav" :depends-on ("_package_HsrSymNav"))
    (:file "_package_HsrSymNav" :depends-on ("_package"))
    (:file "PathGenerator" :depends-on ("_package_PathGenerator"))
    (:file "_package_PathGenerator" :depends-on ("_package"))
  ))