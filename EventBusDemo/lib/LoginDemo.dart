// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'EventBus.dart';

class LoginDemo extends StatelessWidget {
  const LoginDemo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoginDemo"),
      ),
      body: const MyHomeBody(),
    );
  }
}

class MyHomeBody extends StatelessWidget {
  const MyHomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主轴对齐方式：均匀分布
      crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴对齐方式：居中对齐      
      children: <Widget>[
        const TextField(
          autofocus: true,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
        ),
        const TextField(
          decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue), // 按扭背景颜色
            foregroundColor: WidgetStateProperty.all(Colors.white), // 按钮文本颜色
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))), // 圆角
          ),
          child: const Text("登录"),
          onPressed: () {
            // 登录页中，登录成功后触发登录事件，其它页面订阅者会被调用
            eventBus.emit("login", true.toString());

            // 登录页中，登录成功后触发登录事件，其它页面订阅者会被调用
            eventBus.emit("message", 'login success');            
          },
        ),
      ],
    );
  }
}
