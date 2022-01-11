import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_task_pincode_screen/auth_screen.dart';
import 'package:test_task_pincode_screen/setup_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Screen"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                    "Enter PIN"
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                }),
              SizedBox(width: 48),
              ElevatedButton(
                child: Text(
                    "Setup PIN"
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetupScreen()),
                  );
                })
            ],
          ),
        ],
      ),
    );
  }
}