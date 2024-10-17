import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom/routes.dart';
import 'package:custom/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GetX",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("GetX Title"),
        ),
        body: const MyHomePage(),
      ),
      defaultTransition: Transition.rightToLeftWithFade, // 配置默认动画
      // 主页面路由
      initialRoute: Routes.Home,
      // 注册路由表
      getPages: AppPages.pages,
    );
  }
}
