// Generated by gencpp from file printeps_hsr_modules/HsrHandoverObjectRequest.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTREQUEST_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTREQUEST_H


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
struct HsrHandoverObjectRequest_
{
  typedef HsrHandoverObjectRequest_<ContainerAllocator> Type;

  HsrHandoverObjectRequest_()
    : place_id()
    , object_name()  {
    }
  HsrHandoverObjectRequest_(const ContainerAllocator& _alloc)
    : place_id(_alloc)
    , object_name(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _place_id_type;
  _place_id_type place_id;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _object_name_type;
  _object_name_type object_name;





  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> const> ConstPtr;

}; // struct HsrHandoverObjectRequest_

typedef ::printeps_hsr_modules::HsrHandoverObjectRequest_<std::allocator<void> > HsrHandoverObjectRequest;

typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectRequest > HsrHandoverObjectRequestPtr;
typedef boost::shared_ptr< ::printeps_hsr_modules::HsrHandoverObjectRequest const> HsrHandoverObjectRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "706cfe91270acd70cd6241d4c52f63a8";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x706cfe91270acd70ULL;
  static const uint64_t static_value2 = 0xcd6241d4c52f63a8ULL;
};

template<class ContainerAllocator>
struct DataType< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "printeps_hsr_modules/HsrHandoverObjectRequest";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n\
string place_id\n\
string object_name\n\
";
  }

  static const char* value(const ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.place_id);
      stream.next(m.object_name);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct HsrHandoverObjectRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::printeps_hsr_modules::HsrHandoverObjectRequest_<ContainerAllocator>& v)
  {
    s << indent << "place_id: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.place_id);
    s << indent << "object_name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.object_name);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSRHANDOVEROBJECTREQUEST_H