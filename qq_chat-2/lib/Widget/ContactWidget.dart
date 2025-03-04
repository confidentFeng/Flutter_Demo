import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 状态类
class ContactState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 250.0.obs; // 宽度
  final _height = 500.0.obs; // 高度
}

// 控制器类
class ContactController extends GetxController {
  final ContactState state = ContactState();

  double get width => state._width.value;
  set width(double value) => state._width.value = value;

  double get height => state._height.value;
  set height(double value) => state._height.value = value;

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
}

// 在线状态
enum OnlineState { Online, Leave, Busy, DoNot }

// 联系人项
class ContactItem {
  final String title;
  bool isExpand;  
  final List<ContactChildItem> children;

  ContactItem({required this.title, required this.isExpand, required this.children});
}

// 联系人子项
class ContactChildItem {
  final String image;
  final String text;
  final OnlineState state;

  ContactChildItem({required this.image, required this.text, required this.state});
}

// 联系人数据源
final List<ContactItem> items = [
  ContactItem(
    title: '我的好友',
    isExpand: false,
    children: [
      ContactChildItem(
          image: 'assets/Contact/1.png',
          text: '明兰',
          state: OnlineState.Online
      ),
      ContactChildItem(
          image: 'assets/Contact/2.png',
          text: '静静',
          state: OnlineState.Leave
      ),
      ContactChildItem(
          image: 'assets/Contact/3.png',
          text: '李思思',
          state: OnlineState.Leave
      ),      
    ],
  ),

  ContactItem(
    title: '家人',
    isExpand: false,    
    children: [
      ContactChildItem(
          image: 'assets/Contact/4.png',
          text: '东东',
          state: OnlineState.Online
      ),
      ContactChildItem(
          image: 'assets/Contact/5.png',
          text: '胖胖',
          state: OnlineState.Leave
      ),
    ],
  ),

  ContactItem(
    title: '同学',
    isExpand: false,    
    children: [
      ContactChildItem(
          image: 'assets/Contact/6.png',
          text: '王虎',
          state: OnlineState.Online
      ),
      ContactChildItem(
          image: 'assets/Contact/7.png',
          text: '贺强',
          state: OnlineState.Leave
      ),
    ],
  ), 

  ContactItem(
    title: '同事',
    isExpand: false,    
    children: [
      ContactChildItem(
          image: 'assets/Contact/8.png',
          text: '李达',
          state: OnlineState.Online
      ),
      ContactChildItem(
          image: 'assets/Contact/9.png',
          text: '武无敌',
          state: OnlineState.Leave
      ),
    ],
  ),  

  ContactItem(
    title: '陌生人',
    isExpand: false,    
    children: [
      ContactChildItem(
          image: 'assets/Contact/10.png',
          text: '郑航',
          state: OnlineState.Online
      ),
      ContactChildItem(
          image: 'assets/Contact/11.png',
          text: '美琴',
          state: OnlineState.Leave
      ),
    ],
  ),    
];

// 联系人列表界面
class ContactWidget extends StatefulWidget {
  const ContactWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactWidgetState createState() => _ContactWidgetState();
}

// 联系人列表界面
class _ContactWidgetState extends State<ContactWidget> {
  final ContactController ctrl = Get.find<ContactController>(); // 登录界面控制器

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      // 必须使用Obx才能正常显示下面界面
      // 手势识别组件，以让鼠标移动到该组件上时光标为"选中样式"
      behavior: HitTestBehavior.opaque,
      child: Visibility(
        // 是一个用于根据布尔值条件显示或隐藏小部件的控件
        visible: !ctrl.isHidden(), // 控制是否显示
        maintainState: true,
        child: Container(
            width: ctrl.width,
            height: ctrl.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: ListView.builder(
              // 使用 ListView.builder 可以高效地批量生成 ExpansionTile 列表
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ExpansionTile(
                  backgroundColor: Colors.white,
                  tilePadding: EdgeInsets.only(left: 10, right: 20),
                  shape: Border(
                      top: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: Colors.transparent)),
                  dense: true,
                  minTileHeight: 40,
                  leading: Icon(
                    item.isExpand
                        ? Icons.arrow_drop_down
                        : Icons.arrow_right, // 左侧动态图标
                  ),
                  title: Text(
                    // 联系人组名称
                    item.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  trailing: SizedBox.shrink(), // 隐藏右侧的默认图标
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      item.isExpand = expanded;
                    });
                  },
                  children: item.children
                      .map<Widget>((child) => ListTile(
                            contentPadding: EdgeInsets.only(left: 10),
                            hoverColor: Color.fromRGBO(245, 245, 245, 1.0),
                            dense: true,
                            minTileHeight: 40,
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    child.image)), // 联系人头像（左侧圆形图片）
                            title: Text(
                              // 联系人名称
                              child.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    // 状态图标
                                    image: AssetImage(
                                      child.state == OnlineState.Online
                                          ? 'assets/Contact/icon_state_online.png'
                                          : 'assets/Contact/icon_state_leave.png',
                                    ),
                                    width: 12,
                                    height: 12,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    // 状态文本
                                    "在线",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ]),
                            onTap: () {},
                          ))
                      .toList(),
                  );
                },
              )
            )
          )
        )
      );
  }
}
