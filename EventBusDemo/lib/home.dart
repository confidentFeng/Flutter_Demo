import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomeBody(),
    );
  }
}

class MyHomeBody extends StatelessWidget {
  const MyHomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        // 按钮
        SizedBox(
          height: 80,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'loginDemo'); // 路由跳转到LoginDemo页面
            },
            child: const Text("loginDemo"),
          ),
        ),
    );
  }
}
