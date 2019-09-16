// Auto-generated. Do not edit!

// (in-package printeps_hsr_modules.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class HsrCarry2017Request {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pose_B = null;
      this.pose_D = null;
    }
    else {
      if (initObj.hasOwnProperty('pose_B')) {
        this.pose_B = initObj.pose_B
      }
      else {
        this.pose_B = '';
      }
      if (initObj.hasOwnProperty('pose_D')) {
        this.pose_D = initObj.pose_D
      }
      else {
        this.pose_D = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrCarry2017Request
    // Serialize message field [pose_B]
    bufferOffset = _serializer.string(obj.pose_B, buffer, bufferOffset);
    // Serialize message field [pose_D]
    bufferOffset = _serializer.string(obj.pose_D, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrCarry2017Request
    let len;
    let data = new HsrCarry2017Request(null);
    // Deserialize message field [pose_B]
    data.pose_B = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [pose_D]
    data.pose_D = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.pose_B.length;
    length += object.pose_D.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrCarry2017Request';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9e9449a3264318b456993b7e3b0714d6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string  pose_B
    string  pose_D
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrCarry2017Request(null);
    if (msg.pose_B !== undefined) {
      resolved.pose_B = msg.pose_B;
    }
    else {
      resolved.pose_B = ''
    }

    if (msg.pose_D !== undefined) {
      resolved.pose_D = msg.pose_D;
    }
    else {
      resolved.pose_D = ''
    }

    return resolved;
    }
};

class HsrCarry2017Response {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrCarry2017Response
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrCarry2017Response
    let len;
    let data = new HsrCarry2017Response(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrCarry2017Response';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '358e233cde0c8a8bcfea4ce193f8fc15';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrCarry2017Response(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    return resolved;
    }
};

module.exports = {
  Request: HsrCarry2017Request,
  Response: HsrCarry2017Response,
  md5sum() { return '2dce38ab0b77cebc740f59d7c59f16d4'; },
  datatype() { return 'printeps_hsr_modules/HsrCarry2017'; }
};
