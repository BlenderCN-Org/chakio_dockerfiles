# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "printeps_hsr_modules: 5 messages, 20 services")

set(MSG_I_FLAGS "-Iprinteps_hsr_modules:/catkin_ws/src/printeps_hsr_modules/msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(printeps_hsr_modules_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" "std_msgs/Float64:geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" "geometry_msgs/Pose2D:printeps_hsr_modules/HsrPerson"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" "geometry_msgs/Pose:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/PoseArray:std_msgs/Float64:std_msgs/Float32:std_msgs/Bool:geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" "geometry_msgs/Pose2D:printeps_hsr_modules/HsrTableset:printeps_hsr_modules/HsrObstacle"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" "geometry_msgs/Pose2D:printeps_hsr_modules/HsrObstacle"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_custom_target(_printeps_hsr_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_hsr_modules" "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Services
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_cpp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Module File
_generate_module_cpp(printeps_hsr_modules
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(printeps_hsr_modules_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(printeps_hsr_modules_generate_messages printeps_hsr_modules_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_cpp _printeps_hsr_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_hsr_modules_gencpp)
add_dependencies(printeps_hsr_modules_gencpp printeps_hsr_modules_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_hsr_modules_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Services
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_eus(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Module File
_generate_module_eus(printeps_hsr_modules
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(printeps_hsr_modules_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(printeps_hsr_modules_generate_messages printeps_hsr_modules_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_eus _printeps_hsr_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_hsr_modules_geneus)
add_dependencies(printeps_hsr_modules_geneus printeps_hsr_modules_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_hsr_modules_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Services
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_lisp(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Module File
_generate_module_lisp(printeps_hsr_modules
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(printeps_hsr_modules_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(printeps_hsr_modules_generate_messages printeps_hsr_modules_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_lisp _printeps_hsr_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_hsr_modules_genlisp)
add_dependencies(printeps_hsr_modules_genlisp printeps_hsr_modules_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_hsr_modules_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Services
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_nodejs(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Module File
_generate_module_nodejs(printeps_hsr_modules
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(printeps_hsr_modules_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(printeps_hsr_modules_generate_messages printeps_hsr_modules_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_nodejs _printeps_hsr_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_hsr_modules_gennodejs)
add_dependencies(printeps_hsr_modules_gennodejs printeps_hsr_modules_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_hsr_modules_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_msg_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Services
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Bool.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)
_generate_srv_py(printeps_hsr_modules
  "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
)

### Generating Module File
_generate_module_py(printeps_hsr_modules
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(printeps_hsr_modules_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(printeps_hsr_modules_generate_messages printeps_hsr_modules_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrMMNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav2.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSay.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHoldObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrOpenpose.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrSymNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickUpObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLog.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacleArray.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandRelease.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrCarry2017.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPickAndPlace.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/Float32ToPose2D.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrLogP.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrGlbNav.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrTableset.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrObstacle.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrNav3.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/msg/HsrPerson.msg" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrPlaceObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrHandoverObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_hsr_modules/srv/HsrReleaseObject.srv" NAME_WE)
add_dependencies(printeps_hsr_modules_generate_messages_py _printeps_hsr_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_hsr_modules_genpy)
add_dependencies(printeps_hsr_modules_genpy printeps_hsr_modules_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_hsr_modules_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_hsr_modules
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(printeps_hsr_modules_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(printeps_hsr_modules_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_hsr_modules
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(printeps_hsr_modules_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(printeps_hsr_modules_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_hsr_modules
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(printeps_hsr_modules_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(printeps_hsr_modules_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_hsr_modules
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(printeps_hsr_modules_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(printeps_hsr_modules_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_hsr_modules
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(printeps_hsr_modules_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(printeps_hsr_modules_generate_messages_py std_msgs_generate_messages_py)
endif()
