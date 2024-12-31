import 'package:flutter/material.dart';

// Tab模型
class DemoTabViewModel {
  final String title;
  final Widget widget;

  const DemoTabViewModel({
    required this.title,
    required this.widget,
  });
}

// 通用TabBarView界面实现：可以通过导入List<DemoTabViewModel>创建响应的TabBarView界面
class DemoTabs extends StatelessWidget {
  final String title;
  final List<DemoTabViewModel> demos;
  final bool tabScrollable;
  final TabController tabController;

  const DemoTabs({super.key, 
    required this.title,
    required this.demos,
    required this.tabScrollable,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: tabController,
          isScrollable: tabScrollable,
          tabs: demos.map((item) => Tab(text: item.title)).toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: demos.map((item) => item.widget).toList(),
      ),
    );
  }
}