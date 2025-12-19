import 'package:flutter/material.dart';

class AttendDay1Page extends StatelessWidget {
  const AttendDay1Page({super.key});

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
