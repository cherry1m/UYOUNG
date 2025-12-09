import 'package:flutter/material.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _fullBackground());
  }

  // MARK: - 홈 메인 배경 이미지
  Widget _fullBackground() => Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/images/home_main.png',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,

      alignment: const Alignment(0, -0.7),
    ),
  );
}
