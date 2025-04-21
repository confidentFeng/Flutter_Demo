import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'EventBus.dart';
import 'EnumType.dart';

// *************************************** Get总线数据管理 **********************************
class GetDataManangerController extends GetxController
{
  GetDataManangerController()
  {
    eventBus.on<BusDataObject>().listen((BusDataObject event)  async
    {
      if ( BusDataType.DataType_MsgSend == event.dataType )
      {
        // 内存异常处理
        if ( event.dataList == null ) {
          return;
        }
        int curIndex = event.dataList![0];    
        debugPrint("Main Recv curMessageIndex: $curIndex");
      }
    });
  }
}
