import 'package:flutter/material.dart';
import 'basic_widgets/BasicWidgetsDemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), 
      debugShowCheckedModeBanner: false,
      home: const BasicWidgetsDemo(),
    );
  }
}
