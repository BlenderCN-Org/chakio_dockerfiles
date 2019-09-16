// Generated by gencpp from file printeps_hsr_modules/HsrOpenpose.msg
// DO NOT EDIT!


#ifndef PRINTEPS_HSR_MODULES_MESSAGE_HSROPENPOSE_H
#define PRINTEPS_HSR_MODULES_MESSAGE_HSROPENPOSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <printeps_hsr_modules/HsrPerson.h>

namespace printeps_hsr_modules
{
template <class ContainerAllocator>
struct HsrOpenpose_
{
  typedef HsrOpenpose_<ContainerAllocator> Type;

  HsrOpenpose_()
    : people()  {
    }
  HsrOpenpose_(const ContainerAllocator& _alloc)
    : people(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::printeps_hsr_modules::HsrPerson_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::printeps_hsr_modules::HsrPerson_<ContainerAllocator> >::other >  _people_type;
  _people_type people;





  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> const> ConstPtr;

}; // struct HsrOpenpose_

typedef ::printeps_hsr_modules::HsrOpenpose_<std::allocator<void> > HsrOpenpose;

typedef boost::shared_ptr< ::printeps_hsr_modules::HsrOpenpose > HsrOpenposePtr;
typedef boost::shared_ptr< ::printeps_hsr_modules::HsrOpenpose const> HsrOpenposeConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >::stream(s, "", v);
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
struct IsFixedSize< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a952aca51b6ba06cdce810f6825d8c74";
  }

  static const char* value(const ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa952aca51b6ba06cULL;
  static const uint64_t static_value2 = 0xdce810f6825d8c74ULL;
};

template<class ContainerAllocator>
struct DataType< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "printeps_hsr_modules/HsrOpenpose";
  }

  static const char* value(const ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
{
  static const char* value()
  {
    return "HsrPerson[] people\n\
================================================================================\n\
MSG: printeps_hsr_modules/HsrPerson\n\
\n\
geometry_msgs/Pose2D  pose\n\
float32 confidence\n\
bool    isHandUp\n\
================================================================================\n\
MSG: geometry_msgs/Pose2D\n\
# Deprecated\n\
# Please use the full 3D pose.\n\
\n\
# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.\n\
\n\
# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.\n\
\n\
\n\
# This expresses a position and orientation on a 2D manifold.\n\
\n\
float64 x\n\
float64 y\n\
float64 theta\n\
";
  }

  static const char* value(const ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.people);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct HsrOpenpose_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::printeps_hsr_modules::HsrOpenpose_<ContainerAllocator>& v)
  {
    s << indent << "people[]" << std::endl;
    for (size_t i = 0; i < v.people.size(); ++i)
    {
      s << indent << "  people[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::printeps_hsr_modules::HsrPerson_<ContainerAllocator> >::stream(s, indent + "    ", v.people[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // PRINTEPS_HSR_MODULES_MESSAGE_HSROPENPOSE_H