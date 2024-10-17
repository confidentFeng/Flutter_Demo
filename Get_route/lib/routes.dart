import 'package:get/get.dart';
import 'package:custom/my_home_page.dart';
import 'package:custom/next_screen_page.dart';
import 'package:custom/value_transfer_page.dart';

// 声明别名
abstract class Routes {
  static const Home = '/';
  static const NextScreen = '/NextScreen';
  static const ValueTransfer = '/ValueTransfer';
}

// 注册路由表
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.Home,
      page: () => const MyHomePage(),
    ),
    GetPage(
      name: Routes.NextScreen,
      page: () => const NextScreenPage(),
      transition: Transition.rightToLeft, // 页面跳转动画
    ),
    GetPage(
      name: Routes.ValueTransfer,
      page: () => const ValueTransferPage(),
      transition: Transition.rightToLeft, // 页面跳转动画
    ),
  ];
}
