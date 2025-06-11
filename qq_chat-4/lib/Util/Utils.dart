// ignore_for_file: body_might_complete_normally_nullable, prefer_is_empty, null_argument_to_non_null_type, unrelated_type_equality_checks, unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'dart:async';
import '../Util/Controller.dart';

// 局部区域模态化参数
OverlayEntry? overlayEntry;
Completer<ResponseData>? completer;

// 回复数据结构
class ResponseData{
    final dynamic data;
    final int? status;
    ResponseData({this.data, this.status});
}

// 异步显示模态窗, 要想响应模态窗中子窗口的操作, 需要在子窗口中使用Navigator.pop返回
Future<ResponseData?> showDialogAsync(BuildContext? context, Widget childWidget, {GlobalKey? widgetKey, bool isBarrierDismissible=true, Color barrierColors = Colors.transparent}) async
{
  if ( context != null )
  {
    final result = await showDialog<ResponseData>(
    barrierColor: barrierColors, // 设置为透明色可以隐藏背景遮罩层
    barrierDismissible: isBarrierDismissible,           // 点击背景蒙层是否隐藏, 默认隐藏
    context: context,
    builder: (context) {
      return Listener(
        onPointerDown: (event) {
          globalCtrl.globalMousePressPos = event.localPosition;
        },
        child: Stack(
          children: [
            childWidget,
          ],
        ),
      );
    },
  );
  return result;
  }
}

// 局部区域模态窗口状态
bool isOverlayEntryWorking(OverlayEntry? overlayEntry)
{
  return overlayEntry != null && overlayEntry.mounted;
}

class OverlayEntryData
{
  OverlayEntry? overlayEntry;
  Completer<ResponseData>? completer;
  OverlayEntryData(this.overlayEntry, this.completer);
}

List<OverlayEntryData> overlayEntries = [];

// 局部区域模态窗口       areaPos: 模态窗区域开始的位置
Future<ResponseData?> showOverlayEntrysync(BuildContext? context,double areaWidth, double areaHeight, Offset areaPos, Widget childWidget, 
                                          {bool isBarrierDismissible=true, Color barrierColors = const Color.fromARGB(172, 0, 0, 0),
                                           bool isExpand = false, void Function()? onCallbackFunc}) async
{
    if ( context != null ) 
    {
      Completer<ResponseData> completer = Completer<ResponseData>();
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                left: areaPos.dx,
                top: areaPos.dy,
                child: Navigator(
                  requestFocus: false,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (context) {
                        return  GestureDetector(
                          onTap: isBarrierDismissible ? (){
                            Navigator.of(context).pop(ResponseData());
                            removeOverlay(ResponseData());
                            if(onCallbackFunc != null){
                              onCallbackFunc();
                            }
                          } : null,
                          onSecondaryTapDown: isBarrierDismissible ? (details) {
                            Navigator.of(context).pop(ResponseData());
                            removeOverlay(ResponseData());
                            if(onCallbackFunc != null){
                              onCallbackFunc();
                            }
                          } : null,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(       // 模态背景窗
                              width: areaWidth,
                              height: areaHeight,
                              color: barrierColors,
                              child: GestureDetector(
                                onTap: (){},        // 防止点击事件透到外层的OnTap
                                child: Stack(
                                  fit: isExpand? StackFit.expand : StackFit.loose,
                                  children: [
                                    childWidget
                                  ],
                                ),
                              )
                            ),
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
            ],
          );
        },
      );
      overlayEntries.add(OverlayEntryData(overlayEntry, completer));
      Overlay.of(context).insert(overlayEntry);
      return completer.future;
    }
}

// 是否弹窗正在显示
bool isOverlayEntryShow()
{
    return overlayEntries.length > 0;
}

// 销毁局部区域模态窗口
void removeOverlay(ResponseData data) 
{
    if (overlayEntries.length != 0 ) {
      overlayEntries.last.completer?.complete(data);
      overlayEntries.removeLast().overlayEntry!.remove();
    }
}

// 全局模态窗口类
class GlobalModal {
  static OverlayEntry? _currentEntry;

  // 显示全局模态窗口
  static void show({
    required BuildContext context, // 窗口上下文
    required Widget child, // 窗口内容
    Size? size, // 窗口尺寸
    Offset? position, // 窗口左上角坐标
    Color barrierColor = Colors.black54, // 背景色
    bool barrierDismissible = true, // 点击背景是否关闭
    bool draggable = false, // 是否允许拖拽
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeOutBack,
  }) {
    // 如果已有窗口显示，先关闭
    if (_currentEntry != null) {
      _currentEntry?.remove();
      _currentEntry = null;
    }

    final overlayState = Overlay.of(context);
    final mediaQuery = MediaQuery.of(context);
    
    // 默认尺寸为屏幕的80%
    final modalSize = size ?? Size(
      mediaQuery.size.width * 0.8,
      mediaQuery.size.height * 0.8,
    );
    
    // 默认居中显示
    final modalPosition = position ?? Offset(
      (mediaQuery.size.width - modalSize.width) / 2,
      (mediaQuery.size.height - modalSize.height) / 2,
    );

    Offset currentPosition = modalPosition; // 模态窗口的当前坐标

    _currentEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 半透明背景层（遮罩层）
            Positioned.fill(
              child: GestureDetector(
                onTap: barrierDismissible ? () => dismiss() : null, // 控制点击遮罩层是否销毁该模态窗口
                child: Container(color: barrierColor), // 背景色
              ),
            ),

            // 模态窗口内容
            Positioned(
                  left: currentPosition.dx,
                  top: currentPosition.dy,
                  child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: modalSize.width, // 尺寸
                    height: modalSize.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // 拖拽手柄区域
                        if (draggable)
                          GestureDetector(
                            onPanUpdate: (details) {
                              currentPosition += details.delta;
                              _currentEntry?.markNeedsBuild();
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.drag_handle,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        
                        // 关闭按钮
                        const Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: dismiss,
                          ),
                        ),
                        
                        // 内容区域
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: child, // 内容窗口
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               ),
          // //   ),
           ],
        );
      },
    );

    overlayState.insert(_currentEntry!);
  }

  /// 关闭当前模态窗口
  static void dismiss() {
    if (_currentEntry != null) {
      _currentEntry?.remove();
      _currentEntry = null;
    }
  }
}
