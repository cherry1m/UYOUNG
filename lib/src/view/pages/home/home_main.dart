import 'package:flutter/material.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _textBox());
  }

  Widget _textBox() => Container(
    alignment: Alignment.center,
    child: const Text(
      '최근 우리가 제일',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
