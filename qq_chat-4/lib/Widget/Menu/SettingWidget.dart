import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Util/Controller.dart';

// 状态类
class SettingState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 840.0.obs; // 宽度
  final _height = 600.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
}

// 控制器类
class SettingController extends GetxController {
  final SettingState state = SettingState();

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

  SettingController() {
    // 新加：初始化界面的偏移
    state._offset.value = Offset(
        (globalCtrl.screenSize.width - state._width.value) / 2,
        (globalCtrl.screenSize.height - state._height.value) / 2);
  }
}

// 主界面
class SettingWidget extends StatelessWidget {
  SettingWidget({super.key});

  final SettingController ctrl = Get.find<SettingController>(); // 主界面控制器

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
                    color: Color.fromARGB(255, 245, 245, 245),
                    border: Border.all(
                        width: 2.0,
                        color: Color.fromARGB(255, 242, 242, 242)),
                  ),
                  child: Stack(
                    children: [
                      Center(child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // 确保子部件从顶部开始排列
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // 确保子部件从左侧开始排列
                        children: [
                          // 菜单按钮列表界面
                          MenuBtnList(),

                          // 堆叠选择界面
                          StackSelWidget(),
                        ],
                      )),


                      // 关闭按钮
                      Align(
                        alignment: Alignment.topRight,
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
                    ]                        
                  )                    
                ),
              ),
              // 按压拖动回调，以支持鼠标移动界面
              onPanUpdate: (details) {
                ctrl.offset += details.delta;
              }          
            )         
        )
      )         
    );
  }
}

// 菜单按钮列表界面
class MenuBtnList extends StatefulWidget {
  const MenuBtnList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuBtnListState createState() => _MenuBtnListState();
}

// 菜单按钮列表界面实现
class _MenuBtnListState extends State<MenuBtnList> {
  // 控制器定义
  final SettingController loginCtrl = Get.find<SettingController>();

  int selectedIndex = 0; // 当前选中的按钮索引，以实现互斥按钮组

  @override
  void initState() {
    super.initState();
    // 默认选中第一个选项并执行其点击函数
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: loginCtrl.height,
      color: Colors.white,
      padding: EdgeInsets.all(8.0), // 容器内部的间距为0（如果有的话）
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 确保子部件从顶部开始排列
        crossAxisAlignment: CrossAxisAlignment.end, // 确保子部件从左侧开始排列
        children: <Widget>[
          // 距离上一个View距离
          const SizedBox(height: 30),

          // 通用按钮
          HoverIconButton(
            text: '通用',
            icon: Icons.list,
            isChecked: selectedIndex == 0 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 0;


              });
            },
          ), 

          // 间距
          SizedBox(height: 6),            

          // 消息通知按钮
          HoverIconButton(
            text: '消息通知',
            icon: Icons.notifications,
            isChecked: selectedIndex == 1 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 1;


              });
            },
          ), 

          // 间距
          SizedBox(height: 6),  

          // 存储管理按钮
          HoverIconButton(
            text: '存储管理',
            icon: Icons.sd_card,
            isChecked: selectedIndex == 2 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 2;


              });
            },
          ), 

          // 间距
          SizedBox(height: 6),            

          // 快捷键按钮
          HoverIconButton(
            text: '快捷键',
            icon: Icons.keyboard,
            isChecked: selectedIndex == 3 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 3;


              });
            },
          ), 

          // 间距
          SizedBox(height: 6),          

          // 权限设置按钮
          HoverIconButton(
            text: '权限设置',
            icon: Icons.manage_accounts,
            isChecked: selectedIndex == 4 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 4;


              });
            },
          ), 

          // 间距
          SizedBox(height: 6),             

          // 登录设置按钮
          HoverIconButton(
            text: '登录设置',
            icon: Icons.verified_user_outlined,
            isChecked: selectedIndex == 5 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 5;


              });
            },
          ),   

          // 间距
          SizedBox(height: 6),             

          // 超级调色盘按钮
          HoverIconButton(
            text: '超级调色盘',
            icon: Icons.palette,
            isChecked: selectedIndex == 6 ? true : false,
            onPressed: () async {
              setState(() {
                selectedIndex = 6;


              });
            },
          ),                  

          // 距离上一个View距离
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // 将按钮封装为可复用的自定义函数
  Widget buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    EdgeInsets padding = const EdgeInsets.all(12),
  }) {
    return SizedBox(
        width: 186,
        height: 40,
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
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal, // 设置字体粗细为粗体
                ),
              )
            ],
          ),
        ));
  }
}

// 堆叠选择界面
class StackSelWidget extends StatelessWidget {
  StackSelWidget({super.key});

  // 控制器定义
  final SettingController ctrl = Get.find<SettingController>();

  // 各界面对象创建

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 590,
      height: ctrl.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        // 重叠存放多个子界面在同一个Stack界面中，根据左边按钮来选择哪个界面显示出来，其它隐藏
        alignment: Alignment.topLeft,
        children: <Widget>[
          
        ],
      ),
    );
  }
}

// 提示图标按钮实现
class CustomTipBtn extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback? onPressed;

  const CustomTipBtn(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      decoration: BoxDecoration(
        color: Colors.white, // 背景色
        borderRadius: BorderRadius.circular(5), // 圆角
      ),
      textStyle: TextStyle(
        color: Colors.grey, // 文字颜色
        fontSize: 14, // 文字大小
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

// 悬浮提示图标按钮
class HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isChecked;
  final String text;

  const HoverIconButton({
    required this.icon,
    required this.onPressed,
    this.isChecked = false,
    required this.text,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HoverIconButtonState createState() => _HoverIconButtonState();
}

// 悬浮提示图标按钮实现
class _HoverIconButtonState extends State<HoverIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: SizedBox(
        width: 186,
        height: 40,
        child: OutlinedButton(
          style: ButtonStyle(
            // 选择/未选中鼠标悬浮/未选中鼠标移出，对应的3种按钮背景颜色
            backgroundColor: widget.isChecked ? WidgetStateProperty.all(
                Color.fromARGB(255, 235, 235, 235)) :_isHovered ? WidgetStateProperty.all(
                Color.fromARGB(255, 245, 245, 245)) : WidgetStateProperty.all(Colors.white), // 按扭背景颜色
            foregroundColor: WidgetStateProperty.all(
                Colors.black), // 按钮文本颜色
            side: WidgetStateProperty.all(const BorderSide(
              width: 1,
              color: Colors.white, // 边框颜色
            )),
            padding: WidgetStateProperty.all(EdgeInsets.zero), // 内边距设置为0
          ),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // 左对齐
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 间距
              SizedBox(width: 12),

              // 图标
              Icon(
                widget.icon,
                size: 20,
                color: Colors.grey,
              ),

              // 间距
              SizedBox(width: 6),

              // 文本
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal, // 设置字体粗细为粗体
                ),
              )
            ],
          ),
        ))
        );
  }
}
