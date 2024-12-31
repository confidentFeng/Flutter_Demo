import 'package:flutter/material.dart';
import 'pet_card.dart';
import 'credit_card.dart';
import 'friend_circle.dart';
import 'mock_data.dart';
import '../common/demo_tabs.dart';

// 创建Tab模型对象列表
List<DemoTabViewModel> demoList = [
  const DemoTabViewModel(title: '银行卡', widget: CreditCard(data: creditCardData)),  
  const DemoTabViewModel(title: '宠物卡片', widget: PetCard(data: petCardData)),
  const DemoTabViewModel(title: '微信朋友圈', widget: FriendCircle(data: friendCircleData)),
].map((item) => DemoTabViewModel(
  title: item.title,
  widget: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[item.widget],
  ),
)).toList();

class BasicWidgetsDemo extends StatefulWidget {
  const BasicWidgetsDemo({super.key});

  @override
  State<BasicWidgetsDemo> createState() => _BasicWidgetsDemoState();
}

class _BasicWidgetsDemoState extends State<BasicWidgetsDemo>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: demoList.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoTabs(
      title: '基础组件',
      demos: demoList,
      tabScrollable: false,
      tabController: tabController,
    );
  }
}
