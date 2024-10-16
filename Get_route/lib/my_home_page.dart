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
          const SizedBox(height: 16),
          // SnackBars
          ElevatedButton(
              onPressed: () async {
                Get.snackbar('SnackBar', '我是SnackBar'); // toNamed方法带参数实现页面跳转
              },
              child: const Text("免SnackBars导航")),
          const SizedBox(height: 16),
          // Dialogs
          ElevatedButton(
              onPressed: () async {
                Get.snackbar('Dialogs', '我是Dialogs'); // toNamed方法带参数实现页面跳转
              },
              child: const Text("免Dialogs导航")),
          const SizedBox(height: 16),
          // Dialogs
          ElevatedButton(
              onPressed: () {
                Get.bottomSheet(Container(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.wb_sunny_outlined),
                        title: const Text("白天模式"),
                        onTap: () {
                          // 改变主题模式(白天模式还是夜晚模式)
                          // Get.isDarkMode用来判断是否是夜晚模式
                          Get.changeTheme(ThemeData.light());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.wb_sunny),
                        title: const Text("黑夜模式"),
                        onTap: () {
                          // 改变主题模式(白天模式还是夜晚模式)
                          Get.changeTheme(ThemeData.dark());
                        },
                      )
                    ],
                  ),
                ));
              },
              child: const Text("免BottomSheets导航")),
        ],
      ),
    );
  }
}
