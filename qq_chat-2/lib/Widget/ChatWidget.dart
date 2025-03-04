import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 状态类
class ChatState {
  final _isHidden = true.obs; // 是否隐藏
  final _width = 250.0.obs; // 宽度
  final _height = 500.0.obs; // 高度
}

// 控制器类
class ChatController extends GetxController {
  final ChatState state = ChatState();

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

// 聊天消息类定义
class Chat {
  final String id; // 索引id
  final String name; // 联系人名称
  final String lastMessage; // 最近消息
  final String image; // 头像
  final DateTime timestamp; // 时间

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.image,
    required this.timestamp,
  });
}

// 聊天消息数据源
final List<Chat> chatList = [
  Chat(
    id: '1',
    name: '李达',
    lastMessage: '好的，有空再聚',
    image: 'assets/Contact/8.png',
    timestamp: DateTime.now().subtract(Duration(minutes: 10)),
  ),
  Chat(
    id: '2',
    name: '王虎',
    lastMessage: '拜拜，下次一起玩',
    image: 'assets/Contact/6.png',
    timestamp: DateTime.now().subtract(Duration(hours: 1)),
  ),
  Chat(
      id: '3',
      name: '明兰',
      lastMessage: '有人在玩吗',
      image: 'assets/Contact/1.png',
      timestamp: DateTime.now().subtract(Duration(hours: 3))),
  Chat(
      id: '4',
      name: '李思思',
      lastMessage: '没什么想玩的',
      image: 'assets/Contact/3.png',
      timestamp: DateTime.now().subtract(Duration(hours: 5))),
  Chat(
      id: '5',
      name: '武无敌',
      lastMessage: '拜拜，晚安',
      image: 'assets/Contact/9.png',
      timestamp: DateTime.now().subtract(Duration(hours: 14))),
  Chat(
    id: '6',
    name: '郑航',
    lastMessage: '芜湖，起飞',
    image: 'assets/Contact/10.png',
    timestamp: DateTime.now().subtract(Duration(days: 1)),
  ),
  Chat(
    id: '7',
    name: '贺强',
    lastMessage: '有空一起钓鱼啊',
    image: 'assets/Contact/7.png',
    timestamp: DateTime.now().subtract(Duration(days: 2)),
  ),
  Chat(
    id: '8',
    name: '美琴',
    lastMessage: '嗯嗯，你也晚安',
    image: 'assets/Contact/11.png',
    timestamp: DateTime.now().subtract(Duration(days: 4)),
  ),
  Chat(
    id: '9',
    name: '静静',
    lastMessage: '六六六',
    image: 'assets/Contact/2.png',
    timestamp: DateTime.now().subtract(Duration(days: 4)),
  ),
];

// 聊天消息界面
class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactWidgetState createState() => _ContactWidgetState();
}

// 聊天消息界面
class _ContactWidgetState extends State<ChatWidget> {
  final ChatController ctrl = Get.find<ChatController>(); // 聊天消息界面控制器

  // 删除项目的方法
  void _deleteItem(int index) {
    // 下方弹出提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已删除"${chatList[index].name}"的聊天消息')),
    );

    setState(() {
      chatList.removeAt(index); // 从数据源中删除项目
    });
  }

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
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final chat = chatList[index];
                  return HoverListTile(
                    image: chat.image, // 头像
                    title: chat.name, // 名称
                    lastMessage: chat.lastMessage, // 最近聊天消息
                    timestamp: chat.timestamp, // 时间
                    onDelete: () {
                      // 在这里处理删除逻辑
                      debugPrint('删除项目 $index');

                      _deleteItem(index);
                    },
                  );
                },
              ),
            ))));
  }
}

// 自定义悬浮高亮的ListTile
class HoverListTile extends StatefulWidget {
  final String image;
  final String title;
  final String lastMessage;
  final DateTime timestamp;
  final VoidCallback onDelete;

  // ignore: use_key_in_widget_constructors
  const HoverListTile(
      {required this.image,
      required this.title,
      required this.lastMessage,
      required this.timestamp,
      required this.onDelete});

  @override
  // ignore: library_private_types_in_public_api
  _HoverListTileState createState() => _HoverListTileState();
}

// 自定义悬浮高亮的ListTile（使用 InkWell 实现）
class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false; // 鼠标是否悬浮的状态变量

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // 移入事件
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      // 移出事件
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          debugPrint('${widget.title} tapped');
        },
        onSecondaryTapDown: (details) {
          // 右键点击事件
          _showCustomMenu(context, details.globalPosition);
        },
        child: Container(
          color: isHovered ? Color.fromRGBO(245, 245, 245, 1.0) : Colors.transparent, // 通过 isHovered 状态变量来控制是否显示高亮效果
          child: ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(widget.image),), // 左侧头像图标
            title: Text(widget.title),
            subtitle: Text(widget.lastMessage),
            trailing: Text('${widget.timestamp.hour}:${widget.timestamp.minute}', style: TextStyle(color: Colors.grey), // 右侧时间文本
            ),
          ),
        ),
      ),
    );
  }

  // 显示自定义右键菜单的函数
  void _showCustomMenu(BuildContext context, Offset position) {
    // 设置右键菜单弹出的位置
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect positionRelativeToOverlay = RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    );

    // 右键菜单列表
    showMenu(
        context: context,
        position: positionRelativeToOverlay,
        items: [
          _buildMenuItem(context, '复制QQ号', Icons.copy, () {
            debugPrint('复制QQ号');
          }),
          _buildMenuItem(context, '从消息列表中移除', Icons.delete, () {
            debugPrint('从消息列表中移除');

            widget.onDelete();
          }),
          _buildMenuItem(context, '屏蔽此人消息', Icons.disabled_visible, () {
            debugPrint('屏蔽此人消息');
          }),
        ],
        elevation: 8, // 菜单阴影
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ) // 菜单圆角
        );
  }

  // 自定义菜单列表项
  PopupMenuItem _buildMenuItem(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.grey), // 图标
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 14)), // 文字
        ],
      ),
    );
  }
}
