import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueTransferPage extends StatelessWidget {
  const ValueTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("别名路由传值页面"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Get.arguments), // 别名路由传值
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("返回上一个页面")),
        ],
      ),
    );
  }
}
