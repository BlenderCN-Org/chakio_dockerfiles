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

class HsrCarryRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.destination = null;
    }
    else {
      if (initObj.hasOwnProperty('destination')) {
        this.destination = initObj.destination
      }
      else {
        this.destination = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrCarryRequest
    // Serialize message field [destination]
    bufferOffset = _serializer.string(obj.destination, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrCarryRequest
    let len;
    let data = new HsrCarryRequest(null);
    // Deserialize message field [destination]
    data.destination = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.destination.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrCarryRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8e47796db9d7d90bff30cd181ffc714b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string  destination
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrCarryRequest(null);
    if (msg.destination !== undefined) {
      resolved.destination = msg.destination;
    }
    else {
      resolved.destination = ''
    }

    return resolved;
    }
};

class HsrCarryResponse {
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
    // Serializes a message object of type HsrCarryResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrCarryResponse
    let len;
    let data = new HsrCarryResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrCarryResponse';
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
    const resolved = new HsrCarryResponse(null);
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
  Request: HsrCarryRequest,
  Response: HsrCarryResponse,
  md5sum() { return 'a8b810758ea760dd74984f070e767d53'; },
  datatype() { return 'printeps_hsr_modules/HsrCarry'; }
};
