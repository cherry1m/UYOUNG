import 'package:flutter/material.dart';

class AttendDay2Page extends StatelessWidget {
  const AttendDay2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/home_check.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
