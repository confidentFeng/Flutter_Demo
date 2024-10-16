import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});
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
      initialRoute: isLoggedIn ? Routes.Initial : Routes.Login,
      // 注册路由表
      getPages: AppPages.pages,
    );
  }
}
