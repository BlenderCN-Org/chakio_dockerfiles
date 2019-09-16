// Auto-generated. Do not edit!

// (in-package printeps_hsr_modules.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let HsrPerson = require('./HsrPerson.js');

//-----------------------------------------------------------

class HsrOpenpose {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.people = null;
    }
    else {
      if (initObj.hasOwnProperty('people')) {
        this.people = initObj.people
      }
      else {
        this.people = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrOpenpose
    // Serialize message field [people]
    // Serialize the length for message field [people]
    bufferOffset = _serializer.uint32(obj.people.length, buffer, bufferOffset);
    obj.people.forEach((val) => {
      bufferOffset = HsrPerson.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrOpenpose
    let len;
    let data = new HsrOpenpose(null);
    // Deserialize message field [people]
    // Deserialize array length for message field [people]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.people = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.people[i] = HsrPerson.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 29 * object.people.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'printeps_hsr_modules/HsrOpenpose';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a952aca51b6ba06cdce810f6825d8c74';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    HsrPerson[] people
    ================================================================================
    MSG: printeps_hsr_modules/HsrPerson
    
    geometry_msgs/Pose2D  pose
    float32 confidence
    bool    isHandUp
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
    const resolved = new HsrOpenpose(null);
    if (msg.people !== undefined) {
      resolved.people = new Array(msg.people.length);
      for (let i = 0; i < resolved.people.length; ++i) {
        resolved.people[i] = HsrPerson.Resolve(msg.people[i]);
      }
    }
    else {
      resolved.people = []
    }

    return resolved;
    }
};

module.exports = HsrOpenpose;
