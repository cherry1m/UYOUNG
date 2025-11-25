import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class SelectMemberPage extends StatelessWidget {
  const SelectMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar: _appBar());
  }

  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text("대화 상대", style: AppFontStyle.M_20),
  );
}
