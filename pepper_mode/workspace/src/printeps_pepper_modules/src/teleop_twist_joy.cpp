#include <ros/ros.h>
#include <sensor_msgs/Joy.h>
#include <geometry_msgs/Twist.h>


//=======================================================================
//    JoyTwistクラス
//=======================================================================
class JoyTwist{
public:
  //---------------------------------------------------------------------
  // 変数群
  //---------------------------------------------------------------------
  ros::NodeHandle       node;
  ros::Subscriber       joy_sub;    // ジョイスティック情報サブスクライバ
  ros::Publisher        twist_pub;  // Twist情報パブリッシャ

  geometry_msgs::Twist  twist;
  double                vel_max;    // 最大並進速度 [m/s]
  double                omg_max;    // 最大回転速度 [rad/s]


  //---------------------------------------------------------------------
  // コンストラクタ
  //---------------------------------------------------------------------
  JoyTwist(){
    // パラメータ初期化（launchファイルで設定）
    vel_max         = 0.2;
    omg_max         = 0.3;
    node.param("linear_speed_max", vel_max, vel_max);
    node.param("angular_speed_max", omg_max, omg_max);

    // サブスクライブするトピックの定義
    joy_sub   = node.subscribe("joy", 1, &JoyTwist::joyCallback, this);

    // パブリッシュするトピックの定義
    twist_pub = node.advertise<geometry_msgs::Twist>("cmd_vel", 1);
  }

  //---------------------------------------------------------------------
  // コールバック関数
  //---------------------------------------------------------------------
  void joyCallback(const sensor_msgs::Joy &in_joy_msg){
    twist.linear.x  = 0.0;
    twist.linear.y  = 0.0;
    twist.linear.z  = 0.0;
    twist.angular.x = 0.0;
    twist.angular.y = 0.0;
    twist.angular.z = 0.0;

    // 並進運動
    // ※ボタン１を押していないと移動しない
    if(in_joy_msg.buttons[0] == 1){
      twist.linear.x  = in_joy_msg.axes[1] * vel_max; // 前後
      twist.linear.y  = in_joy_msg.axes[0] * vel_max; // 左右
    }

    // 回転運動
    // 半時計回り
    if(in_joy_msg.buttons[4] == 1 && in_joy_msg.buttons[5] == 0){
      twist.angular.z = omg_max;
    }
    // 時計回り
    else if(in_joy_msg.buttons[4] == 0 && in_joy_msg.buttons[5] == 1){
      twist.angular.z = -omg_max;
    }

    // パブリッシュ
    twist_pub.publish(twist);
  }

};


//=======================================================================
//    main関数
//=======================================================================
int main(int argc, char **argv)
{
  ros::init(argc, argv, "teleop_twist_joy");
  JoyTwist  joy_twist;
  ros::spin();
}
