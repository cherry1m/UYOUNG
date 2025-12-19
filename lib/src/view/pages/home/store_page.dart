import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 배경
          Positioned.fill(
            child: Image.asset(
              "assets/images/store_page.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
