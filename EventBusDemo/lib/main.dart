import 'package:flutter/material.dart';
import 'routes.dart'; // 添加路由页面
import 'EventBus.dart';

main(List<String> args) {
  // 监听登录事件
  eventBus.on("login", (arg) {
    debugPrint(arg);
  });

  // 监听登录事件
  eventBus.on("message", (arg) {
    debugPrint(arg);
  });  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // 标题
      debugShowCheckedModeBanner: false, // 不显示debug标识
      theme: ThemeData(
        // 主题
        primarySwatch: Colors.blue,
      ),
      routes: routes, // 指定路由页面
      initialRoute: 'home', // 指定路由导航的首页名称
    );
  }
}
