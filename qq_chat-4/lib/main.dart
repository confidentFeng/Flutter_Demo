import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Util/Controller.dart';
import 'Util/Translation.dart';
import 'Widget/MainWidget.dart';
import 'Widget/LoginWidget.dart';
import 'Widget/SetWidget.dart';
import 'Widget/Menu/AboutWidget.dart';
import 'Widget/Menu/SettingWidget.dart';

// 主函数
main(List<String> args) {
  // 初始化通用配置
  initCommomCfg();

  runApp(MainApp());
}

// 主界面
class MainApp extends StatelessWidget {
  MainApp({super.key});

  // 各界面的实例
  final LoginWidget loginWidget = LoginWidget();
  final MainWidget mainWidget = MainWidget();
  final SetWidget setWidget = SetWidget();
  final AboutWidget aboutWidget = AboutWidget();
  final SettingWidget settingWidget = SettingWidget();

  @override
  Widget build(BuildContext context) {
    globalCtrl.key = GlobalKey();    
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      builder: (context, child) {
        return GetMaterialApp(
          // 配置GetMaterialApp
          translations: Translation(), // 你的翻译
          locale: const Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
          fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Ali"),
          home: Scaffold(
            backgroundColor: Colors.white,
            key: globalCtrl.key,            
            body: Stack( // 使用Stack以同时选择显示多个子界面在同一个主界面中
              alignment: Alignment.center,
              children: <Widget>[
                loginWidget,
                mainWidget,
                setWidget,
                aboutWidget,
                settingWidget,
              ],
            ),
          ),
        );
      },
    );
  }
}
