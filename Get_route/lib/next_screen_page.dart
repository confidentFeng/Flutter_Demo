import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextScreenPage extends StatelessWidget {
  const NextScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("下一个页面"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("返回上一个页面")),
      ),
    );
  }
}
