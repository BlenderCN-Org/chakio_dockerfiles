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

class HsrLogRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.log = null;
      this.IMU = null;
      this.LRF = null;
      this.Wrist = null;
      this.Joint = null;
      this.TF = null;
      this.mode = null;
    }
    else {
      if (initObj.hasOwnProperty('log')) {
        this.log = initObj.log
      }
      else {
        this.log = false;
      }
      if (initObj.hasOwnProperty('IMU')) {
        this.IMU = initObj.IMU
      }
      else {
        this.IMU = false;
      }
      if (initObj.hasOwnProperty('LRF')) {
        this.LRF = initObj.LRF
      }
      else {
        this.LRF = false;
      }
      if (initObj.hasOwnProperty('Wrist')) {
        this.Wrist = initObj.Wrist
      }
      else {
        this.Wrist = false;
      }
      if (initObj.hasOwnProperty('Joint')) {
        this.Joint = initObj.Joint
      }
      else {
        this.Joint = false;
      }
      if (initObj.hasOwnProperty('TF')) {
        this.TF = initObj.TF
      }
      else {
        this.TF = false;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrLogRequest
    // Serialize message field [log]
    bufferOffset = _serializer.bool(obj.log, buffer, bufferOffset);
    // Serialize message field [IMU]
    bufferOffset = _serializer.bool(obj.IMU, buffer, bufferOffset);
    // Serialize message field [LRF]
    bufferOffset = _serializer.bool(obj.LRF, buffer, bufferOffset);
    // Serialize message field [Wrist]
    bufferOffset = _serializer.bool(obj.Wrist, buffer, bufferOffset);
    // Serialize message field [Joint]
    bufferOffset = _serializer.bool(obj.Joint, buffer, bufferOffset);
    // Serialize message field [TF]
    bufferOffset = _serializer.bool(obj.TF, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.string(obj.mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrLogRequest
    let len;
    let data = new HsrLogRequest(null);
    // Deserialize message field [log]
    data.log = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [IMU]
    data.IMU = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [LRF]
    data.LRF = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [Wrist]
    data.Wrist = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [Joint]
    data.Joint = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [TF]
    data.TF = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mode.length;
    return length + 10;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrLogRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '909d8f5ca43dce61b7fd4795a8cbeef8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    bool log
    bool IMU
    bool LRF
    bool Wrist
    bool Joint
    bool TF
    string mode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrLogRequest(null);
    if (msg.log !== undefined) {
      resolved.log = msg.log;
    }
    else {
      resolved.log = false
    }

    if (msg.IMU !== undefined) {
      resolved.IMU = msg.IMU;
    }
    else {
      resolved.IMU = false
    }

    if (msg.LRF !== undefined) {
      resolved.LRF = msg.LRF;
    }
    else {
      resolved.LRF = false
    }

    if (msg.Wrist !== undefined) {
      resolved.Wrist = msg.Wrist;
    }
    else {
      resolved.Wrist = false
    }

    if (msg.Joint !== undefined) {
      resolved.Joint = msg.Joint;
    }
    else {
      resolved.Joint = false
    }

    if (msg.TF !== undefined) {
      resolved.TF = msg.TF;
    }
    else {
      resolved.TF = false
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = ''
    }

    return resolved;
    }
};

class HsrLogResponse {
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
    // Serializes a message object of type HsrLogResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrLogResponse
    let len;
    let data = new HsrLogResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrLogResponse';
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
    const resolved = new HsrLogResponse(null);
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
  Request: HsrLogRequest,
  Response: HsrLogResponse,
  md5sum() { return '9e0a21f8f1cdf5a53b46ee0aee2923c4'; },
  datatype() { return 'printeps_hsr_modules/HsrLog'; }
};
