// Auto-generated. Do not edit!

// (in-package printeps_hsr_modules.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class PathGeneratorRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.start = null;
      this.goal = null;
      this.dynamicObstacle = null;
      this.multimodalPathplanning = null;
      this.voiceImportance = null;
    }
    else {
      if (initObj.hasOwnProperty('start')) {
        this.start = initObj.start
      }
      else {
        this.start = new geometry_msgs.msg.Pose2D();
      }
      if (initObj.hasOwnProperty('goal')) {
        this.goal = initObj.goal
      }
      else {
        this.goal = new geometry_msgs.msg.Pose2D();
      }
      if (initObj.hasOwnProperty('dynamicObstacle')) {
        this.dynamicObstacle = initObj.dynamicObstacle
      }
      else {
        this.dynamicObstacle = new geometry_msgs.msg.PoseArray();
      }
      if (initObj.hasOwnProperty('multimodalPathplanning')) {
        this.multimodalPathplanning = initObj.multimodalPathplanning
      }
      else {
        this.multimodalPathplanning = new std_msgs.msg.Bool();
      }
      if (initObj.hasOwnProperty('voiceImportance')) {
        this.voiceImportance = initObj.voiceImportance
      }
      else {
        this.voiceImportance = new std_msgs.msg.Float64();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathGeneratorRequest
    // Serialize message field [start]
    bufferOffset = geometry_msgs.msg.Pose2D.serialize(obj.start, buffer, bufferOffset);
    // Serialize message field [goal]
    bufferOffset = geometry_msgs.msg.Pose2D.serialize(obj.goal, buffer, bufferOffset);
    // Serialize message field [dynamicObstacle]
    bufferOffset = geometry_msgs.msg.PoseArray.serialize(obj.dynamicObstacle, buffer, bufferOffset);
    // Serialize message field [multimodalPathplanning]
    bufferOffset = std_msgs.msg.Bool.serialize(obj.multimodalPathplanning, buffer, bufferOffset);
    // Serialize message field [voiceImportance]
    bufferOffset = std_msgs.msg.Float64.serialize(obj.voiceImportance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathGeneratorRequest
    let len;
    let data = new PathGeneratorRequest(null);
    // Deserialize message field [start]
    data.start = geometry_msgs.msg.Pose2D.deserialize(buffer, bufferOffset);
    // Deserialize message field [goal]
    data.goal = geometry_msgs.msg.Pose2D.deserialize(buffer, bufferOffset);
    // Deserialize message field [dynamicObstacle]
    data.dynamicObstacle = geometry_msgs.msg.PoseArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [multimodalPathplanning]
    data.multimodalPathplanning = std_msgs.msg.Bool.deserialize(buffer, bufferOffset);
    // Deserialize message field [voiceImportance]
    data.voiceImportance = std_msgs.msg.Float64.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseArray.getMessageSize(object.dynamicObstacle);
    return length + 57;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/PathGeneratorRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6cfcca9441d2ae484b67236b2a34afde';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
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
    float64 data
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PathGeneratorRequest(null);
    if (msg.start !== undefined) {
      resolved.start = geometry_msgs.msg.Pose2D.Resolve(msg.start)
    }
    else {
      resolved.start = new geometry_msgs.msg.Pose2D()
    }

    if (msg.goal !== undefined) {
      resolved.goal = geometry_msgs.msg.Pose2D.Resolve(msg.goal)
    }
    else {
      resolved.goal = new geometry_msgs.msg.Pose2D()
    }

    if (msg.dynamicObstacle !== undefined) {
      resolved.dynamicObstacle = geometry_msgs.msg.PoseArray.Resolve(msg.dynamicObstacle)
    }
    else {
      resolved.dynamicObstacle = new geometry_msgs.msg.PoseArray()
    }

    if (msg.multimodalPathplanning !== undefined) {
      resolved.multimodalPathplanning = std_msgs.msg.Bool.Resolve(msg.multimodalPathplanning)
    }
    else {
      resolved.multimodalPathplanning = new std_msgs.msg.Bool()
    }

    if (msg.voiceImportance !== undefined) {
      resolved.voiceImportance = std_msgs.msg.Float64.Resolve(msg.voiceImportance)
    }
    else {
      resolved.voiceImportance = new std_msgs.msg.Float64()
    }

    return resolved;
    }
};

class PathGeneratorResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.path = null;
      this.length = null;
    }
    else {
      if (initObj.hasOwnProperty('path')) {
        this.path = initObj.path
      }
      else {
        this.path = new geometry_msgs.msg.PoseArray();
      }
      if (initObj.hasOwnProperty('length')) {
        this.length = initObj.length
      }
      else {
        this.length = new std_msgs.msg.Float32();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PathGeneratorResponse
    // Serialize message field [path]
    bufferOffset = geometry_msgs.msg.PoseArray.serialize(obj.path, buffer, bufferOffset);
    // Serialize message field [length]
    bufferOffset = std_msgs.msg.Float32.serialize(obj.length, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PathGeneratorResponse
    let len;
    let data = new PathGeneratorResponse(null);
    // Deserialize message field [path]
    data.path = geometry_msgs.msg.PoseArray.deserialize(buffer, bufferOffset);
    // Deserialize message field [length]
    data.length = std_msgs.msg.Float32.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseArray.getMessageSize(object.path);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/PathGeneratorResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c7ff29b7398ee8a99244f49dd44eaeb9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/PoseArray path
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
    float32 data
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PathGeneratorResponse(null);
    if (msg.path !== undefined) {
      resolved.path = geometry_msgs.msg.PoseArray.Resolve(msg.path)
    }
    else {
      resolved.path = new geometry_msgs.msg.PoseArray()
    }

    if (msg.length !== undefined) {
      resolved.length = std_msgs.msg.Float32.Resolve(msg.length)
    }
    else {
      resolved.length = new std_msgs.msg.Float32()
    }

    return resolved;
    }
};

module.exports = {
  Request: PathGeneratorRequest,
  Response: PathGeneratorResponse,
  md5sum() { return 'da86772c5496ba414c78c020ceee2035'; },
  datatype() { return 'printeps_hsr_modules/PathGenerator'; }
};
