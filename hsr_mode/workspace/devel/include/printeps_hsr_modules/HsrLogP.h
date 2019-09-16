// Generated by gencpp from file printeps_hsr_modules/HsrLogP.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRLOGP_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRLOGP_H

#include <ros/service_traits.h>


#include <printeps_hsr_modules/HsrLogPRequest.h>
#include <printeps_hsr_modules/HsrLogPResponse.h>


namespace printeps_hsr_modules
{

struct HsrLogP
{

typedef HsrLogPRequest Request;
typedef HsrLogPResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct HsrLogP
} // namespace printeps_hsr_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_hsr_modules::HsrLogP > {
  static const char* value()
  {
    return "3bab9c5fbe194c77b98025ec2f78083a";
  }

  static const char* value(const ::printeps_hsr_modules::HsrLogP&) { return value(); }
};

template<>
struct DataType< ::printeps_hsr_modules::HsrLogP > {
  static const char* value()
  {
    return "printeps_hsr_modules/HsrLogP";
  }

  static const char* value(const ::printeps_hsr_modules::HsrLogP&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_hsr_modules::HsrLogPRequest> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrLogP > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrLogPRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrLogP >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrLogPRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrLogPRequest> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrLogP > 
template<>
struct DataType< ::printeps_hsr_modules::HsrLogPRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrLogP >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrLogPRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_hsr_modules::HsrLogPResponse> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrLogP > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrLogPResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrLogP >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrLogPResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrLogPResponse> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrLogP > 
template<>
struct DataType< ::printeps_hsr_modules::HsrLogPResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrLogP >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrLogPResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRLOGP_H