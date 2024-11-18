import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // （4）配置GetMaterialApp
      translations: Translation(), // 你的翻译类
      locale: const Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
      fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '中国'.tr, // （3）在字符串后面添加.tr后缀即可
              style: const TextStyle(
                  color: Colors.red, fontSize: 50, fontWeight: FontWeight.w700),
            ),
            changeButton(const Locale('zh', 'CN'), '简体'),
            changeButton(const Locale('zh', 'HK'), '繁体'),
            changeButton(const Locale('en', 'US'), '英文'),
          ],
        ),
      ),
    );
  }

  Widget changeButton(Locale newLocale, String text) {
    return ElevatedButton(
      onPressed: () {
        // （5）更改语言
        Get.updateLocale(newLocale);
      },
      child: Text(text),
    );
  }
}
