import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/Controller.dart';
import '../Widget/ContactWidget.dart';
import '../Widget/MessageWidget.dart';
import '../Widget/ChatWidget.dart';

// 状态类
class MainState {
  final _isHidden = false.obs; // 是否隐藏
  final _width = 800.0.obs; // 宽度
  final _height = 500.0.obs; // 高度
  final _offset = const Offset(0, 0).obs; // 位置
}

// 控制器类
class MainController extends GetxController {
  final MainState state = MainState();

  double get width => state._width.value;
  set width(double value) => state._width.value = value;

  double get height => state._height.value;
  set height(double value) => state._height.value = value;

  Offset get offset => state._offset.value;
  set offset(Offset value) => state._offset.value = value;

  MainController() {
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
}

// 主界面
class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  final MainController ctrl = Get.find<MainController>(); // 主界面控制器

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
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // 确保子部件从顶部开始排列
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // 确保子部件从左侧开始排列
                        children: [
                          // 菜单按钮列表界面
                          MenuBtnList(),

                          // 堆叠选择界面
                          StackSelWidget(),

                          // 聊天界面
                          ChatWidget(),
                        ],
                      ),
                    )),

                // 按压拖动回调，以支持鼠标移动界面
                onPanUpdate: (details) {
                  ctrl.offset += details.delta;
                }))));
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
  final MainController loginCtrl = Get.find<MainController>();
  final ContactController contactCtrl = Get.find<ContactController>();
  final MessageController messageCtrl = Get.find<MessageController>();
  final ChatController chatCtrl = Get.find<ChatController>();

  int selectedIndex = 0; // 当前选中的按钮索引，以实现互斥按钮组

  @override
  void initState() {
    super.initState();
    // 默认选中第一个选项并执行其点击函数
    selectedIndex = 0;
    messageCtrl.show();
    contactCtrl.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: loginCtrl.height,
      color: Colors.transparent,
      padding: EdgeInsets.all(8.0), // 容器内部的间距为0（如果有的话）
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 确保子部件从顶部开始排列
        crossAxisAlignment: CrossAxisAlignment.end, // 确保子部件从左侧开始排列
        children: <Widget>[
          // 距离上一个View距离
          const SizedBox(height: 6),

          // QQ名称
          Text(
            'QQ  ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),

          // 登录用户头像
          ClipOval(
            child: Image.asset(
              "assets/Contact/head.png",
              width: 40,
              height: 40,
            ),
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),

          /*** 自定义逻辑来实现互斥按钮组 ***/
          // 消息按钮
          CustomTipBtn(
            text: '消息',
            icon: Icon(
              Icons.messenger,
              color: selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                selectedIndex = 0;

                // 控制界面显示
                messageCtrl.show();
                contactCtrl.hide();
                chatCtrl.show();
              });
            },
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),

          // 联系人按钮
          CustomTipBtn(
            text: '联系人',
            icon: Icon(
              Icons.person_3,
              color: selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                selectedIndex = 1;

                // 控制界面显示
                messageCtrl.hide();
                contactCtrl.show();
                chatCtrl.hide();                
              });
            },
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),

          // 收藏按钮
          CustomTipBtn(
            text: '收藏',
            icon: Icon(
              Icons.favorite,
              color: selectedIndex == 2 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                selectedIndex = 2;

                // 控制界面显示
                messageCtrl.hide();
                contactCtrl.hide();
                chatCtrl.hide();                
              });
            },
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),

          // 设置按钮
          CustomTipBtn(
            text: '设置',
            icon: Icon(
              Icons.settings_applications,
              color: selectedIndex == 3 ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                selectedIndex = 3;

                // 控制界面显示
                messageCtrl.hide();
                contactCtrl.hide();
                chatCtrl.hide();                
              });
            },
          ),

          // 距离上一个View距离
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// 堆叠选择界面
class StackSelWidget extends StatelessWidget {
  StackSelWidget({super.key});

  // 控制器定义
  final MainController ctrl = Get.find<MainController>();

  // 各界面对象创建
  final MessageWidget messageWidget = MessageWidget();
  final ContactWidget contactWidget = ContactWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: ctrl.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        // 重叠存放多个子界面在同一个Stack界面中，根据左边按钮来选择哪个界面显示出来，其它隐藏
        alignment: Alignment.topLeft,
        children: <Widget>[
          messageWidget, // 聊天消息界面
          contactWidget, // 联系人界面
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
