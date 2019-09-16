// Generated by gencpp from file printeps_hsr_modules/HsrHoldObjectRequest.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECTREQUEST_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECTREQUEST_H


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
struct HsrHoldObjectRequest_
{
  typedef HsrHoldObjectRequest_<ContainerAllocator> Type;

  HsrHoldObjectRequest_()
    : place_id()  {
    }
  HsrHoldObjectRequest_(const ContainerAllocator& _alloc)
    : place_id(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _place_id_type;
  _place_id_type place_id;





  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> const> ConstPtr;

}; // struct HsrHoldObjectRequest_

typedef ::printeps_hsr_modules::HsrHoldObjectRequest_<std::allocator<void> > HsrHoldObjectRequest;

typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHoldObjectRequest > HsrHoldObjectRequestPtr;
typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHoldObjectRequest const> HsrHoldObjectRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace printeps_hsr_modules

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'printeps_hsr_modules': ['/catkin_ws/src/printeps_hsr_modules/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b2b2fe2902ce27f4a55c6801378ebbb8";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb2b2fe2902ce27f4ULL;
  static const uint64_t static_value2 = 0xa55c6801378ebbb8ULL;
};

template<class ContainerAllocator>
struct DataType< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "printeps_hsr_modules/HsrHoldObjectRequest";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
string place_id\n\
";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.place_id);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct HsrHoldObjectRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::printeps_hsr_modules::HsrHoldObjectRequest_<ContainerAllocator>& v)
  {
    s << indent << "place_id: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.place_id);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRHOLDOBJECTREQUEST_H