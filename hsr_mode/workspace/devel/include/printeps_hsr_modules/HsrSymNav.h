// Generated by gencpp from file printeps_hsr_modules/HsrSymNav.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRSYMNAV_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRSYMNAV_H

#include <ros/service_traits.h>


#include <printeps_hsr_modules/HsrSymNavRequest.h>
#include <printeps_hsr_modules/HsrSymNavResponse.h>


namespace printeps_hsr_modules
{

struct HsrSymNav
{

typedef HsrSymNavRequest Request;
typedef HsrSymNavResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct HsrSymNav
} // namespace printeps_hsr_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_hsr_modules::HsrSymNav > {
  static const char* value()
  {
    return "a8b810758ea760dd74984f070e767d53";
  }

  static const char* value(const ::printeps_hsr_modules::HsrSymNav&) { return value(); }
};

template<>
struct DataType< ::printeps_hsr_modules::HsrSymNav > {
  static const char* value()
  {
    return "printeps_hsr_modules/HsrSymNav";
  }

  static const char* value(const ::printeps_hsr_modules::HsrSymNav&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_hsr_modules::HsrSymNavRequest> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrSymNav > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrSymNavRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrSymNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrSymNavRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrSymNavRequest> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrSymNav > 
template<>
struct DataType< ::printeps_hsr_modules::HsrSymNavRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrSymNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrSymNavRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_hsr_modules::HsrSymNavResponse> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrSymNav > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrSymNavResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrSymNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrSymNavResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrSymNavResponse> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrSymNav > 
template<>
struct DataType< ::printeps_hsr_modules::HsrSymNavResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrSymNav >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrSymNavResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRSYMNAV_H