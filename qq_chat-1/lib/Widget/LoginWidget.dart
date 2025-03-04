import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/Controller.dart';

// 状态类
class LoginState {
  final _isHidden = false.obs; // 是否隐藏
  final _width = 400.0.obs; // 宽度
  final _height = 328.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
  final _isLogined = false.obs; // 是否登陆完成
}

// 控制器类
class LoginController extends GetxController {
  final LoginState state = LoginState();

  double get width => state._width.value;
  set width(double value) => state._width.value = value;

  double get height => state._height.value;
  set height(double value) => state._height.value = value;

  Offset get offset => state._offset.value;
  set offset(Offset value) => state._offset.value = value;

  bool get isLogined => state._isLogined.value;
  set isLogined(bool flag) => state._isLogined.value = flag;

  LoginController() {
    // 新加：初始化登录界面的偏移
    state._offset.value = Offset(
        (globalCtrl.screenSize.width - state._width.value) / 2,
        (globalCtrl.screenSize.height - state._height.value) / 2);
  }

  // 是否隐藏
  bool isHidden() {
    return state._isHidden.value;
  }

  // 显示
  void show() {
    state._isHidden.value = false;
  }

  // 隐藏
  void hide() {
    state._isHidden.value = true;
  }

  // 设置窗口显示/隐藏状态
  void setVisable(bool isVisable) {
    state._isHidden.value = !isVisable;
  }

  // 移动
  void move(double x, double y) {
    state._offset.value = Offset(x, y);
  }

  // 登陆按钮点击事件
  login(TextEditingController userNameController,
      TextEditingController passWordController) {
    var userName = userNameController.text;
    var passWord = passWordController.text;

    // 用户名判断
    if (userName.isEmpty) {
      Get.snackbar('用户名异常'.tr, '用户名为空'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    // 密码判断
    if (passWord.isEmpty) {
      Get.snackbar('密码异常'.tr, '密码为空'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.snackbar('用户名、密码正确'.tr, '去登陆'.tr, snackPosition: SnackPosition.BOTTOM);
  }
}

// 登陆界面
class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final LoginController loginCtrl = Get.find<LoginController>(); // 登录界面控制器

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: (globalCtrl.screenSize.width - loginCtrl.width) / 2,
        top: (globalCtrl.screenSize.height - loginCtrl.height) / 2,
        child: Obx(() => Transform.translate(
            // 让部件在 x、y 轴上平移指定的距离
            offset: loginCtrl.offset, // 平移距离
            child: GestureDetector(
                // 手势识别组件，以让鼠标移动到该组件上时光标为"选中样式"
                behavior: HitTestBehavior.opaque,
                child: Visibility(
                    // 是一个用于根据布尔值条件显示或隐藏小部件的控件
                    visible: !loginCtrl.isHidden(), // 控制是否显示
                    maintainState: true,
                    child: Container(
                      width: loginCtrl.width,
                      height: loginCtrl.height,
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 242, 249),
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // 确保子部件从顶部开始排列
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // 确保子部件从左侧开始排列
                        children: const [
                          // 登录界面标题栏
                          LoginTabBar(),
                          // 下方编辑界面
                          InputWidget(),
                        ],
                      ),
                    )),

                // 按压拖动回调，以支持鼠标移动界面
                onPanUpdate: (details) {
                  loginCtrl.offset += details.delta;
                }))));
  }
}

// 登录界面标题栏
class LoginTabBar extends StatefulWidget {
  const LoginTabBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginTabBarState createState() => _LoginTabBarState();
}

// 登录界面标题栏实现
class _LoginTabBarState extends State<LoginTabBar> {
  // 控制器定义
  final LoginController loginCtrl = Get.find<LoginController>();

  // 当前图片路径
  String currentImagePath = 'assets/Widget/blue70-2.gif';

  // 图片路径列表
  final Map<String, String> imagePaths = {
    '蓝色': 'assets/Widget/blue70-2.gif',
    '红色': 'assets/Widget/red69-2.gif',
    '紫色': 'assets/Widget/purple0.4.gif',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Colors.transparent,
      padding: EdgeInsets.zero, // 容器内部的间距为0（如果有的话）
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // 动态gif动图
          Image.asset(
            currentImagePath, // 替换为你的GIF路径
            width: loginCtrl.width,
            height: 170,
            fit: BoxFit.cover, // 调整图片的填充方式
          ),

          // 语言切换按钮
          Positioned(
            right: 74,
            top: 4,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Obx(() => IconButton(
                    onPressed: () {
                      if (globalCtrl.language == const Locale('zh', 'CN')) {
                        globalCtrl.language = const Locale('zh', 'HK');
                      } else if (globalCtrl.language ==
                          const Locale('zh', 'HK')) {
                        globalCtrl.language = const Locale('en', 'US');
                      } else if (globalCtrl.language ==
                          const Locale('en', 'US')) {
                        globalCtrl.language = const Locale('zh', 'CN');
                      }
                    },
                    icon: () {
                      if (globalCtrl.language == const Locale('zh', 'CN')) {
                        return Image.asset(
                            "assets/Widget/btn_Chinese_jianti.png",
                            width: 30,
                            height: 30);
                      } else if (globalCtrl.language ==
                          const Locale('zh', 'HK')) {
                        return Image.asset(
                            "assets/Widget/btn_Chinese_fanti.png",
                            width: 30,
                            height: 30);
                      } else if (globalCtrl.language ==
                          const Locale('en', 'US')) {
                        return Image.asset("assets/Widget/btn_English.png",
                            width: 30, height: 30);
                      } else {
                        return const Icon(null);
                      }
                    }(),
                    padding: EdgeInsets.zero,
                  )),
            ),
          ),

          // 动图设置菜单按钮
          Positioned(
            right: 38,
            top: 0,
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.settings,
                size: 24,
              ), // 使用当前图标作为按钮图标
              onSelected: (String key) {
                // 更新当前图片路径
                setState(() {
                  currentImagePath = imagePaths[key]!;
                });
              },
              itemBuilder: (BuildContext context) {
                return imagePaths.keys.map((String key) {
                  return PopupMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList();
              },
            ),
          ),

          // 关闭按钮
          Positioned(
            right: 4,
            top: 0,
            child: IconButton(
              onPressed: () {
                loginCtrl.hide(); // 隐藏登录界面
              },
              icon: const Icon(
                Icons.close,
                size: 26,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

// 下方输入界面
class InputWidget extends StatefulWidget {
  const InputWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputWidgetState createState() => _InputWidgetState();
}

// 下方输入界面实现
class _InputWidgetState extends State<InputWidget> {
  // 控制器定义
  final LoginController loginCtrl = Get.find<LoginController>();

  // 编辑框控制器
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();  

  // 勾选框否选状态
  bool isCheckedRem = false;  
  bool isCheckedAuto = false;  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158,
      padding: EdgeInsets.zero, // 两侧边距
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 水平均匀分布
          children: [
            // QQ头像
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/Widget/QQ_3D2.png', // 替换为你的GIF路径
                    width: 84,
                    height: 96,
                    fit: BoxFit.cover, // 调整图片的填充方式
                  ),
                ]),

            // 编辑区域-垂直布局
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 距离上一个View距离
                const SizedBox(height: 8),

                // 用户编辑框
                SizedBox(
                    width: 200,
                    height: 30,
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: '用户'.tr,
                        hintStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontSize: 14.0),
                        filled: true, // 启用背景填充
                        fillColor: Colors.white, // 背景颜色
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none, // 去掉边框
                        ),
                      ),
                    )),

                // 距离上一个View距离
                const SizedBox(height: 6),

                // 密码编辑框
                SizedBox(
                    width: 200,
                    height: 30,
                    child: TextField(
                      controller: passWordController,
                      decoration: InputDecoration(
                        hintText: '密码'.tr,
                        hintStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontSize: 14.0),
                        filled: true, // 启用背景填充
                        fillColor: Colors.white, // 背景颜色
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none, // 去掉边框
                        ),
                      ),
                    )),

                //距离上一个View距离
                const SizedBox(height: 6),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 水平均匀分布
                    children: [
                      // 记住密码勾选框
                      Transform.scale( // 使用Transform.scale来设置勾选框的大小
                        scale: 0.9, // 缩放比例，2.0 表示放大两倍
                        child: Checkbox(
                          value: isCheckedRem, // 当前复选框的值，表示是否选中
                          onChanged: (bool? newValue) { // 当复选框的值改变时调用
                            setState(() {
                              isCheckedRem = newValue ?? false;
                            });
                          },
                          activeColor: Colors.blue, // 选中时的颜色
                          checkColor: Colors.white, // 选中标记的颜色              
                        ), 
                      ),
                      
                      // 文本
                      Text(
                        '记住密码'.tr,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 44, 44, 44),
                        ),
                      ),

                      // 距离上一个View距离
                      const SizedBox(height: 12),

                      // 自动登录勾选框
                      Transform.scale( // 使用Transform.scale来设置勾选框的大小
                        scale: 0.9, // 缩放比例，2.0 表示放大两倍
                        child: Checkbox(
                          value: isCheckedAuto, // 当前复选框的值，表示是否选中
                          onChanged: (bool? newValue) { // 当复选框的值改变时调用
                            setState(() {
                              isCheckedAuto = newValue ?? false;
                            });
                          },
                          activeColor: Colors.blue, // 选中时的颜色
                          checkColor: Colors.white, // 选中标记的颜色              
                        ), 
                      ),

                      // 文本
                      Text(
                        '自动登录'.tr,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 44, 44, 44),
                        ),
                      ),
                    ]),

                //距离上一个View距离
                const SizedBox(height: 6),

                // 登录按钮
                SizedBox(
                    width: 200,
                    height: 32,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255, 14, 150, 254)), // 按扭背景颜色
                        foregroundColor:
                            WidgetStateProperty.all(Colors.white), // 按钮文本颜色
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))), // 圆角
                      ),
                      child: Text('登录'.tr),
                      onPressed: () {
                        debugPrint("ElevatedButton Click");

                        // 登录验证
                        loginCtrl.login(userNameController, passWordController);

                        // 设置当前账号
                        globalCtrl.curAcc = userNameController.text;
                        // 打印当前账号
                        debugPrint("globalLoginName: ${globalCtrl.curAcc}");

                        // 登录成功后，隐藏登录界面（本界面）
                        //loginCtrl.hide();
                      },
                    )),

                //距离上一个View距离
                const SizedBox(height: 8),
              ],
            ),

            // 注册账号、找回密码按钮区域-垂直布局
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 距离上一个View距离
                  const SizedBox(height: 8),

                  // 注册账号按钮
                  TextButton(
                    child: Text(
                      '注册账号'.tr,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color.fromARGB(255, 9, 163, 220),
                      ),
                    ),
                    onPressed: () {},
                  ),

                  // 距离上一个View距离
                  const SizedBox(height: 8),

                  // 找回密码按钮
                  TextButton(
                    child: Text(
                      '找回密码'.tr,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color.fromARGB(255, 9, 163, 220),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ])
          ]),
    );
  }
}
