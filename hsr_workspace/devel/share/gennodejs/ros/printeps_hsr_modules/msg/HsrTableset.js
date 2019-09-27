// Auto-generated. Do not edit!

// (in-package printeps_hsr_modules.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let HsrObstacle = require('./HsrObstacle.js');

//-----------------------------------------------------------

class HsrTableset {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.table = null;
      this.chairs = null;
    }
    else {
      if (initObj.hasOwnProperty('table')) {
        this.table = initObj.table
      }
      else {
        this.table = new HsrObstacle();
      }
      if (initObj.hasOwnProperty('chairs')) {
        this.chairs = initObj.chairs
      }
      else {
        this.chairs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrTableset
    // Serialize message field [table]
    bufferOffset = HsrObstacle.serialize(obj.table, buffer, bufferOffset);
    // Serialize message field [chairs]
    // Serialize the length for message field [chairs]
    bufferOffset = _serializer.uint32(obj.chairs.length, buffer, bufferOffset);
    obj.chairs.forEach((val) => {
      bufferOffset = HsrObstacle.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrTableset
    let len;
    let data = new HsrTableset(null);
    // Deserialize message field [table]
    data.table = HsrObstacle.deserialize(buffer, bufferOffset);
    // Deserialize message field [chairs]
    // Deserialize array length for message field [chairs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.chairs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.chairs[i] = HsrObstacle.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 28 * object.chairs.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'printeps_hsr_modules/HsrTableset';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '03ffed0b2ff00166a3c8658f40a325f8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    HsrObstacle     table
    HsrObstacle[]   chairs
    ================================================================================
    MSG: printeps_hsr_modules/HsrObstacle
    geometry_msgs/Pose2D  pose
    float32 width
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrTableset(null);
    if (msg.table !== undefined) {
      resolved.table = HsrObstacle.Resolve(msg.table)
    }
    else {
      resolved.table = new HsrObstacle()
    }

    if (msg.chairs !== undefined) {
      resolved.chairs = new Array(msg.chairs.length);
      for (let i = 0; i < resolved.chairs.length; ++i) {
        resolved.chairs[i] = HsrObstacle.Resolve(msg.chairs[i]);
      }
    }
    else {
      resolved.chairs = []
    }

    return resolved;
    }
};

module.exports = HsrTableset;
