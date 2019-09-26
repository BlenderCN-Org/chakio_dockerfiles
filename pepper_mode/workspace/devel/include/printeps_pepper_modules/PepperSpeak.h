// Generated by gencpp from file printeps_pepper_modules/PepperSpeak.msg
// DO NOT EDIT!


#ifndef PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERSPEAK_H
#define PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERSPEAK_H

#include <ros/service_traits.h>


#include <printeps_pepper_modules/PepperSpeakRequest.h>
#include <printeps_pepper_modules/PepperSpeakResponse.h>


namespace printeps_pepper_modules
{

struct PepperSpeak
{

typedef PepperSpeakRequest Request;
typedef PepperSpeakResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct PepperSpeak
} // namespace printeps_pepper_modules


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::printeps_pepper_modules::PepperSpeak > {
  static const char* value()
  {
    return "4a951ed513207e655699b507ebeda279";
  }

  static const char* value(const ::printeps_pepper_modules::PepperSpeak&) { return value(); }
};

template<>
struct DataType< ::printeps_pepper_modules::PepperSpeak > {
  static const char* value()
  {
    return "printeps_pepper_modules/PepperSpeak";
  }

  static const char* value(const ::printeps_pepper_modules::PepperSpeak&) { return value(); }
};


// service_traits::MD5Sum< ::printeps_pepper_modules::PepperSpeakRequest> should match 
// service_traits::MD5Sum< ::printeps_pepper_modules::PepperSpeak > 
template<>
struct MD5Sum< ::printeps_pepper_modules::PepperSpeakRequest>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_pepper_modules::PepperSpeak >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperSpeakRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_pepper_modules::PepperSpeakRequest> should match 
// service_traits::DataType< ::printeps_pepper_modules::PepperSpeak > 
template<>
struct DataType< ::printeps_pepper_modules::PepperSpeakRequest>
{
  static const char* value()
  {
    return DataType< ::printeps_pepper_modules::PepperSpeak >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperSpeakRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::printeps_pepper_modules::PepperSpeakResponse> should match 
// service_traits::MD5Sum< ::printeps_pepper_modules::PepperSpeak > 
template<>
struct MD5Sum< ::printeps_pepper_modules::PepperSpeakResponse>
{
  static const char* value()
  {
    return MD5Sum< ::printeps_pepper_modules::PepperSpeak >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperSpeakResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::printeps_pepper_modules::PepperSpeakResponse> should match 
// service_traits::DataType< ::printeps_pepper_modules::PepperSpeak > 
template<>
struct DataType< ::printeps_pepper_modules::PepperSpeakResponse>
{
  static const char* value()
  {
    return DataType< ::printeps_pepper_modules::PepperSpeak >::value();
  }
  static const char* value(const ::printeps_pepper_modules::PepperSpeakResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // PRINTEPS_PEPPER_MODULES_MESSAGE_PEPPERSPEAK_H