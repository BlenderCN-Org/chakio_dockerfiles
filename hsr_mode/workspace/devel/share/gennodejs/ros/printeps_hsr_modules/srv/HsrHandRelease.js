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

class HsrHandReleaseRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.place_id = null;
    }
    else {
      if (initObj.hasOwnProperty('place_id')) {
        this.place_id = initObj.place_id
      }
      else {
        this.place_id = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrHandReleaseRequest
    // Serialize message field [place_id]
    bufferOffset = _serializer.string(obj.place_id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrHandReleaseRequest
    let len;
    let data = new HsrHandReleaseRequest(null);
    // Deserialize message field [place_id]
    data.place_id = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.place_id.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrHandReleaseRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b2b2fe2902ce27f4a55c6801378ebbb8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string place_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrHandReleaseRequest(null);
    if (msg.place_id !== undefined) {
      resolved.place_id = msg.place_id;
    }
    else {
      resolved.place_id = ''
    }

    return resolved;
    }
};

class HsrHandReleaseResponse {
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
    // Serializes a message object of type HsrHandReleaseResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrHandReleaseResponse
    let len;
    let data = new HsrHandReleaseResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrHandReleaseResponse';
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
    const resolved = new HsrHandReleaseResponse(null);
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
  Request: HsrHandReleaseRequest,
  Response: HsrHandReleaseResponse,
  md5sum() { return 'f676f5c1cafe9b38346686b35969df08'; },
  datatype() { return 'printeps_hsr_modules/HsrHandRelease'; }
};
