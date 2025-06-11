import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/Controller.dart';
import '../Util/Utils.dart';
import 'Menu/AboutWidget.dart';
import 'Menu/SettingWidget.dart';
import './LoginWidget.dart';
import './MainWidget.dart';

// 状态类
class SetState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 160.0.obs; // 宽度
  final _height = 133.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
}

// 控制器类
class SetController extends GetxController {
  final SetState state = SetState();

  double get width => state._width.value;
  set width(double value) => state._width.value = value;

  double get height => state._height.value;
  set height(double value) => state._height.value = value;

  Offset get offset => state._offset.value;
  set offset(Offset value) => state._offset.value = value;

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

  SetController() {
    // 新加：初始化登录界面的偏移
    state._offset.value = Offset(
        (globalCtrl.screenSize.width - state._width.value) / 2,
        (globalCtrl.screenSize.height - state._height.value) / 2);
  }
}

// 设置界面
class SetWidget extends StatefulWidget {
  const SetWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SetWidgetState createState() => _SetWidgetState();
}

// 设置界面
class _SetWidgetState extends State<SetWidget> {
  final SetController ctrl = Get.find<SetController>(); // 设置界面控制器
  final AboutController aboutCtrl = Get.find<AboutController>();
  final SettingController settingCtrl = Get.find<SettingController>();
  final MainController mainCtrl = Get.find<MainController>();
  final LoginController loginCtrl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: (globalCtrl.screenSize.width - ctrl.width) / 2,
        top: (globalCtrl.screenSize.height - ctrl.height) / 2,
        child: Obx(() => Transform.translate(
            // 让部件在 x、y 轴上平移指定的距离
            offset: ctrl.offset, // 平移距离
            child: GestureDetector(
                // 手势识别组件，以让鼠标移动到该组件上时光标为"选中样式"
                behavior: HitTestBehavior.opaque,
                child: Visibility(
                    // 是一个用于根据布尔值条件显示或隐藏小部件的控件
                    visible: !ctrl.isHidden(), // 控制是否显示
                    maintainState: true,
                    child: Container(
                      width: ctrl.width,
                      height: ctrl.height,
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // 容器背景色
                        borderRadius: BorderRadius.circular(10), // 圆角边框
                        boxShadow: [
                          // 边框阴影
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // 阴影颜色和透明度
                            spreadRadius: 1, // 阴影扩散范围
                            blurRadius: 1, // 阴影模糊程度
                            offset: Offset(0, 1), // 阴影偏移
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
                        children: [
                          // 帮助按钮
                          buildButton(
                            icon: Icons.help,
                            text: "帮助",
                            onPressed: () {
                              // 隐藏本界面
                              ctrl.hide();
                              // 同时需要隐藏局部区域模态窗口
                              removeOverlay(ResponseData());
                            },
                          ),

                          // 锁定按钮
                          buildButton(
                            icon: Icons.lock,
                            text: "锁定",
                            onPressed: () {
                              // 隐藏本界面
                              ctrl.hide();
                              // 同时需要隐藏局部区域模态窗口
                              removeOverlay(ResponseData());
                            },
                          ),

                          // 设置按钮
                          buildButton(
                            icon: Icons.settings,
                            text: "设置",
                            onPressed: () {
                              // 隐藏本界面
                              ctrl.hide();
                              // 同时需要隐藏局部区域模态窗口
                              removeOverlay(ResponseData());

                              settingCtrl.show();
                            },
                          ),

                          // 关于按钮
                          buildButton(
                            icon: Icons.details,
                            text: "关于",
                            onPressed: () {
                              // 隐藏本界面
                              ctrl.hide();
                              // 同时需要隐藏局部区域模态窗口
                              removeOverlay(ResponseData());

                              aboutCtrl.show();
                            },
                          ),

                          // 退出账号按钮
                          buildButton(
                            icon: Icons.logout,
                            text: "退出账号",
                            onPressed: () {
                              // 隐藏本界面
                              ctrl.hide();
                              // 同时需要隐藏局部区域模态窗口
                              removeOverlay(ResponseData());

                              // 隐藏主界面
                              mainCtrl.hide();
                              // 返回显示登录界面
                              loginCtrl.show();
                            },
                          ),
                        ],
                      ),
                    )),

                // 按压拖动回调，以支持鼠标移动界面
                onPanUpdate: (details) {
                  ctrl.offset += details.delta;
                }))));
  }

  // 将按钮封装为可复用的自定义函数
  Widget buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    EdgeInsets padding = const EdgeInsets.all(12),
  }) {
    return SizedBox(
        width: 152,
        height: 25,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white), // 按扭背景颜色
            foregroundColor: WidgetStateProperty.all(
                Color.fromARGB(255, 245, 245, 245)), // 按钮文本颜色
            side: WidgetStateProperty.all(const BorderSide(
              width: 1,
              color: Colors.white, // 边框颜色
            )),
            padding: WidgetStateProperty.all(EdgeInsets.zero), // 内边距设置为0
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 间距
              SizedBox(width: 12),

              // 图标
              Icon(
                icon,
                size: 20,
                color: Colors.grey,
              ),

              // 间距
              SizedBox(width: 6),

              // 文本
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal, // 设置字体粗细为粗体
                ),
              )
            ],
          ),
        ));
  }
}
