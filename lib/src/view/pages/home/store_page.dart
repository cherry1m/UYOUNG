import 'package:flutter/material.dart';
import 'package:uyoung/data/image_data.dart';

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
              ImagePath.storePage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
