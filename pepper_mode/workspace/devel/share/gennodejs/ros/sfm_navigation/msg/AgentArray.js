// Auto-generated. Do not edit!

// (in-package sfm_navigation.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Agent = require('./Agent.js');

//-----------------------------------------------------------

class AgentArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.agents = null;
    }
    else {
      if (initObj.hasOwnProperty('agents')) {
        this.agents = initObj.agents
      }
      else {
        this.agents = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AgentArray
    // Serialize message field [agents]
    // Serialize the length for message field [agents]
    bufferOffset = _serializer.uint32(obj.agents.length, buffer, bufferOffset);
    obj.agents.forEach((val) => {
      bufferOffset = Agent.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AgentArray
    let len;
    let data = new AgentArray(null);
    // Deserialize message field [agents]
    // Deserialize array length for message field [agents]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.agents = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.agents[i] = Agent.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 72 * object.agents.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sfm_navigation/AgentArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a42d8b787a4b74273a3d435730aaf001';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    sfm_navigation/Agent[] agents
    ================================================================================
    MSG: sfm_navigation/Agent
    geometry_msgs/Pose2D  pose
    geometry_msgs/Twist twist
    
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
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AgentArray(null);
    if (msg.agents !== undefined) {
      resolved.agents = new Array(msg.agents.length);
      for (let i = 0; i < resolved.agents.length; ++i) {
        resolved.agents[i] = Agent.Resolve(msg.agents[i]);
      }
    }
    else {
      resolved.agents = []
    }

    return resolved;
    }
};

module.exports = AgentArray;
