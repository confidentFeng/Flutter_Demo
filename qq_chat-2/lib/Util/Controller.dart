import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/LoginWidget.dart';
import '../Widget/MainWidget.dart';
import '../Widget/ContactWidget.dart';
import '../Widget/ChatWidget.dart';

// state只专注数据，需要使用数据，直接通过state获取
// logic只专注于触发事件交互，操作或更新数据
// view只专注UI显示

// 按钮状态
enum ButtonState {
  BTN_NORMAL,
  BTN_PRESSED,
  BTN_HOVER,
}

// 全局状态
class GlobalState {
  final screenSize = const Size(1250,680).obs; // 屏幕尺寸
  final screenSizeRight = const Size(1014,680).obs; // 右侧屏幕尺寸
  var language = const Locale('zh', 'CN').obs; //语言参数
  final curAcc = ''.obs; // 当前账号 
  final globalMousePressPos = Offset.zero.obs;      // 全局点击坐标
  late GlobalKey key = GlobalKey();   
}

// 全局变量控制器
class GlobalController extends GetxController {
  // 全局变量, 内部调用
  final GlobalState _globalState = GlobalState();

  // 获取屏幕尺寸与设置屏幕尺寸的函数
  Size get screenSize => _globalState.screenSize.value;
  set screenSize(Size value) => _globalState.screenSize.value = value;  

  // 获取右侧屏幕尺寸与设置右侧屏幕尺寸的函数
  Size get screenSizeRight => _globalState.screenSizeRight.value;
  set screenSizeRight(Size value) => _globalState.screenSizeRight.value = value;  

  // 获取当前语言与设置当前语言的函数
  Locale get language => _globalState.language.value;
  set language(Locale language) => () {
        _globalState.language.value = language;
        Get.updateLocale(language);
      }();

  // 获取当前账号与设置当前账号的函数
  String get curAcc => _globalState.curAcc.value;
  set curAcc(String acc) => _globalState.curAcc.value = acc;

  Offset get globalMousePressPos => _globalState.globalMousePressPos.value;
  set globalMousePressPos(Offset pos) => _globalState.globalMousePressPos.value = pos;  

  GlobalKey get key => _globalState.key;
  set key(GlobalKey val) => _globalState.key = val;        
}

// 定义全局变量控制器
final GlobalController globalCtrl = Get.put(GlobalController());

// 初始化通用配置
void initCommomCfg() {
  Get.lazyPut<LoginController>(() => LoginController());
  Get.lazyPut<MainController>(() => MainController());
  Get.lazyPut<ContactController>(() => ContactController());
  Get.lazyPut<ChatController>(() => ChatController());
}
