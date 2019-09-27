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

class HsrPickAndPlaceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.object_place = null;
      this.destination = null;
      this.object_name = null;
    }
    else {
      if (initObj.hasOwnProperty('object_place')) {
        this.object_place = initObj.object_place
      }
      else {
        this.object_place = '';
      }
      if (initObj.hasOwnProperty('destination')) {
        this.destination = initObj.destination
      }
      else {
        this.destination = '';
      }
      if (initObj.hasOwnProperty('object_name')) {
        this.object_name = initObj.object_name
      }
      else {
        this.object_name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HsrPickAndPlaceRequest
    // Serialize message field [object_place]
    bufferOffset = _serializer.string(obj.object_place, buffer, bufferOffset);
    // Serialize message field [destination]
    bufferOffset = _serializer.string(obj.destination, buffer, bufferOffset);
    // Serialize message field [object_name]
    bufferOffset = _serializer.string(obj.object_name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrPickAndPlaceRequest
    let len;
    let data = new HsrPickAndPlaceRequest(null);
    // Deserialize message field [object_place]
    data.object_place = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [destination]
    data.destination = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [object_name]
    data.object_name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.object_place.length;
    length += object.destination.length;
    length += object.object_name.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrPickAndPlaceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4ecbda25f7c64408195ee8b5d6fcb8d4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string                object_place
    string                destination
    string                object_name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HsrPickAndPlaceRequest(null);
    if (msg.object_place !== undefined) {
      resolved.object_place = msg.object_place;
    }
    else {
      resolved.object_place = ''
    }

    if (msg.destination !== undefined) {
      resolved.destination = msg.destination;
    }
    else {
      resolved.destination = ''
    }

    if (msg.object_name !== undefined) {
      resolved.object_name = msg.object_name;
    }
    else {
      resolved.object_name = ''
    }

    return resolved;
    }
};

class HsrPickAndPlaceResponse {
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
    // Serializes a message object of type HsrPickAndPlaceResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HsrPickAndPlaceResponse
    let len;
    let data = new HsrPickAndPlaceResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'printeps_hsr_modules/HsrPickAndPlaceResponse';
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
    const resolved = new HsrPickAndPlaceResponse(null);
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
  Request: HsrPickAndPlaceRequest,
  Response: HsrPickAndPlaceResponse,
  md5sum() { return 'ad863b503ce673c2257d5090716e8cbd'; },
  datatype() { return 'printeps_hsr_modules/HsrPickAndPlace'; }
};
