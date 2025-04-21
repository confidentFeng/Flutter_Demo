import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // 用于 Clipboard
import '../Util/EventBus.dart';
import '../Util/EnumType.dart';

// 状态类
class ChatState {
  final _isHidden = false.obs; // 是否隐藏
  final _width = 490.0.obs; // 宽度
  final _height = 500.0.obs; // 高度
  final _userId = '0'.obs;
  final _image = ''.obs;
  final _lastMsg = ''.obs;
}

// 控制器类
class ChatController extends GetxController {
  final ChatState state = ChatState();

  double get width => state._width.value;
  set width(double value) => state._width.value = value;

  double get height => state._height.value;
  set height(double value) => state._height.value = value;

  String get getUserId => state._userId.value;
  void setUserId(String value) => state._userId.value = value;

  String get getImage => state._image.value;
  void setIamge(String value) => state._image.value = value;

  String get getLastMsg => state._lastMsg.value;
  void setLastMsg(String value) => state._lastMsg.value = value;

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

  // 构造函数内接收“全局事件总线消息”
  ChatController() {
    eventBus.on<BusDataObject>().listen((BusDataObject event) async {
      if (event.dataType == BusDataType.DataType_MsgSend) {
        // 内存异常处理
        if (event.dataList == null) return;

        // 接收当前用户索引、用户头像、最近消息
        String curIndex = event.dataList![0].toString();
        String curImage = event.dataList![1];
        String curLastMsg = event.dataList![2];
        debugPrint(
            "Recv curMessageIndex: $curIndex ,curImage:  $curImage ,curLastMsg:  $curLastMsg");

        // 设置当前用户索引、用户头像、最近消息
        setUserId(curIndex);
        setIamge(curImage);
        setLastMsg(curLastMsg);
        update();
      }
    });
  }
}

// 聊天消息类
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime time;
  final String icon;
  final _index = 0;

  const ChatMessage(
      {super.key,
      required this.text,
      required this.isMe,
      required this.time,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final index =
        (context.findAncestorWidgetOfExactType<ChatMessage>())?._index;

    return GestureDetector(
      onSecondaryTapDown: (details) =>
          _showContextMenu(context, details.globalPosition, index!),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMe
            ? [
                circleMessage(context),
                headIamge()
              ] // _isLeft 为 true 时，WidgetA 在左，WidgetB 在右
            : [
                headIamge(),
                circleMessage(context)
              ], // _isLeft 为 false 时，WidgetB 在左，WidgetA 在右
      ),
    );
  }

  // 头像
  Widget headIamge() {
    return CircleAvatar(
      // 状态图标
      backgroundImage: AssetImage(
        isMe ? 'assets/Contact/head.png' : icon,
      ),
    );
  }

  // 圆角矩阵消息
  Widget circleMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft, // 根据是否为自身发送的消息，修改消息位置
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.75), // BoxConstraints用于限制Widget的宽度和高度
        child: Container(
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromRGBO(0, 153, 255, 1)
                : Colors.white, // 根据是否为自身发送的消息，修改消息背景色
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SelectableText(
                text,
                style: TextStyle(
                    fontSize: 16, color: isMe ? Colors.white : Colors.black),
                onSelectionChanged: (selection, cause) {
                  // 监听用户选择的文本范围，并执行自定义操作
                  if (selection.end > selection.start) {
                    final selectedText =
                        text.substring(selection.start, selection.end);

                    // 实时打印选中的文本
                    debugPrint('选中的文本：$selectedText');

                    // 实时复制选中的文本
                    Clipboard.setData(ClipboardData(text: selectedText));
                  }
                },
              ),
              SizedBox(height: 4),
              Text(
                "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示右键菜单
  void _showContextMenu(BuildContext context, Offset position, int index) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final menuPosition = RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: menuPosition,
      items: [
        PopupMenuItem(
          child: ListTile(leading: Icon(Icons.copy), title: Text("复制")),
          onTap: () => Clipboard.setData(ClipboardData(text: text)),
        ),
        PopupMenuItem(
          child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("删除")),
          onTap: () => (context
              .findAncestorStateOfType<_ChatWidgetState>()
              ?._deleteMessage(index)),
        ),
      ],
    );
  }
}

// 聊天界面
class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatWidgetState createState() => _ChatWidgetState();
}

// 聊天界面实现
class _ChatWidgetState extends State<ChatWidget> {
  // 初始数据源
  final Map<String, List<ChatMessage>> messageMap = {
    '0': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '1': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '2': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '3': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '4': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '5': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '6': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '7': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
    '8': [
      ChatMessage(
          text: "",
          isMe: false,
          time: DateTime.now().subtract(Duration(minutes: 5)),
          icon: ''),
    ],
  };

  final ChatController ctrl = Get.find<ChatController>(); // 聊天消息界面控制器

  final TextEditingController _controller =
      TextEditingController(); // 用于监听输入框的内容变化
  bool isButtonDisabled = true; // 用于控制按钮的禁用状态，初始值为 true，表示按钮被禁用

  // 发送消息
  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      // 根据用户id索引获取"聊天消息列表"
      final List<ChatMessage> messageList = messageMap[ctrl.getUserId] ?? [];

      // 获取"聊天消息列表"的消息数目
      final int msgCnt = (messageMap[ctrl.getUserId] ?? []).length;

      // 将对方的唯一消息加入"聊天消息列表"中
      if (msgCnt == 1) {
        // 要先删除原先的"空白消息"
        _deleteMessage(0);

        // 再添加对方消息
        messageList.add(ChatMessage(
          text: ctrl.getLastMsg,
          isMe: false,
          time: DateTime.now(),
          icon: 'assets/Contact/head.png',
        ));
      }

      messageList.add(ChatMessage(
        text: _controller.text,
        isMe: true,
        time: DateTime.now(),
        icon: 'assets/Contact/head.png',
      ));
      _controller.clear();
    });
  }

  // 删除消息
  void _deleteMessage(int index) {
    setState(() {
      // 根据用户id索引获取"聊天消息列表"
      final List<ChatMessage> messageList = messageMap[ctrl.getUserId] ?? [];

      messageList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已删除消息"), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        // 必须使用Obx才能正常显示下面界面
        // 手势识别组件，以让鼠标移动到该组件上时光标为"选中样式"
        behavior: HitTestBehavior.opaque,
        child: Visibility(
            // 是一个用于根据布尔值条件显示或隐藏小部件的控件
            visible: !ctrl.isHidden(), // 控制是否显示
            maintainState: true,
            child: Container(
                width: ctrl.width,
                height: 500,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1.0),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // 确保子部件从顶部开始排列
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // 确保子部件从左侧开始排列
                    children: [
                      // 聊天消息界面
                      Expanded(
                          child: Obx(
                        () => ListView.builder(
                          padding: EdgeInsets.all(20),
                          reverse: true,
                          itemCount: (messageMap[ctrl.getUserId] ?? [])
                              .length, // "聊天消息列表"的消息数目
                          itemBuilder: (context, index) {
                            // 根据用户id索引获取"聊天消息列表"
                            final List<ChatMessage> messageList =
                                messageMap[ctrl.getUserId] ?? [];
                            // 获取"聊天消息列表"中的对应索引的消息
                            final ChatMessage message =
                                messageList.reversed.toList()[index];
                            // 获取"聊天消息列表"的消息数目
                            final int msgCnt =
                                (messageMap[ctrl.getUserId] ?? []).length;

                            // 显示聊天消息
                            return ChatMessage(
                              text:
                                  msgCnt == 1 ? ctrl.getLastMsg : message.text,
                              isMe: message.isMe,
                              time: message.time,
                              icon: ctrl.getImage,
                            );
                          },
                        ),
                      )),

                      // 输入区域界面
                      _buildInputArea(),
                    ]))),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateButtonState); // 监听输入框内容变化
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 更新按钮状态的函数
  void _updateButtonState() {
    setState(() {
      isButtonDisabled = _controller.text.isEmpty; // 输入框为空时禁用按钮
    });
  }

  // 输入区域界面
  Widget _buildInputArea() {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey[200],
      child: Stack(
        alignment: Alignment.topLeft,

        // 输入编辑框
        children: <Widget>[
          Positioned(
              left: 8,
              top: 8,
              child: SizedBox(
                  width: ctrl.width,
                  height: 300,
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "输入消息...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ))),

          // 发送按钮
          Positioned(
            right: 10,
            bottom: 10,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: isButtonDisabled
                    ? WidgetStateProperty.all(Colors.grey)
                    : WidgetStateProperty.all(Colors.blue), // 按扭背景颜色
                foregroundColor:
                    WidgetStateProperty.all(Colors.white), // 按钮文本颜色
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))), // 圆角
              ),
              onPressed: isButtonDisabled ? null : _sendMessage, // 根据条件禁用或启用按钮
              child: const Text("发送"),
            ),
          )
        ],
      ),
    );
  }
}
