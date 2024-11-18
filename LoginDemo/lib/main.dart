import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom/controller/LoginController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: Login());
  }
}

// 控制器实例
LoginController controller = Get.put(LoginController());

//登陆界面
class Login extends StatelessWidget {
  Login({super.key});
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80), //距离顶部距离
            buildTopWidget(), //设置登陆欢迎
            const SizedBox(height: 20), //距离上一个View距离
            buildAccountInputWidget(userNameController), //用户名
            const SizedBox(height: 20), //距离上一个View距离
            buildPasswordInputWidget(passWordController), //密码
            const SizedBox(
              height: 10,
            ), //距离上一个View距离
            buildPrivacyWidget(), //隐私政策
            const SizedBox(
              height: 10,
            ), //距离上一个View距离
            buildLoginButton(), //登陆按钮
          ],
        ),
      ),
    );
  }

//Widget-Top
  Widget buildTopWidget() {
    return const Text(
      "你好，欢迎登陆",
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
    );
  }

//手机号
  Widget buildAccountInputWidget(TextEditingController? userNameController) {
    return TextField(
      controller: userNameController,
      decoration: const InputDecoration(labelText: "用户名"),
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.phone,
    );
  }

//密码
  Widget buildPasswordInputWidget(TextEditingController? passWordController) {
    return TextField(
      controller: passWordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: "用户密码"),
      style: const TextStyle(fontSize: 16),
    );
  }

//登陆按钮
  Widget buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("normal"),
        onPressed: () {
          debugPrint("ElevatedButton Click");
          controller.login(userNameController, passWordController);
        },
      ),
    );
  }

  //隐私协议
  Widget buildPrivacyWidget() {
    return Row(
      children: [
        Obx(() => Checkbox(
            value: controller.isChecked.value,
            onChanged: (value) => controller.changeChecked(value!))),
        const Text('同意', style: TextStyle(fontSize: 14)),
        const Text('<服务协议>',
            style: TextStyle(fontSize: 14, color: Colors.blue)),
        const Text('<隐私政策>', style: TextStyle(fontSize: 14, color: Colors.blue))
      ],
    );
  }
}
