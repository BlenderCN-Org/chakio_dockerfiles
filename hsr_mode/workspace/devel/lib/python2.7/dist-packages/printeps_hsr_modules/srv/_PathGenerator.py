# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from printeps_hsr_modules/PathGeneratorRequest.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import geometry_msgs.msg
import std_msgs.msg

class PathGeneratorRequest(genpy.Message):
  _md5sum = "6cfcca9441d2ae484b67236b2a34afde"
  _type = "printeps_hsr_modules/PathGeneratorRequest"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """
geometry_msgs/Pose2D    start
geometry_msgs/Pose2D    goal
geometry_msgs/PoseArray dynamicObstacle
std_msgs/Bool           multimodalPathplanning
std_msgs/Float64         voiceImportance

================================================================================
MSG: geometry_msgs/Pose2D
# Deprecated
# Please use the full 3D pose.

# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.

# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.


# This expresses a position and orientation on a 2D manifold.

float64 x
float64 y
float64 theta

================================================================================
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Bool
bool data
================================================================================
MSG: std_msgs/Float64
float64 data"""
  __slots__ = ['start','goal','dynamicObstacle','multimodalPathplanning','voiceImportance']
  _slot_types = ['geometry_msgs/Pose2D','geometry_msgs/Pose2D','geometry_msgs/PoseArray','std_msgs/Bool','std_msgs/Float64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       start,goal,dynamicObstacle,multimodalPathplanning,voiceImportance

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(PathGeneratorRequest, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.start is None:
        self.start = geometry_msgs.msg.Pose2D()
      if self.goal is None:
        self.goal = geometry_msgs.msg.Pose2D()
      if self.dynamicObstacle is None:
        self.dynamicObstacle = geometry_msgs.msg.PoseArray()
      if self.multimodalPathplanning is None:
        self.multimodalPathplanning = std_msgs.msg.Bool()
      if self.voiceImportance is None:
        self.voiceImportance = std_msgs.msg.Float64()
    else:
      self.start = geometry_msgs.msg.Pose2D()
      self.goal = geometry_msgs.msg.Pose2D()
      self.dynamicObstacle = geometry_msgs.msg.PoseArray()
      self.multimodalPathplanning = std_msgs.msg.Bool()
      self.voiceImportance = std_msgs.msg.Float64()

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_6d3I().pack(_x.start.x, _x.start.y, _x.start.theta, _x.goal.x, _x.goal.y, _x.goal.theta, _x.dynamicObstacle.header.seq, _x.dynamicObstacle.header.stamp.secs, _x.dynamicObstacle.header.stamp.nsecs))
      _x = self.dynamicObstacle.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      length = len(self.dynamicObstacle.poses)
      buff.write(_struct_I.pack(length))
      for val1 in self.dynamicObstacle.poses:
        _v1 = val1.position
        _x = _v1
        buff.write(_get_struct_3d().pack(_x.x, _x.y, _x.z))
        _v2 = val1.orientation
        _x = _v2
        buff.write(_get_struct_4d().pack(_x.x, _x.y, _x.z, _x.w))
      _x = self
      buff.write(_get_struct_Bd().pack(_x.multimodalPathplanning.data, _x.voiceImportance.data))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.start is None:
        self.start = geometry_msgs.msg.Pose2D()
      if self.goal is None:
        self.goal = geometry_msgs.msg.Pose2D()
      if self.dynamicObstacle is None:
        self.dynamicObstacle = geometry_msgs.msg.PoseArray()
      if self.multimodalPathplanning is None:
        self.multimodalPathplanning = std_msgs.msg.Bool()
      if self.voiceImportance is None:
        self.voiceImportance = std_msgs.msg.Float64()
      end = 0
      _x = self
      start = end
      end += 60
      (_x.start.x, _x.start.y, _x.start.theta, _x.goal.x, _x.goal.y, _x.goal.theta, _x.dynamicObstacle.header.seq, _x.dynamicObstacle.header.stamp.secs, _x.dynamicObstacle.header.stamp.nsecs,) = _get_struct_6d3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.dynamicObstacle.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.dynamicObstacle.header.frame_id = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.dynamicObstacle.poses = []
      for i in range(0, length):
        val1 = geometry_msgs.msg.Pose()
        _v3 = val1.position
        _x = _v3
        start = end
        end += 24
        (_x.x, _x.y, _x.z,) = _get_struct_3d().unpack(str[start:end])
        _v4 = val1.orientation
        _x = _v4
        start = end
        end += 32
        (_x.x, _x.y, _x.z, _x.w,) = _get_struct_4d().unpack(str[start:end])
        self.dynamicObstacle.poses.append(val1)
      _x = self
      start = end
      end += 9
      (_x.multimodalPathplanning.data, _x.voiceImportance.data,) = _get_struct_Bd().unpack(str[start:end])
      self.multimodalPathplanning.data = bool(self.multimodalPathplanning.data)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_6d3I().pack(_x.start.x, _x.start.y, _x.start.theta, _x.goal.x, _x.goal.y, _x.goal.theta, _x.dynamicObstacle.header.seq, _x.dynamicObstacle.header.stamp.secs, _x.dynamicObstacle.header.stamp.nsecs))
      _x = self.dynamicObstacle.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      length = len(self.dynamicObstacle.poses)
      buff.write(_struct_I.pack(length))
      for val1 in self.dynamicObstacle.poses:
        _v5 = val1.position
        _x = _v5
        buff.write(_get_struct_3d().pack(_x.x, _x.y, _x.z))
        _v6 = val1.orientation
        _x = _v6
        buff.write(_get_struct_4d().pack(_x.x, _x.y, _x.z, _x.w))
      _x = self
      buff.write(_get_struct_Bd().pack(_x.multimodalPathplanning.data, _x.voiceImportance.data))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.start is None:
        self.start = geometry_msgs.msg.Pose2D()
      if self.goal is None:
        self.goal = geometry_msgs.msg.Pose2D()
      if self.dynamicObstacle is None:
        self.dynamicObstacle = geometry_msgs.msg.PoseArray()
      if self.multimodalPathplanning is None:
        self.multimodalPathplanning = std_msgs.msg.Bool()
      if self.voiceImportance is None:
        self.voiceImportance = std_msgs.msg.Float64()
      end = 0
      _x = self
      start = end
      end += 60
      (_x.start.x, _x.start.y, _x.start.theta, _x.goal.x, _x.goal.y, _x.goal.theta, _x.dynamicObstacle.header.seq, _x.dynamicObstacle.header.stamp.secs, _x.dynamicObstacle.header.stamp.nsecs,) = _get_struct_6d3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.dynamicObstacle.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.dynamicObstacle.header.frame_id = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.dynamicObstacle.poses = []
      for i in range(0, length):
        val1 = geometry_msgs.msg.Pose()
        _v7 = val1.position
        _x = _v7
        start = end
        end += 24
        (_x.x, _x.y, _x.z,) = _get_struct_3d().unpack(str[start:end])
        _v8 = val1.orientation
        _x = _v8
        start = end
        end += 32
        (_x.x, _x.y, _x.z, _x.w,) = _get_struct_4d().unpack(str[start:end])
        self.dynamicObstacle.poses.append(val1)
      _x = self
      start = end
      end += 9
      (_x.multimodalPathplanning.data, _x.voiceImportance.data,) = _get_struct_Bd().unpack(str[start:end])
      self.multimodalPathplanning.data = bool(self.multimodalPathplanning.data)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_Bd = None
def _get_struct_Bd():
    global _struct_Bd
    if _struct_Bd is None:
        _struct_Bd = struct.Struct("<Bd")
    return _struct_Bd
_struct_4d = None
def _get_struct_4d():
    global _struct_4d
    if _struct_4d is None:
        _struct_4d = struct.Struct("<4d")
    return _struct_4d
_struct_6d3I = None
def _get_struct_6d3I():
    global _struct_6d3I
    if _struct_6d3I is None:
        _struct_6d3I = struct.Struct("<6d3I")
    return _struct_6d3I
_struct_3d = None
def _get_struct_3d():
    global _struct_3d
    if _struct_3d is None:
        _struct_3d = struct.Struct("<3d")
    return _struct_3d
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from printeps_hsr_modules/PathGeneratorResponse.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import geometry_msgs.msg
import std_msgs.msg

class PathGeneratorResponse(genpy.Message):
  _md5sum = "c7ff29b7398ee8a99244f49dd44eaeb9"
  _type = "printeps_hsr_modules/PathGeneratorResponse"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """geometry_msgs/PoseArray path
std_msgs/Float32 length

================================================================================
MSG: geometry_msgs/PoseArray
# An array of poses with a header for global reference.

Header header

Pose[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/Float32
float32 data"""
  __slots__ = ['path','length']
  _slot_types = ['geometry_msgs/PoseArray','std_msgs/Float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       path,length

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(PathGeneratorResponse, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.path is None:
        self.path = geometry_msgs.msg.PoseArray()
      if self.length is None:
        self.length = std_msgs.msg.Float32()
    else:
      self.path = geometry_msgs.msg.PoseArray()
      self.length = std_msgs.msg.Float32()

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.path.header.seq, _x.path.header.stamp.secs, _x.path.header.stamp.nsecs))
      _x = self.path.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      length = len(self.path.poses)
      buff.write(_struct_I.pack(length))
      for val1 in self.path.poses:
        _v9 = val1.position
        _x = _v9
        buff.write(_get_struct_3d().pack(_x.x, _x.y, _x.z))
        _v10 = val1.orientation
        _x = _v10
        buff.write(_get_struct_4d().pack(_x.x, _x.y, _x.z, _x.w))
      buff.write(_get_struct_f().pack(self.length.data))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.path is None:
        self.path = geometry_msgs.msg.PoseArray()
      if self.length is None:
        self.length = std_msgs.msg.Float32()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.path.header.seq, _x.path.header.stamp.secs, _x.path.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.path.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.path.header.frame_id = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.path.poses = []
      for i in range(0, length):
        val1 = geometry_msgs.msg.Pose()
        _v11 = val1.position
        _x = _v11
        start = end
        end += 24
        (_x.x, _x.y, _x.z,) = _get_struct_3d().unpack(str[start:end])
        _v12 = val1.orientation
        _x = _v12
        start = end
        end += 32
        (_x.x, _x.y, _x.z, _x.w,) = _get_struct_4d().unpack(str[start:end])
        self.path.poses.append(val1)
      start = end
      end += 4
      (self.length.data,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.path.header.seq, _x.path.header.stamp.secs, _x.path.header.stamp.nsecs))
      _x = self.path.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      length = len(self.path.poses)
      buff.write(_struct_I.pack(length))
      for val1 in self.path.poses:
        _v13 = val1.position
        _x = _v13
        buff.write(_get_struct_3d().pack(_x.x, _x.y, _x.z))
        _v14 = val1.orientation
        _x = _v14
        buff.write(_get_struct_4d().pack(_x.x, _x.y, _x.z, _x.w))
      buff.write(_get_struct_f().pack(self.length.data))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.path is None:
        self.path = geometry_msgs.msg.PoseArray()
      if self.length is None:
        self.length = std_msgs.msg.Float32()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.path.header.seq, _x.path.header.stamp.secs, _x.path.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.path.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.path.header.frame_id = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      self.path.poses = []
      for i in range(0, length):
        val1 = geometry_msgs.msg.Pose()
        _v15 = val1.position
        _x = _v15
        start = end
        end += 24
        (_x.x, _x.y, _x.z,) = _get_struct_3d().unpack(str[start:end])
        _v16 = val1.orientation
        _x = _v16
        start = end
        end += 32
        (_x.x, _x.y, _x.z, _x.w,) = _get_struct_4d().unpack(str[start:end])
        self.path.poses.append(val1)
      start = end
      end += 4
      (self.length.data,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3I = None
def _get_struct_3I():
    global _struct_3I
    if _struct_3I is None:
        _struct_3I = struct.Struct("<3I")
    return _struct_3I
_struct_f = None
def _get_struct_f():
    global _struct_f
    if _struct_f is None:
        _struct_f = struct.Struct("<f")
    return _struct_f
_struct_4d = None
def _get_struct_4d():
    global _struct_4d
    if _struct_4d is None:
        _struct_4d = struct.Struct("<4d")
    return _struct_4d
_struct_3d = None
def _get_struct_3d():
    global _struct_3d
    if _struct_3d is None:
        _struct_3d = struct.Struct("<3d")
    return _struct_3d
class PathGenerator(object):
  _type          = 'printeps_hsr_modules/PathGenerator'
  _md5sum = 'da86772c5496ba414c78c020ceee2035'
  _request_class  = PathGeneratorRequest
  _response_class = PathGeneratorResponse
