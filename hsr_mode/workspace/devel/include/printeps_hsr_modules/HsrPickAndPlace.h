// Generated by gencpp from file printeps_hsr_modules/HsrPickAndPlace.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRPICKANDPLACE_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRPICKANDPLACE_H

#include <ros/service_traits.h>


#include <printeps_hsr_modules/HsrPickAndPlaceRequest.h>
#include <printeps_hsr_modules/HsrPickAndPlaceResponse.h>


namespace printeps_hsr_modules
{

struct HsrPickAndPlace
{

typedef HsrPickAndPlaceRequest Request;
typedef HsrPickAndPlaceResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct HsrPickAndPlace
} // namespace printeps_hsr_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_hsr_modules::HsrPickAndPlace > {
  static const char* value()
  {
    return "ad863b503ce673c2257d5090716e8cbd";
  }

  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlace&) { return value(); }
};

template<>
struct DataType< ::printeps_hsr_modules::HsrPickAndPlace > {
  static const char* value()
  {
    return "printeps_hsr_modules/HsrPickAndPlace";
  }

  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlace&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_hsr_modules::HsrPickAndPlaceRequest> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrPickAndPlace > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrPickAndPlaceRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrPickAndPlace >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlaceRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrPickAndPlaceRequest> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrPickAndPlace > 
template<>
struct DataType< ::printeps_hsr_modules::HsrPickAndPlaceRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrPickAndPlace >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlaceRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_hsr_modules::HsrPickAndPlaceResponse> should match 
// service_traits::MD5Sum< ::printeps_hsr_modules::HsrPickAndPlace > 
template<>
struct MD5Sum< ::printeps_hsr_modules::HsrPickAndPlaceResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_hsr_modules::HsrPickAndPlace >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlaceResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_hsr_modules::HsrPickAndPlaceResponse> should match 
// service_traits::DataType< ::printeps_hsr_modules::HsrPickAndPlace > 
template<>
struct DataType< ::printeps_hsr_modules::HsrPickAndPlaceResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_hsr_modules::HsrPickAndPlace >::value();
  }
  static const char* value(const ::printeps_hsr_modules::HsrPickAndPlaceResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRPICKANDPLACE_H
