import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LoginWidget.dart';

// 状态类
class LogoState {
  final _offset = Offset.zero.obs; // 平移距离
  final _isVisable = true.obs; // 是否显示的变量
  final _x = 50.0.obs; // 水平方向的边距
  final _y = 20.0.obs; // 垂直方向的边距
}

// 控制器类
class LogoControl extends LogoState {
  final _state = LogoState();

  // 控制函数实现，以下类似
  Offset get offset => _state._offset.value;
  set offset(Offset value) => _state._offset.value = value;

  bool get isVisable => _state._isVisable.value;
  set setVisable(bool val) => _state._isVisable.value = val;

  double get x => _state._x.value;
  set x(double value) => _state._x.value = value;

  double get y => _state._y.value;
  set y(double value) => _state._y.value = value;
}

class LogoWidget extends StatelessWidget {
  LogoWidget({super.key});

  // 实现控制器
  final LogoControl logoControl = Get.find<LogoControl>();
  final LoginController loginControl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Positioned (
      right: logoControl.x.w,
      top: logoControl.y.h,
      child: Obx(() => Transform.translate ( // 让部件在 x、y 轴上平移指定的距离
        offset: logoControl.offset, // 平移距离
        child: GestureDetector( // 手势识别组件
          behavior: HitTestBehavior.opaque,
          child: Visibility( // 是一个用于根据布尔值条件显示或隐藏小部件的控件
            visible: loginControl.isHidden(),
            maintainState: true,
            child: MouseRegion( // 以让鼠标移动到该组件上时光标为"选中样式"
                cursor: SystemMouseCursors.click, // 光标为"选中样式"
                child: IconButton(
                  mouseCursor: SystemMouseCursors.click,
                  onPressed: null,
                  iconSize: 45.w,
                  icon: Image.asset("assets/images/btn_logo.png"), // 显示图标
                ),
            ),   
          ),
          // 按压拖动回调，以支持鼠标移动界面
          onPanUpdate: (details) {
              // 通过修改平移距离变量来移动界面
              logoControl.offset += details.delta;
          },
          // 点击事件回调
          onTap: () {
              // 显示登录界面
              loginControl.show();
          },             
        ),
      ))
    );
  }
}
