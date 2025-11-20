import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class MemoryDatailPage extends StatelessWidget {
  const MemoryDatailPage({super.key, required MemoryItem item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("우.정.포.에.버", style: AppFontStyle.M_20),
      ),
    );
  }
}
