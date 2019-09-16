// Generated by gencpp from file printeps_hsr_modules/HsrGlbNav.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRGLBNAV_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRGLBNAV_H

#include <ros/service_traits.h>


#include <printeps_hsr_modules/HsrGlbNavRequest.h>
#include <printeps_hsr_modules/HsrGlbNavResponse.h>


namespace printeps_hsr_modules
{

struct HsrGlbNav
{

typedef HsrGlbNavRequest Request;
typedef HsrGlbNavResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct HsrGlbNav
} // namespace printeps_hsr_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_hsr_modules::HsrGlbNav > {
  static const char* value()
  {
    return "cfc42ebcb6ac1e961d822c446b9526a0";
  }

  static const char* value(const ::printeps_hsr_modules::HsrGlbNav&) { return value(); }
};

template<>
struct DataType< ::printeps_hsr_modules::HsrGlbNav > {
  static const char* value()
  {
    return "printeps_hsr_modules/HsrGlbNav";
  }

  static const char* value(const ::printeps_hsr_modules::HsrGlbNav&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_hsr_modules::HsrGlbNavRequest> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrGlbNav > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrGlbNavRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrGlbNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrGlbNavRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrGlbNavRequest> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrGlbNav > 
template<>
struct DataType< ::printeps_hsr_modules::HsrGlbNavRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrGlbNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrGlbNavRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_hsr_modules::HsrGlbNavResponse> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrGlbNav > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrGlbNavResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrGlbNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrGlbNavResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrGlbNavResponse> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrGlbNav > 
template<>
struct DataType< ::printeps_hsr_modules::HsrGlbNavResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrGlbNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrGlbNavResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRGLBNAV_H