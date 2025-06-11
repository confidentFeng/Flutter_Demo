import 'package:event_bus/event_bus.dart';
import 'EnumType.dart';

// 全局事件总线
EventBus eventBus = EventBus();

// 总线数据对象
class BusDataObject
{
  BusDataType dataType;             // 数据类型
  List<dynamic>? dataList;          // 详细数据
  BusDataObject({this.dataList, required this.dataType});
}

// 向总线发布数据
void eventBusFire(BusDataType type, List<dynamic>? dataList)
{
  BusDataObject sendData = BusDataObject(
    dataType: type,
    dataList: dataList
  );
  eventBus.fire(sendData);
}
