#!/usr/bin/env python
# coding: utf-8


import printeps.exceptions
import threading
import printeps_hsr_modules.srv
import rospy
import time

glorder2_service_pos=''
glcart_ini_pos=''
glservice_table=''
glorder1_cart_pos=''
glorder1_service_pos=''
glorder1_ini_pos=''
glorder1_name=''
glorder2_cart_pos=''
glorder2_name=''
glorder2_ini_pos=''

class service_ROOT:
   display_name='ROOTサービス'
   display_id='ROOT'
   def __init__(self):
     self.data=dict()

   def execute(self):
     proc0002=service_d1ea20f2_dbaf_4ed1_8250_d8f74f357e53()
     proc0004=service_117293fb_e0e3_42e8_8431_aac582f2ca25()

     did='07b1af30-cc67-4087-87a6-0e45de1365eb';dnm='HSR注文物の設定'
     rospy.loginfo('PRE [07b1af30-cc67-4087-87a6-0e45de1365eb(HSR注文物の設定),ROOT]')
     def proc0004_o1(arg0004_o1):
       did='8ff3211b-9874-427e-afb3-eec8d6805aa0';dnm='ペットボトルをカートで配膳'
       rospy.loginfo('PRE [8ff3211b-9874-427e-afb3-eec8d6805aa0(ペットボトルをカートで配膳),ROOT]')
       def proc0002_o1(arg0002_o1):
         did='O';dnm='終了'
         rospy.loginfo('PRE [O(終了),ROOT]')
         rospy.loginfo('PST [O(終了),ROOT]')
       proc0002.data={}
       proc0002.outputs=[proc0002_o1]
       proc0002.execute_i1([lambda :arg0004_o1])
       rospy.loginfo('PST [8ff3211b-9874-427e-afb3-eec8d6805aa0(ペットボトルをカートで配膳),ROOT]')
     proc0004.data={}
     proc0004.outputs=[proc0004_o1]
     proc0004.execute_i1([lambda :None])
     rospy.loginfo('PST [07b1af30-cc67-4087-87a6-0e45de1365eb(HSR注文物の設定),ROOT]')


class service_6fae1b3b_a7bf_4617_a82e_8d7d5c6bed97:
   display_name='HSR基本動作'
   display_id='6fae1b3b-a7bf-4617-a82e-8d7d5c6bed97'
   def get_o0(self):
     return self.proc0008_o0
   const0006='こんにちは'
   def __init__(self):
     self.data=dict()
     self.proc0008_o0=None

   def execute_i1(self,inputs):
     proc0008=process_35b06640_aee2_431d_9bd8_2bfe2915e8a2()

     did='fce4ca43-f56d-4f90-b8b6-c5d231ac5fb3';dnm='HSR発話'
     rospy.loginfo('PRE [fce4ca43-f56d-4f90-b8b6-c5d231ac5fb3(HSR発話),6fae1b3b-a7bf-4617-a82e-8d7d5c6bed97]')
     def proc0008_o1(arg0008_o1):
       did='O';dnm='出力'
       rospy.loginfo('PRE [O(出力),6fae1b3b-a7bf-4617-a82e-8d7d5c6bed97]')
       self.outputs[0](self.proc0008_o0)
       rospy.loginfo('PST [O(出力),6fae1b3b-a7bf-4617-a82e-8d7d5c6bed97]')
     proc0008.data={'display': ''}
     proc0008.outputs=[proc0008_o1]
     proc0008.execute_i1([lambda :self.const0006])
     self.proc0008_o0 = proc0008.get_o0()
     rospy.loginfo('PST [fce4ca43-f56d-4f90-b8b6-c5d231ac5fb3(HSR発話),6fae1b3b-a7bf-4617-a82e-8d7d5c6bed97]')


class process_35b06640_aee2_431d_9bd8_2bfe2915e8a2:
   display_name='HSR発話'
   display_id='35b06640-aee2-431d-9bd8-2bfe2915e8a2'
   def get_o0(self):
     return self.r0011success
   srv_printeps_hsr_modules_srv_hsr_say=rospy.ServiceProxy('hsr_say', printeps_hsr_modules.srv.HsrSay)
   def __init__(self):
     self.r0011success=None
     self.data=dict()

   def execute_i1(self,inputs):

     did='45401979-4097-4697-b4b8-beee388a7860';dnm='HsrSay'
     rospy.loginfo('PRE [45401979-4097-4697-b4b8-beee388a7860(HsrSay),35b06640-aee2-431d-9bd8-2bfe2915e8a2]')
     r0011=self.srv_printeps_hsr_modules_srv_hsr_say(inputs[0]())
     self.r0011success=r0011.success
     did='O';dnm='出力'
     rospy.loginfo('PRE [O(出力),35b06640-aee2-431d-9bd8-2bfe2915e8a2]')
     self.outputs[0](self.r0011success)
     rospy.loginfo('PST [O(出力),35b06640-aee2-431d-9bd8-2bfe2915e8a2]')
     rospy.loginfo('PST [45401979-4097-4697-b4b8-beee388a7860(HsrSay),35b06640-aee2-431d-9bd8-2bfe2915e8a2]')


class process_9898934f_68ae_4847_ad90_161bcf41376f:
   display_name='HSR移動'
   display_id='9898934f-68ae-4847-ad90-161bcf41376f'
   def get_o0(self):
     return self.r0017success
   srv_printeps_hsr_modules_srv_printeps_float32_to_pose2d=rospy.ServiceProxy('printeps/float32_to_pose2d', printeps_hsr_modules.srv.Float32ToPose2D)
   srv_printeps_hsr_modules_srv_hsr_navigation=rospy.ServiceProxy('hsr_navigation', printeps_hsr_modules.srv.HsrNav)
   def __init__(self):
     self.data=dict()
     self.r0017success=None

   def execute_i1(self,inputs):

     did='1fd4a57d-5977-4ff1-bc04-d093b344c33b';dnm='Float32ToPose2D'
     rospy.loginfo('PRE [1fd4a57d-5977-4ff1-bc04-d093b344c33b(Float32ToPose2D),9898934f-68ae-4847-ad90-161bcf41376f]')
     r0016=self.srv_printeps_hsr_modules_srv_printeps_float32_to_pose2d(inputs[0](),inputs[1](),inputs[2]())
     did='dc53844d-1fa5-4675-b490-5152c9db810b';dnm='HsrNav'
     rospy.loginfo('PRE [dc53844d-1fa5-4675-b490-5152c9db810b(HsrNav),9898934f-68ae-4847-ad90-161bcf41376f]')
     r0017=self.srv_printeps_hsr_modules_srv_hsr_navigation(r0016.pose2d)
     self.r0017success=r0017.success
     did='O';dnm='出力'
     rospy.loginfo('PRE [O(出力),9898934f-68ae-4847-ad90-161bcf41376f]')
     self.outputs[0](self.r0017success)
     rospy.loginfo('PST [O(出力),9898934f-68ae-4847-ad90-161bcf41376f]')
     rospy.loginfo('PST [dc53844d-1fa5-4675-b490-5152c9db810b(HsrNav),9898934f-68ae-4847-ad90-161bcf41376f]')
     rospy.loginfo('PST [1fd4a57d-5977-4ff1-bc04-d093b344c33b(Float32ToPose2D),9898934f-68ae-4847-ad90-161bcf41376f]')


class process_190a7c28_1f44_4469_a104_64ae52206338:
   display_name='HSR物体を移動'
   display_id='190a7c28-1f44-4469-a104-64ae52206338'
   def get_o0(self):
     return self.r0020success
   srv_printeps_hsr_modules_srv_hsr_pick_and_place=rospy.ServiceProxy('hsr_pick_and_place', printeps_hsr_modules.srv.HsrPickAndPlace)
   def __init__(self):
     self.r0020success=None
     self.data=dict()

   def execute_i1(self,inputs):

     did='771fb6a4-fd0c-49df-b95d-47c7b4235334';dnm='HsrPickAndPlace'
     rospy.loginfo('PRE [771fb6a4-fd0c-49df-b95d-47c7b4235334(HsrPickAndPlace),190a7c28-1f44-4469-a104-64ae52206338]')
     r0020=self.srv_printeps_hsr_modules_srv_hsr_pick_and_place(inputs[0](),inputs[1](),inputs[2]())
     self.r0020success=r0020.success
     did='O';dnm='出力'
     rospy.loginfo('PRE [O(出力),190a7c28-1f44-4469-a104-64ae52206338]')
     self.outputs[0](self.r0020success)
     rospy.loginfo('PST [O(出力),190a7c28-1f44-4469-a104-64ae52206338]')
     rospy.loginfo('PST [771fb6a4-fd0c-49df-b95d-47c7b4235334(HsrPickAndPlace),190a7c28-1f44-4469-a104-64ae52206338]')


class process_11b22034_6f89_43c5_8304_168aaccc79f9:
   display_name='HSRカートを移動'
   display_id='11b22034-6f89-43c5-8304-168aaccc79f9'
   def get_o0(self):
     return self.r0026success
   srv_printeps_hsr_modules_srv_hsr_carry=rospy.ServiceProxy('hsr_carry', printeps_hsr_modules.srv.HsrCarry)
   def __init__(self):
     self.data=dict()
     self.r0026success=None

   def execute_i1(self,inputs):

     did='2e884f59-13d2-4fe1-8175-7d4688361adb';dnm='HsrCarry'
     rospy.loginfo('PRE [2e884f59-13d2-4fe1-8175-7d4688361adb(HsrCarry),11b22034-6f89-43c5-8304-168aaccc79f9]')
     r0026=self.srv_printeps_hsr_modules_srv_hsr_carry(inputs[0](),inputs[1]())
     self.r0026success=r0026.success
     did='O';dnm='出力'
     rospy.loginfo('PRE [O(出力),11b22034-6f89-43c5-8304-168aaccc79f9]')
     self.outputs[0](self.r0026success)
     rospy.loginfo('PST [O(出力),11b22034-6f89-43c5-8304-168aaccc79f9]')
     rospy.loginfo('PST [2e884f59-13d2-4fe1-8175-7d4688361adb(HsrCarry),11b22034-6f89-43c5-8304-168aaccc79f9]')


class service_5e0d9910_f67b_47a1_bb4d_b198426a9f7f:
   display_name='ペットボトルを直接配膳'
   display_id='5e0d9910-f67b-47a1-bb4d-b198426a9f7f'
   def get_o0(self):
     return self.proc0029_o0
   const0028='こんにちは。今から僕が飲み物を運搬するよ。'
   def __init__(self):
     self.proc0029_o0=None
     self.data=dict()
     self.proc0034_o0=None

   def execute_i1(self,inputs):
     proc0031=process_190a7c28_1f44_4469_a104_64ae52206338()
     proc0034=process_35b06640_aee2_431d_9bd8_2bfe2915e8a2()
     proc0029=process_8edd5347_5c66_4358_9498_ee1ca4de17a1()

     did='8b006a47-dbff-45fb-931e-6a732de226b1';dnm='HSR発話'
     rospy.loginfo('PRE [8b006a47-dbff-45fb-931e-6a732de226b1(HSR発話),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
     def proc0034_o1(arg0034_o1):
       did='cec1faf0-fd33-4566-968a-6ecc4b853bde';dnm='HSR物体を移動'
       rospy.loginfo('PRE [cec1faf0-fd33-4566-968a-6ecc4b853bde(HSR物体を移動),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
       def proc0031_o1(arg0031_o1):
         did='5c929e72-6752-40b5-ad54-d238f8f0086a';dnm='HSRホームポジションへ移動'
         rospy.loginfo('PRE [5c929e72-6752-40b5-ad54-d238f8f0086a(HSRホームポジションへ移動),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
         def proc0029_o1(arg0029_o1):
           did='O';dnm='出力'
           rospy.loginfo('PRE [O(出力),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
           self.outputs[0](self.proc0029_o0)
           rospy.loginfo('PST [O(出力),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
         proc0029.data={}
         proc0029.outputs=[proc0029_o1]
         proc0029.execute_i1([lambda :arg0031_o1])
         self.proc0029_o0 = proc0029.get_o0()
         rospy.loginfo('PST [5c929e72-6752-40b5-ad54-d238f8f0086a(HSRホームポジションへ移動),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
       proc0031.data={}
       proc0031.outputs=[proc0031_o1]
       proc0031.execute_i1([lambda :glorder1_ini_pos,lambda :glorder1_service_pos,lambda :glorder1_name])
       rospy.loginfo('PST [cec1faf0-fd33-4566-968a-6ecc4b853bde(HSR物体を移動),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')
     proc0034.data={}
     proc0034.outputs=[proc0034_o1]
     proc0034.execute_i1([lambda :self.const0028])
     self.proc0034_o0 = proc0034.get_o0()
     rospy.loginfo('PST [8b006a47-dbff-45fb-931e-6a732de226b1(HSR発話),5e0d9910-f67b-47a1-bb4d-b198426a9f7f]')


class service_d1ea20f2_dbaf_4ed1_8250_d8f74f357e53:
   display_name='ペットボトルをカートで配膳'
   display_id='d1ea20f2-dbaf-4ed1-8250-d8f74f357e53'
   def get_o0(self):
     return self.proc0037_o0
   const0058='こんにちは。今から僕がカートを使って飲み物を運搬するよ。'
   def __init__(self):
     self.proc0037_o0=None
     self.proc0061_o0=None
     self.proc0047_o0=None
     self.proc0056_o0=None
     self.proc0049_o0=None
     self.proc0038_o0=None
     self.proc0042_o0=None
     self.data=dict()

   def execute_i1(self,inputs):
     proc0062=process_11b22034_6f89_43c5_8304_168aaccc79f9()
     proc0038=process_35b06640_aee2_431d_9bd8_2bfe2915e8a2()
     proc0061=process_190a7c28_1f44_4469_a104_64ae52206338()
     proc0049=process_190a7c28_1f44_4469_a104_64ae52206338()
     proc0056=process_190a7c28_1f44_4469_a104_64ae52206338()
     proc0047=process_11b22034_6f89_43c5_8304_168aaccc79f9()
     proc0037=process_8edd5347_5c66_4358_9498_ee1ca4de17a1()
     proc0042=process_190a7c28_1f44_4469_a104_64ae52206338()

     did='9ae912bb-332a-473e-962a-6ed228a0c863';dnm='HSR発話'
     rospy.loginfo('PRE [9ae912bb-332a-473e-962a-6ed228a0c863(HSR発話),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
     def proc0038_o1(arg0038_o1):
       did='78294cd3-2a3a-4a31-a930-2686f640731d';dnm='HSR物体を移動'
       rospy.loginfo('PRE [78294cd3-2a3a-4a31-a930-2686f640731d(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
       def proc0042_o1(arg0042_o1):
         did='ae30d509-2e8c-4f67-b61d-4768d614dd37';dnm='HSR物体を移動'
         rospy.loginfo('PRE [ae30d509-2e8c-4f67-b61d-4768d614dd37(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
         def proc0049_o1(arg0049_o1):
           did='18ab66d6-3f26-4c84-8fe8-d670a720a3e0';dnm='HSRカートを移動'
           rospy.loginfo('PRE [18ab66d6-3f26-4c84-8fe8-d670a720a3e0(HSRカートを移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
           def proc0047_o1(arg0047_o1):
             did='56dcb3a6-496d-46c7-9c83-4a2ff54eb8ef';dnm='HSR物体を移動'
             rospy.loginfo('PRE [56dcb3a6-496d-46c7-9c83-4a2ff54eb8ef(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
             def proc0061_o1(arg0061_o1):
               did='5d3b0a14-9c97-497a-8d7a-d80f3c92ce31';dnm='HSR物体を移動'
               rospy.loginfo('PRE [5d3b0a14-9c97-497a-8d7a-d80f3c92ce31(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
               def proc0056_o1(arg0056_o1):
                 did='3ce60c3a-be04-4ae5-aa3b-bcdbf50d1165';dnm='HSRカートを移動'
                 rospy.loginfo('PRE [3ce60c3a-be04-4ae5-aa3b-bcdbf50d1165(HSRカートを移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
                 def proc0062_o1(arg0062_o1):
                   did='ddb3e844-b1e1-447c-8643-9f8cb437fb5d';dnm='HSRホームポジションへ移動'
                   rospy.loginfo('PRE [ddb3e844-b1e1-447c-8643-9f8cb437fb5d(HSRホームポジションへ移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
                   def proc0037_o1(arg0037_o1):
                     did='O';dnm='出力'
                     rospy.loginfo('PRE [O(出力),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
                     self.outputs[0](self.proc0037_o0)
                     rospy.loginfo('PST [O(出力),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
                   proc0037.data={}
                   proc0037.outputs=[proc0037_o1]
                   proc0037.execute_i1([lambda :arg0062_o1])
                   self.proc0037_o0 = proc0037.get_o0()
                   rospy.loginfo('PST [ddb3e844-b1e1-447c-8643-9f8cb437fb5d(HSRホームポジションへ移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
                 proc0062.data={}
                 proc0062.outputs=[proc0062_o1]
                 proc0062.execute_i1([lambda :glservice_table,lambda :glcart_ini_pos])
                 rospy.loginfo('PST [3ce60c3a-be04-4ae5-aa3b-bcdbf50d1165(HSRカートを移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
               proc0056.data={}
               proc0056.outputs=[proc0056_o1]
               proc0056.execute_i1([lambda :glorder1_cart_pos,lambda :glorder1_service_pos,lambda :glorder1_name])
               self.proc0056_o0 = proc0056.get_o0()
               rospy.loginfo('PST [5d3b0a14-9c97-497a-8d7a-d80f3c92ce31(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
             proc0061.data={}
             proc0061.outputs=[proc0061_o1]
             proc0061.execute_i1([lambda :glorder2_cart_pos,lambda :glorder2_service_pos,lambda :glorder2_name])
             self.proc0061_o0 = proc0061.get_o0()
             rospy.loginfo('PST [56dcb3a6-496d-46c7-9c83-4a2ff54eb8ef(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
           proc0047.data={}
           proc0047.outputs=[proc0047_o1]
           proc0047.execute_i1([lambda :glcart_ini_pos,lambda :glservice_table])
           self.proc0047_o0 = proc0047.get_o0()
           rospy.loginfo('PST [18ab66d6-3f26-4c84-8fe8-d670a720a3e0(HSRカートを移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
         proc0049.data={}
         proc0049.outputs=[proc0049_o1]
         proc0049.execute_i1([lambda :glorder2_ini_pos,lambda :glorder2_cart_pos,lambda :glorder2_name])
         self.proc0049_o0 = proc0049.get_o0()
         rospy.loginfo('PST [ae30d509-2e8c-4f67-b61d-4768d614dd37(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
       proc0042.data={}
       proc0042.outputs=[proc0042_o1]
       proc0042.execute_i2([lambda :glorder1_ini_pos,lambda :glorder1_cart_pos,lambda :glorder1_name])
       self.proc0042_o0 = proc0042.get_o0()
       rospy.loginfo('PST [78294cd3-2a3a-4a31-a930-2686f640731d(HSR物体を移動),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')
     proc0038.data={}
     proc0038.outputs=[proc0038_o1]
     proc0038.execute_i1([lambda :self.const0058])
     self.proc0038_o0 = proc0038.get_o0()
     rospy.loginfo('PST [9ae912bb-332a-473e-962a-6ed228a0c863(HSR発話),d1ea20f2-dbaf-4ed1-8250-d8f74f357e53]')


class process_8edd5347_5c66_4358_9498_ee1ca4de17a1:
   display_name='HSRホームポジションへ移動'
   display_id='8edd5347-5c66-4358-9498-ee1ca4de17a1'
   def get_o0(self):
     return self.proc0065_o0
   const0067=0.0
   const0063=-0.5
   def __init__(self):
     self.proc0065_o0=None
     self.data=dict()

   def execute_i1(self,inputs):
     proc0065=process_9898934f_68ae_4847_ad90_161bcf41376f()

     self.inputs=inputs
     did='c0b1e797-4ef3-4630-a7ec-c8c2bfdbdac1';dnm='HSR移動'
     rospy.loginfo('PRE [c0b1e797-4ef3-4630-a7ec-c8c2bfdbdac1(HSR移動),8edd5347-5c66-4358-9498-ee1ca4de17a1]')
     def proc0065_o1(arg0065_o1):
       did='O';dnm='出力'
       rospy.loginfo('PRE [O(出力),8edd5347-5c66-4358-9498-ee1ca4de17a1]')
       self.outputs[0](self.proc0065_o0)
       rospy.loginfo('PST [O(出力),8edd5347-5c66-4358-9498-ee1ca4de17a1]')
     proc0065.data={}
     proc0065.outputs=[proc0065_o1]
     proc0065.execute_i1([lambda :self.inputs[0](),lambda :self.const0063,lambda :self.const0067])
     self.proc0065_o0 = proc0065.get_o0()
     rospy.loginfo('PST [c0b1e797-4ef3-4630-a7ec-c8c2bfdbdac1(HSR移動),8edd5347-5c66-4358-9498-ee1ca4de17a1]')


class service_117293fb_e0e3_42e8_8431_aac582f2ca25:
   display_name='HSR注文物の設定'
   display_id='117293fb-e0e3-42e8-8431-aac582f2ca25'
   def get_o0(self):
     return glorder2_cart_pos
   const0069='コーヒーのSサイズ'
   const0080='Table13'
   const0083='Cart1'
   const0084='Pet6'
   const0074='Table31'
   const0088='Cart2'
   const0089='Pet4'
   const0077='Pet'
   const0076='爽健美茶のSサイズ'
   const0073='Table32'
   def __init__(self):
     self.data=dict()

   def execute_i1(self,inputs):

     did='4b87dbdf-474b-4186-921c-d048e2cc40a5';dnm='global文字列'
     rospy.loginfo('PRE [4b87dbdf-474b-4186-921c-d048e2cc40a5(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glcart_ini_pos
     glcart_ini_pos=self.const0077
     did='7712d69a-d74b-4664-aac5-1c9d19ae3122';dnm='global文字列'
     rospy.loginfo('PRE [7712d69a-d74b-4664-aac5-1c9d19ae3122(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glservice_table
     glservice_table=self.const0080
     did='09956029-880a-49e4-b9a4-f5399236d972';dnm='global文字列'
     rospy.loginfo('PRE [09956029-880a-49e4-b9a4-f5399236d972(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder1_name
     glorder1_name=self.const0069
     did='1ec494b5-d7ac-4d9c-8e9e-8189649746a5';dnm='global文字列'
     rospy.loginfo('PRE [1ec494b5-d7ac-4d9c-8e9e-8189649746a5(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder1_ini_pos
     glorder1_ini_pos=self.const0089
     did='b8db1d3a-a07e-4bab-9be4-ee3f24ef1cd9';dnm='global文字列'
     rospy.loginfo('PRE [b8db1d3a-a07e-4bab-9be4-ee3f24ef1cd9(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder1_service_pos
     glorder1_service_pos=self.const0074
     did='507817f5-9880-4f4e-9578-610aa9c03752';dnm='global文字列'
     rospy.loginfo('PRE [507817f5-9880-4f4e-9578-610aa9c03752(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder1_cart_pos
     glorder1_cart_pos=self.const0083
     did='fd024c88-7099-47b0-a3d6-7feb312eb984';dnm='global文字列'
     rospy.loginfo('PRE [fd024c88-7099-47b0-a3d6-7feb312eb984(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder2_name
     glorder2_name=self.const0076
     did='2e1c4dc1-1e32-485a-a073-06d36810e67c';dnm='global文字列'
     rospy.loginfo('PRE [2e1c4dc1-1e32-485a-a073-06d36810e67c(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder2_ini_pos
     glorder2_ini_pos=self.const0084
     did='7acc0968-1db1-4562-9508-26eb1400faea';dnm='global文字列'
     rospy.loginfo('PRE [7acc0968-1db1-4562-9508-26eb1400faea(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder2_service_pos
     glorder2_service_pos=self.const0073
     did='57be62a3-bd36-4610-83b3-851d66660f1e';dnm='global文字列'
     rospy.loginfo('PRE [57be62a3-bd36-4610-83b3-851d66660f1e(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     global glorder2_cart_pos
     glorder2_cart_pos=self.const0088
     did='O';dnm='出力'
     rospy.loginfo('PRE [O(出力),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     self.outputs[0](glorder2_cart_pos)
     rospy.loginfo('PST [O(出力),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [57be62a3-bd36-4610-83b3-851d66660f1e(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [7acc0968-1db1-4562-9508-26eb1400faea(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [2e1c4dc1-1e32-485a-a073-06d36810e67c(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [fd024c88-7099-47b0-a3d6-7feb312eb984(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [507817f5-9880-4f4e-9578-610aa9c03752(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [b8db1d3a-a07e-4bab-9be4-ee3f24ef1cd9(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [1ec494b5-d7ac-4d9c-8e9e-8189649746a5(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [09956029-880a-49e4-b9a4-f5399236d972(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [7712d69a-d74b-4664-aac5-1c9d19ae3122(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')
     rospy.loginfo('PST [4b87dbdf-474b-4186-921c-d048e2cc40a5(global文字列),117293fb-e0e3-42e8-8431-aac582f2ca25]')



import sys,inspect

def frame_string(elt):
   f_self = elt[0].f_locals.get('self',None)
   node_id=elt[0].f_locals.get('did','????')
   node_name=elt[0].f_locals.get('dnm','????')
   process_name = f_self.display_name if hasattr(f_self,'display_name') else '?'
   process_id = f_self.display_id if hasattr(f_self,'display_id') else '?'
   return "%s:%s in %s:%s %s at %s:%d"%(node_name,node_id,process_name,process_id,elt[4],elt[1],elt[2])

def execute(mainproc):
  sys.setrecursionlimit(100000000)


  try:
    rospy.init_node("printeps",anonymous=True)
    mainproc()

  except:
    print "Exception : %s"%sys.exc_info()[1]
    traces = [frame_string(elt)  for elt in inspect.trace()]
    traces.reverse()
    print "    at "+"\n    at ".join(traces)

if __name__ == '__main__':
  execute(lambda :service_ROOT().execute());

