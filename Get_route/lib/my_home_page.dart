import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom/next_screen_page.dart';
import 'package:custom/routes.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 普通路由跳转
          ElevatedButton(
              onPressed: () async {
                Get.to(const NextScreenPage()); // to方法实现页面跳转
              },
              child: const Text("普通路由跳转")),
          const SizedBox(height: 16),
          // 别名路由跳转
          ElevatedButton(
              onPressed: () async {
                Get.toNamed(Routes.NextScreen); // toNamed方法实现页面跳转
              },
              child: const Text("别名路由跳转")),
          const SizedBox(height: 16),
          // 别名路由传值跳转
          ElevatedButton(
              onPressed: () async {
                Get.toNamed(Routes.ValueTransfer,
                    arguments: "别名路由传值页面"); // toNamed方法带参数实现页面跳转
              },
              child: const Text("别名路由传值跳转")),
        ],
      ),
    );
  }
}
