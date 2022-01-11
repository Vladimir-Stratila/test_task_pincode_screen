import 'package:flutter/material.dart';
import 'package:test_task_pincode_screen/auth_screen.dart';
import 'package:test_task_pincode_screen/menu_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Code Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity // ?
      ),
      home: MenuScreen(),
    );
  }
}