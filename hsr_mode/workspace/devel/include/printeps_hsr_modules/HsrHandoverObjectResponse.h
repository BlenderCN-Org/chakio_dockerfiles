// Generated by gencpp from file printeps_hsr_modules/HsrHandoverObjectResponse.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTRESPONSE_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace printeps_hsr_modules
{
template <class ContainerAllocator>
struct HsrHandoverObjectResponse_
{
  typedef HsrHandoverObjectResponse_<ContainerAllocator> Type;

  HsrHandoverObjectResponse_()
    : success(false)  {
    }
  HsrHandoverObjectResponse_(const ContainerAllocator& _alloc)
    : success(false)  {
  (void)_alloc;
    }



   typedef uint8_t _success_type;
  _success_type success;





  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> const> ConstPtr;

}; // struct HsrHandoverObjectResponse_

typedef ::printeps_hsr_modules::HsrHandoverObjectResponse_<std::allocator<void> > HsrHandoverObjectResponse;

typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectResponse > HsrHandoverObjectResponsePtr;
typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectResponse const> HsrHandoverObjectResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace printeps_hsr_modules

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'printeps_hsr_modules': ['/catkin_ws/src/printeps_hsr_modules/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "358e233cde0c8a8bcfea4ce193f8fc15";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x358e233cde0c8a8bULL;
  static const uint64_t static_value2 = 0xcfea4ce193f8fc15ULL;
};

template<class ContainerAllocator>
struct DataType< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "printeps_hsr_modules/HsrHandoverObjectResponse";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "bool success\n\
\n\
";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.success);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct HsrHandoverObjectResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::printeps_hsr_modules::HsrHandoverObjectResponse_<ContainerAllocator>& v)
  {
    s << indent << "success: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.success);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTRESPONSE_H
