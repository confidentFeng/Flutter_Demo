import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Controller.dart';

// 状态类
class LoginState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 400.0.obs; // 宽度
  final _height = 280.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
  final _isLogined = false.obs;     // 是否登陆完成

  final _x = 0.0.obs; // 水平方向的边距
  final _y = 0.0.obs; // 垂直方向的边距
}

// 控制器类
class LoginController extends GetxController {
  final LoginState state = LoginState();
  
  double get width => state._width.value;
  set width(double value) => state._width.value = value;
  
  double get height => state._height.value;
  set height(double value) => state._height.value = value;

  Offset get offset => state._offset.value;
  set offset(Offset value) => state._offset.value = value;
  
  bool get isLogined => state._isLogined.value;
  set isLogined(bool flag) => state._isLogined.value = flag;

  double get x => state._x.value;
  set x(double value) => state._x.value = value;

  double get y => state._y.value;
  set y(double value) => state._y.value = value;  

  // 是否隐藏
  bool isHidden() {
    return state._isHidden.value;
  }

  // 显示
  void show() {
    state._isHidden.value = false;
  }

  // 隐藏
  void hide() {
    state._isHidden.value = true;
  }

  // 设置窗口显示/隐藏状态
  void setVisable(bool isVisable)
  {
    state._isHidden.value = !isVisable;
  } 

  // 移动
  void move(double x, double y) {
    state._offset.value = Offset(x, y);
  }  

  // 登陆按钮点击事件
  login(TextEditingController userNameController,
      TextEditingController passWordController) {
    var userName = userNameController.text;
    var passWord = passWordController.text;

    // 1-用户协议是否勾选
    if (!isChecked.value) {
      Get.snackbar('用户协议未选中'.tr, '请勾选用户协议'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    // 2-用户名判断
    if (userName.isEmpty) {
      Get.snackbar('用户名异常'.tr, '用户名为空'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    // 3-密码判断
    if (passWord.isEmpty) {
      Get.snackbar('密码异常'.tr, '密码为空'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.snackbar('用户名、密码正确'.tr, '去登陆'.tr, snackPosition: SnackPosition.BOTTOM);
  }

  // 用户协议勾选事件
  var isChecked = false.obs;

  void changeChecked(bool value) {
    isChecked.value = value;
  }
}

// 登陆界面
class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  final LoginController controller = Get.find<LoginController>(); // 登录界面控制器  

  @override
  Widget build(BuildContext context) {
    return Positioned (
      left: (globalCtrl.screenSize.width - controller.width)/2,
      top: (globalCtrl.screenSize.height - controller.height)/2,
      
      child: Obx(() => Transform.translate ( // 让部件在 x、y 轴上平移指定的距离
        offset: controller.offset, // 平移距离
        child: GestureDetector( // 手势识别组件，以让鼠标移动到该组件上时光标为"选中样式"
          behavior: HitTestBehavior.opaque,          
          child: Visibility( // 是一个用于根据布尔值条件显示或隐藏小部件的控件
            visible: !controller.isHidden(), // 控制是否显示
            maintainState: true,           
            child:Container(
                width: controller.width,
                height: controller.height,
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),                 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 登录界面标题栏
                    LoginTabBar(),
                    // 距离上一个View距离             
                    const SizedBox(height: 12), 
                    // 下方编辑界面
                    buildInputWidget(),
                  ],
                ),
            )
          ),

          // 按压拖动回调，以支持鼠标移动界面
          onPanUpdate: (details) {
              controller.offset += details.delta;
          }          
        )
      )
      )
    );
  }

  // 下方编辑界面
   Widget buildInputWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // 两侧边距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,        
        children: <Widget>[
          TextField(
            controller: userNameController,
            decoration: InputDecoration(labelText: '用户'.tr),
            style: const TextStyle(fontSize: 16),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12), //距离上一个View距离
          TextField(
            controller: passWordController,
            obscureText: true,
            decoration: InputDecoration(labelText: "密码".tr),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12), //距离上一个View距离
          buildPrivacyWidget(), //隐私政策
          const SizedBox(height: 12), //距离上一个View距离
          SizedBox(
            width: controller.width-32,
            child: ElevatedButton(
              child: Text('登录'.tr),
              onPressed: () {
                debugPrint("ElevatedButton Click");
                controller.login(userNameController, passWordController);
              },
            )
          ),
          const SizedBox(height: 12), //距离上一个View距离                   
        ],
      )
    );
  } 

  // 隐私协议勾选框
  Widget buildPrivacyWidget() {
    return Row(
      children: [
        Obx(() => Checkbox(
            value: controller.isChecked.value,
            onChanged: (value) => controller.changeChecked(value!))),
        Text('同意'.tr, style: const TextStyle(fontSize: 14)),
        Text('<服务协议>'.tr,
            style: const TextStyle(fontSize: 14, color: Colors.blue)),
        Text('<隐私政策>'.tr, style: const TextStyle(fontSize: 14, color: Colors.blue))
      ],
    );
  }
}

// 登录界面标题栏
class LoginTabBar extends StatelessWidget {
  LoginTabBar({super.key});

  final LoginController loginCtrl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      color: const Color.fromARGB(128, 20, 45, 86),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 6),
          SizedBox(
            width: 40.h,
            height: 40.h,
            child: Obx(() => IconButton(
              onPressed: () {
                if ( globalCtrl.language == const Locale('zh', 'CN') )
                {
                    globalCtrl.language = const Locale('zh', 'HK');
                }
                else if ( globalCtrl.language == const Locale('zh', 'HK') )
                {
                    globalCtrl.language = const Locale('en', 'US');
                }                                                  
                else if ( globalCtrl.language == const Locale('en', 'US') )
                {
                    globalCtrl.language = const Locale('zh', 'CN');
                }                                                  
              }, 
              icon: () {
                if(globalCtrl.language ==  const Locale('zh', 'CN'))
                {
                  return Image.asset("assets/images/btn_Chinese_jianti.png", width: 40.w, height: 40.h);
                }
                else if(globalCtrl.language == const Locale('zh', 'HK'))
                {
                  return Image.asset("assets/images/btn_Chinese_fanti.png", width: 40.w, height: 40.h);
                }
                else if(globalCtrl.language == const Locale('en', 'US'))
                {
                  return Image.asset("assets/images/btn_English.png", width: 40.w, height: 40.h);
                }
                else
                {
                  return const Icon(null);
                }
              }(),
              padding: EdgeInsets.zero,
            )),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 15,
            child: Text(
              "登录".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,)
              )
          ),
          SizedBox(
            width: 30.h,
            height: 30.h,
            child: IconButton(
              onPressed: () {
                loginCtrl.hide(); // 隐藏登录界面
              }, 
              icon: Icon(
                Icons.close,
                size: 30.w,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
