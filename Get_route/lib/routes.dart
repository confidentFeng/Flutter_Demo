import 'package:get/get.dart';
import 'package:custom/my_home_page.dart';
import 'package:custom/next_screen_page.dart';
import 'package:custom/value_transfer_page.dart';
import 'package:custom/login_page.dart';
import 'package:custom/auth_middleware.dart';

// 声明别名
abstract class Routes {
  static const Initial = '/';
  static const NextScreen = '/NextScreen';
  static const ValueTransfer = '/ValueTransfer';
  static const Login = '/Login';
}

// 注册路由表
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.Initial,
      page: () => const MyHomePage(),
      middlewares: [AuthMiddleware()], //中间件使用
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
    GetPage(
      name: Routes.Login,
      page: () => const LoginPage(),
      transition: Transition.rightToLeft, // 页面跳转动画
    ),
  ];
}
