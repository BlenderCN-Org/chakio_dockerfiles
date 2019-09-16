// Generated by gencpp from file printeps_hsr_modules/HsrHoldObject.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECT_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECT_H

#include <ros/service_traits.h>


#include <printeps_hsr_modules/HsrHoldObjectRequest.h>
#include <printeps_hsr_modules/HsrHoldObjectResponse.h>


namespace printeps_hsr_modules
{

struct HsrHoldObject
{

typedef HsrHoldObjectRequest Request;
typedef HsrHoldObjectResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct HsrHoldObject
} // namespace printeps_hsr_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_hsr_modules::HsrHoldObject > {
  static const char* value()
  {
    return "f676f5c1cafe9b38346686b35969df08";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHoldObject&) { return value(); }
};

template<>
struct DataType< ::printeps_hsr_modules::HsrHoldObject > {
  static const char* value()
  {
    return "printeps_hsr_modules/HsrHoldObject";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHoldObject&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_hsr_modules::HsrHoldObjectRequest> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrHoldObject > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrHoldObjectRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrHoldObject >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrHoldObjectRequest> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrHoldObject > 
template<>
struct DataType< ::printeps_hsr_modules::HsrHoldObjectRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrHoldObject >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_hsr_modules::HsrHoldObjectResponse> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrHoldObject > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrHoldObjectResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrHoldObject >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrHoldObjectResponse> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrHoldObject > 
template<>
struct DataType< ::printeps_hsr_modules::HsrHoldObjectResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrHoldObject >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECT_H
