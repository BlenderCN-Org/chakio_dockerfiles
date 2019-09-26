// Generated by gencpp from file printeps_pepper_modules/PepperGlbNav.msg
// DO NOT EDIT!


#ifndef PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERGLBNAV_H
#define PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERGLBNAV_H

#include <ros/service_traits.h>


#include <printeps_pepper_modules/PepperGlbNavRequest.h>
#include <printeps_pepper_modules/PepperGlbNavResponse.h>


namespace printeps_pepper_modules
{

struct PepperGlbNav
{

typedef PepperGlbNavRequest Request;
typedef PepperGlbNavResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct PepperGlbNav
} // namespace printeps_pepper_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_pepper_modules::PepperGlbNav > {
  static const char* value()
  {
    return "cfc42ebcb6ac1e961d822c446b9526a0";
  }

  static const char* value(const ::printeps_pepper_modules::PepperGlbNav&) { return value(); }
};

template<>
struct DataType< ::printeps_pepper_modules::PepperGlbNav > {
  static const char* value()
  {
    return "printeps_pepper_modules/PepperGlbNav";
  }

  static const char* value(const ::printeps_pepper_modules::PepperGlbNav&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_pepper_modules::PepperGlbNavRequest> should match 
// service_traits::MD5Sum< ::printeps_pepper_modules::PepperGlbNav > 
template<>
struct MD5Sum< ::printeps_pepper_modules::PepperGlbNavRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_pepper_modules::PepperGlbNav >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperGlbNavRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_pepper_modules::PepperGlbNavRequest> should match 
// service_traits::DataType< ::printeps_pepper_modules::PepperGlbNav > 
template<>
struct DataType< ::printeps_pepper_modules::PepperGlbNavRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_pepper_modules::PepperGlbNav >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperGlbNavRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_pepper_modules::PepperGlbNavResponse> should match 
// service_traits::MD5Sum< ::printeps_pepper_modules::PepperGlbNav > 
template<>
struct MD5Sum< ::printeps_pepper_modules::PepperGlbNavResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_pepper_modules::PepperGlbNav >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperGlbNavResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_pepper_modules::PepperGlbNavResponse> should match 
// service_traits::DataType< ::printeps_pepper_modules::PepperGlbNav > 
template<>
struct DataType< ::printeps_pepper_modules::PepperGlbNavResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_pepper_modules::PepperGlbNav >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperGlbNavResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERGLBNAV_H
