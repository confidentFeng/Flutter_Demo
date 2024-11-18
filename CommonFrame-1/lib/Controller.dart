import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LogoWidget.dart';
import 'LoginWidget.dart';

// state只专注数据，需要使用数据，直接通过state获取
// logic只专注于触发事件交互，操作或更新数据
// view只专注UI显示

// 全局状态
class GlobalState {
  final screenSize = const Size(1920,1080).obs; // 屏幕尺寸
  var language = const Locale('zh', 'CN').obs; //语言参数
}

// 全局变量控制器
class GlobalController extends GetxController {
  // 全局变量, 内部调用
  final GlobalState _globalState = GlobalState();

  // 获取屏幕尺寸与设置屏幕尺寸的函数
  Size get screenSize => _globalState.screenSize.value;
  set screenSize(Size value) => _globalState.screenSize.value = value;  

  // 获取当前语言与设置当前语言的函数
  Locale get language => _globalState.language.value;
  set language(Locale language) => () {
        _globalState.language.value = language;
        Get.updateLocale(language);
      }();
}

// 定义全局变量控制器
final GlobalController globalCtrl = Get.put(GlobalController());

// 初始化通用配置
void initCommomCfg() {
  Get.lazyPut<LoginController>(() => LoginController());
  Get.lazyPut<LogoControl>(() => LogoControl());
}
