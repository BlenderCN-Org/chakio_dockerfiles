# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sfm_navigation: 2 messages, 0 services")

set(MSG_I_FLAGS "-Isfm_navigation:/catkin_ws/src/sfm_navigation/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sfm_navigation_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_custom_target(_sfm_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sfm_navigation" "/catkin_ws/src/sfm_navigation/msg/Agent.msg" "geometry_msgs/Pose2D:geometry_msgs/Twist:geometry_msgs/Vector3"
)

get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_custom_target(_sfm_navigation_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sfm_navigation" "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" "geometry_msgs/Pose2D:geometry_msgs/Twist:sfm_navigation/Agent:geometry_msgs/Vector3"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/Agent.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sfm_navigation
)
_generate_msg_cpp(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/catkin_ws/src/sfm_navigation/msg/Agent.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sfm_navigation
)

### Generating Services

### Generating Module File
_generate_module_cpp(sfm_navigation
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sfm_navigation
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sfm_navigation_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sfm_navigation_generate_messages sfm_navigation_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_cpp _sfm_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_cpp _sfm_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sfm_navigation_gencpp)
add_dependencies(sfm_navigation_gencpp sfm_navigation_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sfm_navigation_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/Agent.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sfm_navigation
)
_generate_msg_eus(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/catkin_ws/src/sfm_navigation/msg/Agent.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sfm_navigation
)

### Generating Services

### Generating Module File
_generate_module_eus(sfm_navigation
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sfm_navigation
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sfm_navigation_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sfm_navigation_generate_messages sfm_navigation_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_eus _sfm_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_eus _sfm_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sfm_navigation_geneus)
add_dependencies(sfm_navigation_geneus sfm_navigation_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sfm_navigation_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/Agent.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sfm_navigation
)
_generate_msg_lisp(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/catkin_ws/src/sfm_navigation/msg/Agent.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sfm_navigation
)

### Generating Services

### Generating Module File
_generate_module_lisp(sfm_navigation
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sfm_navigation
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sfm_navigation_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sfm_navigation_generate_messages sfm_navigation_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_lisp _sfm_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_lisp _sfm_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sfm_navigation_genlisp)
add_dependencies(sfm_navigation_genlisp sfm_navigation_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sfm_navigation_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/Agent.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sfm_navigation
)
_generate_msg_nodejs(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/catkin_ws/src/sfm_navigation/msg/Agent.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sfm_navigation
)

### Generating Services

### Generating Module File
_generate_module_nodejs(sfm_navigation
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sfm_navigation
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sfm_navigation_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sfm_navigation_generate_messages sfm_navigation_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_nodejs _sfm_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_nodejs _sfm_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sfm_navigation_gennodejs)
add_dependencies(sfm_navigation_gennodejs sfm_navigation_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sfm_navigation_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/Agent.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation
)
_generate_msg_py(sfm_navigation
  "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/catkin_ws/src/sfm_navigation/msg/Agent.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation
)

### Generating Services

### Generating Module File
_generate_module_py(sfm_navigation
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sfm_navigation_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sfm_navigation_generate_messages sfm_navigation_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/Agent.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_py _sfm_navigation_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/catkin_ws/src/sfm_navigation/msg/AgentArray.msg" NAME_WE)
add_dependencies(sfm_navigation_generate_messages_py _sfm_navigation_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sfm_navigation_genpy)
add_dependencies(sfm_navigation_genpy sfm_navigation_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sfm_navigation_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sfm_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sfm_navigation
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sfm_navigation_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(sfm_navigation_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sfm_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sfm_navigation
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sfm_navigation_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(sfm_navigation_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sfm_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sfm_navigation
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sfm_navigation_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(sfm_navigation_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sfm_navigation)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sfm_navigation
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sfm_navigation_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(sfm_navigation_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sfm_navigation
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sfm_navigation_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(sfm_navigation_generate_messages_py geometry_msgs_generate_messages_py)
endif()
