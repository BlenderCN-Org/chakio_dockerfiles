# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "printeps_pepper_modules: 0 messages, 4 services")

set(MSG_I_FLAGS "-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(printeps_pepper_modules_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_custom_target(_printeps_pepper_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_pepper_modules" "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" ""
)

get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_custom_target(_printeps_pepper_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_pepper_modules" "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_custom_target(_printeps_pepper_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_pepper_modules" "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" "geometry_msgs/Pose:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/PoseArray:std_msgs/Float32:geometry_msgs/Pose2D"
)

get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_custom_target(_printeps_pepper_modules_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "printeps_pepper_modules" "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" "geometry_msgs/Pose2D"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_cpp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_cpp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_cpp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
)

### Generating Module File
_generate_module_cpp(printeps_pepper_modules
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(printeps_pepper_modules_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(printeps_pepper_modules_generate_messages printeps_pepper_modules_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_cpp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_cpp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_cpp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_cpp _printeps_pepper_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_pepper_modules_gencpp)
add_dependencies(printeps_pepper_modules_gencpp printeps_pepper_modules_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_pepper_modules_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_eus(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_eus(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_eus(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
)

### Generating Module File
_generate_module_eus(printeps_pepper_modules
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(printeps_pepper_modules_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(printeps_pepper_modules_generate_messages printeps_pepper_modules_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_eus _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_eus _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_eus _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_eus _printeps_pepper_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_pepper_modules_geneus)
add_dependencies(printeps_pepper_modules_geneus printeps_pepper_modules_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_pepper_modules_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_lisp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_lisp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_lisp(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
)

### Generating Module File
_generate_module_lisp(printeps_pepper_modules
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(printeps_pepper_modules_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(printeps_pepper_modules_generate_messages printeps_pepper_modules_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_lisp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_lisp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_lisp _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_lisp _printeps_pepper_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_pepper_modules_genlisp)
add_dependencies(printeps_pepper_modules_genlisp printeps_pepper_modules_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_pepper_modules_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_nodejs(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_nodejs(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_nodejs(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
)

### Generating Module File
_generate_module_nodejs(printeps_pepper_modules
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(printeps_pepper_modules_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(printeps_pepper_modules_generate_messages printeps_pepper_modules_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_nodejs _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_nodejs _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_nodejs _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_nodejs _printeps_pepper_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_pepper_modules_gennodejs)
add_dependencies(printeps_pepper_modules_gennodejs printeps_pepper_modules_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_pepper_modules_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_py(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_py(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
)
_generate_srv_py(printeps_pepper_modules
  "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
)

### Generating Module File
_generate_module_py(printeps_pepper_modules
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(printeps_pepper_modules_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(printeps_pepper_modules_generate_messages printeps_pepper_modules_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperSpeak.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_py _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_py _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PathGenerator.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_py _printeps_pepper_modules_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/printeps_pepper_modules/srv/PepperGlbNav.srv" NAME_WE)
add_dependencies(printeps_pepper_modules_generate_messages_py _printeps_pepper_modules_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(printeps_pepper_modules_genpy)
add_dependencies(printeps_pepper_modules_genpy printeps_pepper_modules_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS printeps_pepper_modules_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/printeps_pepper_modules
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(printeps_pepper_modules_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(printeps_pepper_modules_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/printeps_pepper_modules
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(printeps_pepper_modules_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(printeps_pepper_modules_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/printeps_pepper_modules
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(printeps_pepper_modules_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(printeps_pepper_modules_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/printeps_pepper_modules
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(printeps_pepper_modules_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(printeps_pepper_modules_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/printeps_pepper_modules
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(printeps_pepper_modules_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(printeps_pepper_modules_generate_messages_py std_msgs_generate_messages_py)
endif()
