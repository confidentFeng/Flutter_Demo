import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("登录页面"),
      ),
      body: Center(
        child: Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.grey[200], //定义下划线颜色
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                    )),
            child: Column(
              children: <Widget>[
                const TextField(
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)),
                ),
                const TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "密码",
                      hintText: "您的登录密码",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  obscureText: true,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("确定")),
              ],
            )),
      ),
    );
  }
}
