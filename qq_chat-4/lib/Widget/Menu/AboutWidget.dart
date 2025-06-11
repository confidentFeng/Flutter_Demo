import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Util/Controller.dart';

// 状态类
class AboutState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 360.0.obs; // 宽度
  final _height = 480.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
}

// 控制器类
class AboutController extends GetxController {
  final AboutState state = AboutState();

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

  AboutController() {
    // 新加：初始化界面的偏移
    state._offset.value = Offset(
        (globalCtrl.screenSize.width - state._width.value) / 2,
        (globalCtrl.screenSize.height - state._height.value) / 2);
  }
}

// 关于界面
class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AboutWidgetState createState() => _AboutWidgetState();
}

// 关于界面实现
class _AboutWidgetState extends State<AboutWidget> {
  final AboutController ctrl = Get.find<AboutController>(); // 登录界面控制器

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
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Widget/icon_qqAbout.png'), // 背景图片路径
                          fit: BoxFit.cover, // 图片填充模式
                        ),
                        borderRadius: BorderRadius.circular(10), // 圆角边框                        
                        boxShadow: [
                          // 边框阴影
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // 阴影颜色和透明度
                            spreadRadius: 2, // 阴影扩散范围
                            blurRadius: 2, // 阴影模糊程度
                            offset: Offset(0, 1), // 阴影偏移
                          ),
                        ],                                             
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // 确保子部件从顶部开始排列
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // 确保子部件从左侧开始排列
                        children: [
                          // 关闭按钮
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                ctrl.hide();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                              ),
                              padding: EdgeInsets.zero,
                            )
                          ),
                        ],
                      ),
                    )),

                // 按压拖动回调，以支持鼠标移动界面
                onPanUpdate: (details) {
                  ctrl.offset += details.delta;
                }))));
  }
}
