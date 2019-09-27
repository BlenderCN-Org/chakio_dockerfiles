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

class HsrLogPRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.log = null;
      this.PCD = null;
      this.mode = null;
    }
    else {
      if (initObj.hasOwnProperty('log')) {
        this.log = initObj.log
      }
      else {
        this.log = false;
      }
      if (initObj.hasOwnProperty('PCD')) {
        this.PCD = initObj.PCD
      }
      else {
        this.PCD = false;
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
    // Serializes a message object of type HsrLogPRequest
    // Serialize message field [log]
    bufferOffset = _serializer.bool(obj.log, buffer, bufferOffset);
    // Serialize message field [PCD]
    bufferOffset = _serializer.bool(obj.PCD, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.string(obj.mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrLogPRequest
    let len;
    let data = new HsrLogPRequest(null);
    // Deserialize message field [log]
    data.log = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [PCD]
    data.PCD = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.mode.length;
    return length + 6;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrLogPRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b88fe43ad11f445b9f157d1b0449bf95';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    bool log
    bool PCD
    string mode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrLogPRequest(null);
    if (msg.log !== undefined) {
      resolved.log = msg.log;
    }
    else {
      resolved.log = false
    }

    if (msg.PCD !== undefined) {
      resolved.PCD = msg.PCD;
    }
    else {
      resolved.PCD = false
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

class HsrLogPResponse {
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
    // Serializes a message object of type HsrLogPResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrLogPResponse
    let len;
    let data = new HsrLogPResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrLogPResponse';
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
    const resolved = new HsrLogPResponse(null);
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
  Request: HsrLogPRequest,
  Response: HsrLogPResponse,
  md5sum() { return '3bab9c5fbe194c77b98025ec2f78083a'; },
  datatype() { return 'printeps_hsr_modules/HsrLogP'; }
};
