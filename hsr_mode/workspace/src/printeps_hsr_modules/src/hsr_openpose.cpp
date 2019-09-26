#include <ros/ros.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <pcl_ros/io/pcd_io.h>

#include <sensor_msgs/image_encodings.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/WrenchStamped.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/Pose2D.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/JointState.h>



#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
#include <pcl/visualization/cloud_viewer.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <algorithm>
#include <limits>

#include <visualization_msgs/MarkerArray.h>
#include <sensor_msgs/point_cloud2_iterator.h>

#include <boost/thread/thread.hpp>
#include <pcl/common/common_headers.h>
#include <pcl/features/normal_3d.h>
#include <pcl/point_types.h>

#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>

#include "printeps_hsr_modules/HsrLog.h"
#include "printeps_hsr_modules/HsrOpenpose.h"
#include "printeps_hsr_modules/HsrPerson.h"

using namespace std;
class Joint
{
private:
    
public:
    Joint()
    {
        confidence=0;
        image_x=-1;
        image_y=-1;
    };
    void setup(int Num,geometry_msgs::PointStamped GlobalPosition,geometry_msgs::PointStamped LocalPosition, double Confidence,double Image_x,double Image_y )
    {
        num             = Num;
        globalPosition  = GlobalPosition;
        localPosition   = LocalPosition;
        confidence      = Confidence;
        image_x         = Image_x;
        image_y         = Image_y;
    }
    int                             num;
    geometry_msgs::PointStamped     globalPosition;//map座標系
    geometry_msgs::PointStamped     localPosition;//カメラ座標系
    double                          confidence;
    double                          image_x;
    double                          image_y;

};

class Person
{
private:
    double reliablityWeight[26]=
    {
        1,//鼻          //0
        1,//首          //1
        1,//右肩        //2
        0,//右肘        //3
        1,//右手首      //4
        1,//左肩        //5
        0,//左肘        //6
        1,//左手首      //7
        0,//真ん中尻    //8
        0,//右尻        //9
        0,//右膝        //10
        0,//右足首      //11
        0,//左尻        //12
        0,//左膝        //13
        0,//左足首      //14
        1,//右目        //15
        1,//左目        //16
        1,//右耳        //17
        1,//左耳        //18
        0,//左親指      //19
        0,//左小指      //20
        0,//左かかと    //21
        0,//右親指      //22
        0,//右小指      //23
        0,//右かかと    //24
        0,//background  //25
    };
    double poseWeight[26]=
    {
        1,//鼻          //0
        1,//首          //1
        1,//右肩        //2
        0,//右肘        //3
        0,//右手首      //4
        0,//左肩        //5
        0,//左肘        //6
        0,//左手首      //7
        0,//真ん中尻    //8
        0,//右尻        //9
        0,//右膝        //10
        0,//右足首      //11
        0,//左尻        //12
        0,//左膝        //13
        0,//左足首      //14
        0,//右目        //15
        0,//左目        //16
        0,//右耳        //17
        0,//左耳        //18
        0,//左親指      //19
        0,//左小指      //20
        0,//左かかと    //21
        0,//右親指      //22
        0,//右小指      //23
        0,//右かかと    //24
        0,//background  //25
    };
    geometry_msgs::Pose2D   pose;//人の位置
    double                  confidence;//認識信頼度
    bool                    isHandUp;//手を上げているかどうか

    void calculateConfidence()
    {
        double reliability=0;
        int jointsnum = 0;
        for(int jointNum=0;jointNum<26;jointNum++)//人のすべての関節にアクセス
        {
            
            jointsnum                   += reliablityWeight[jointNum];
            double distance             = sqrt(pow(joints[jointNum].localPosition.point.x,2)
                                            +pow(joints[jointNum].localPosition.point.y,2)
                                            +pow(joints[jointNum].localPosition.point.z,2));
            double jointReliability     = joints[jointNum].confidence/(1+0.285*pow(distance,2));//精度は距離の2乗の応じて減衰する
            reliability                 += jointReliability*reliablityWeight[jointNum];
            //cout<<distance<<endl;
                
        }
        confidence=reliability/jointsnum;
    }
    void calculatePose()
    {
        //関節位置の重心
        double wight=0;
        double tempX=0,tempY=0,tempZ=0;
        for(int jointNum=0;jointNum<26;jointNum++)//人のすべての関節にアクセス
        {
            if(joints[jointNum].confidence>0.1)
            {
                if(!isnan(joints[jointNum].globalPosition.point.x) &&  !isnan(joints[jointNum].globalPosition.point.y))
                {
                    tempX   +=  joints[jointNum].globalPosition.point.x*joints[jointNum].confidence*poseWeight[jointNum];
                    tempY   +=  joints[jointNum].globalPosition.point.y*joints[jointNum].confidence*poseWeight[jointNum];
                    
                    wight   +=  joints[jointNum].confidence*poseWeight[jointNum];
                }   
            }
        }
        pose.x=tempX/wight;
        pose.y=tempY/wight;

        //cout<<pose.x<<",   "<<pose.y<<endl;
    }
    void checkHandUp()
    {
        isHandUp=false;
        if(joints[1].image_x>-1 || joints[2].image_x>-1 ||joints[5].image_x>-1)
        {
            if(joints[4].image_x>-1 )
            {
                if(joints[4].image_x<joints[1].image_x || joints[4].image_x<joints[2].image_x || joints[4].image_x<joints[5].image_x)
                {
                    isHandUp=true;
                }
            }
            
            if(joints[7].image_x>-1 )
            {
                if(joints[7].image_x<joints[1].image_x || joints[7].image_x<joints[2].image_x || joints[7].image_x<joints[5].image_x)
                {
                    isHandUp=true;
                }
            }

            if(joints[3].image_x>-1 )
            {
                if(joints[3].image_x<joints[1].image_x || joints[3].image_x<joints[2].image_x || joints[3].image_x<joints[5].image_x)
                {
                    isHandUp=true;
                }
            }

            if(joints[6].image_x>-1 )
            {
                if(joints[6].image_x<joints[1].image_x || joints[6].image_x<joints[2].image_x || joints[6].image_x<joints[5].image_x)
                {
                    isHandUp=true;
                }
            }
            
            
        }
        //cout<<"isHandUP "<<isHandUp<<endl;
        //cout<<"neck:"<<joints[1].image_x <<"    rightHand:"<<joints[4].image_x<<"   leftHand:"<<joints[7].image_x<<endl;
    }
    
public:
    Joint                   joints[26];//ジョイントの名前、位置、信頼度
    Person()
    {

    }
    void setPerson(vector<Joint> Joints)
    {
        //setJoints
        for(int i=0; i<Joints.size();i++)
        {
            joints[Joints[i].num]=Joints[i];
        }
        this->calculateConfidence();
        this->calculatePose();
        this->checkHandUp();
    }
    geometry_msgs::Pose2D getPose()
    {
        return pose;
    }
    double getConfidence()
    {
        return confidence;   
    }
    bool getHandUp()
    {
        return isHandUp;
    }
};
class HsrOpenpose
{
private:
  ros::NodeHandle                                       _nh;
  ros::Publisher pubJoint                             = _nh.advertise<geometry_msgs::PoseArray> ("hsr_openpose", 4);
  ros::Publisher pubHumanPos                          = _nh.advertise<visualization_msgs::Marker>("hsr_observed_people_marker",4);
  ros::Publisher pubOpenpose                          = _nh.advertise<printeps_hsr_modules::HsrOpenpose>("hsr_observed_people",4);
  ros::Subscriber sub_openpose                        = _nh.subscribe("/hsr_openpose_joints",1,&HsrOpenpose::getOpenpose,this);
  tf::TransformListener tflistener;

  vector <Person> observedPeople; 
public:
  HsrOpenpose()
  {
    
  }
  void getOpenpose(const sensor_msgs::PointCloud2ConstPtr &cloud1)
  {
      sensor_msgs::PointCloud2 output;
      // Do data processing here...
      output = *cloud1;
      sensor_msgs::PointCloud2Iterator<float> iter_x(output, "x");
      sensor_msgs::PointCloud2Iterator<float> iter_y(output, "y");
      sensor_msgs::PointCloud2Iterator<float> iter_z(output, "z");
      sensor_msgs::PointCloud2Iterator<float> iter_person_num(output, "person_num");
      sensor_msgs::PointCloud2Iterator<float> iter_joint_num(output, "joint_num");
      sensor_msgs::PointCloud2Iterator<float> iter_confidence(output, "confidence");
      sensor_msgs::PointCloud2Iterator<float> iter_image_x(output, "image_x");
      sensor_msgs::PointCloud2Iterator<float> iter_image_y(output, "image_y");
      ros::Time rosTime=output.header.stamp;
      geometry_msgs::PoseArray poseArray;
      poseArray.header.frame_id="map";
      int peopleNum=-1;
      observedPeople.clear();
      vector <Joint> joints;
      for (; iter_x != iter_x.end(); ++iter_x, ++iter_y, ++iter_z,++iter_person_num,++iter_joint_num,++iter_confidence,++iter_image_x,++iter_image_y)
      {
          if(peopleNum<*iter_person_num)
          {
              if(peopleNum!=-1)
              {
                  Person observedPerson;
                  observedPerson.setPerson(joints);
                  observedPeople.push_back(observedPerson);
              }
              joints.clear();
              peopleNum=*iter_person_num;
          }

          //cout<<*iter_person_num<<","<<*iter_joint_num<<","<<*iter_x<<","<<*iter_y<<","<<*iter_z <<","<<*iter_confidence<<endl;
          geometry_msgs::PointStamped localPosition;
          double Confidence;
          if(! isnan(*iter_x) && ! isnan(*iter_y) && ! isnan(*iter_z))
          {
              Confidence                      = *iter_confidence;
              localPosition.header.frame_id   = "/camera_rgb_optical_frame";
              localPosition.point.x           = *iter_x;
              localPosition.point.y           = *iter_y;
              localPosition.point.z           = *iter_z;
          }
          else
          {
              Confidence                      = 0;
              localPosition.header.frame_id   = "/camera_rgb_optical_frame";
              localPosition.point.x           = 0;
              localPosition.point.y           = 0;
              localPosition.point.z           = 0;
          }
          geometry_msgs::PointStamped globalPosition;
          try
          {
              tflistener.waitForTransform("/map", "/camera_rgb_optical_frame",  rosTime, ros::Duration(3.0));
              tflistener.transformPoint("/map",rosTime,localPosition,"/camera_rgb_optical_frame",globalPosition);
              Joint joint;
              joint.setup((int)*iter_joint_num,globalPosition,localPosition,Confidence,*iter_image_x,*iter_image_y);
              joints.push_back(joint);
              geometry_msgs::Pose pose;
              pose.position = globalPosition.point;
              poseArray.poses.push_back(pose);
          }
          catch(tf::TransformException ex)
          {
              ROS_ERROR("%s",ex.what());
              try
              {
                  tflistener.waitForTransform("/map", "/camera_rgb_optical_frame",  rosTime, ros::Duration(3.0));
                  tflistener.transformPoint("/map",localPosition,globalPosition);
                  Joint joint;
                  joint.setup((int)*iter_joint_num,globalPosition,localPosition,Confidence,*iter_image_x,*iter_image_y);
                  joints.push_back(joint);
                  
                  geometry_msgs::Pose pose;
                  pose.position = globalPosition.point;
                  poseArray.poses.push_back(pose);
              }
              catch(tf::TransformException ex)
              {
                  cout<<"==openpose TF Error=="<<endl;
                  ROS_ERROR("%s",ex.what());
              }
          }
          
      }
      if(joints.size()>0)
      {
          Person observedPerson;
          printeps_hsr_modules::HsrOpenpose openpose;
          observedPerson.setPerson(joints);
          observedPeople.push_back(observedPerson);
          
          for(int i=0;i<observedPeople.size();i++)
          {
              for(int j=0;j<26;j++)
              {
                  //cout<<i<<" :"<<j<<" :"<<observedPeople[i].joints[j].confidence<<endl;
              }
              cout<<"Recongition Reliability  :"<<observedPeople[i].getConfidence()<<endl;
              visualization_msgs::Marker tablePanel;

              tablePanel.header.frame_id="map";
              tablePanel.header.stamp=ros::Time::now();
              tablePanel.pose.position.x=observedPeople[i].getPose().x;
              tablePanel.pose.position.y=observedPeople[i].getPose().y;
              tablePanel.pose.position.z=0.6;

              tablePanel.ns = "human";
              tablePanel.id = i;
              tablePanel.type = visualization_msgs::Marker::CYLINDER;
              tablePanel.action = visualization_msgs::Marker::ADD;

              tablePanel.scale.x = 0.3;
              tablePanel.scale.y = 0.3;
              tablePanel.scale.z = 1.2;

              if(observedPeople[i].getHandUp())
              {
                  tablePanel.color.r = (float)255/255;
                  tablePanel.color.g = (float)0/255;
                  tablePanel.color.b = (float)0/255;
                  tablePanel.color.a = 1.0;
              }
              else
              {
                  tablePanel.color.r = (float)157/255;
                  tablePanel.color.g = (float)204/255;
                  tablePanel.color.b = (float)224/255;
                  tablePanel.color.a = 1.0;
              }

              tablePanel.lifetime = ros::Duration(1);

              pubHumanPos.publish(tablePanel);

              printeps_hsr_modules::HsrPerson person;
              person.pose.x=observedPeople[i].getPose().x;
              person.pose.y=observedPeople[i].getPose().y;
              person.confidence=observedPeople[i].getConfidence();
              person.isHandUp=observedPeople[i].getHandUp();

              openpose.people.push_back(person);
          }          
          pubOpenpose.publish(openpose);
      }
      //pubJoint.publish(poseArray);
      
  }
};

int main(int argc, char **argv)
{
  ros::init(argc, argv, "hsr_openpose");
 
  HsrOpenpose hsropenpose;
  
  ros::spin();
}
