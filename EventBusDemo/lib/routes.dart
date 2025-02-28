import 'package:flutter/material.dart';
import 'home.dart';
import 'LoginDemo.dart';

// 路由导航页面
Map<String, WidgetBuilder> routes = {
  'home': (context) => const Home(),
  'loginDemo': (context) => const LoginDemo(),  
};