import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 检查用户是否已登录
    // 从 SharedPreferences 中获取登录状态
    SharedPreferences.getInstance().then((prefs) {
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (!isLoggedIn) {
        return const RouteSettings(name: Routes.Login); // 重定向到登录页面
      }
      return null; // 继续导航
    });

    return null; // 继续导航
  }
}
