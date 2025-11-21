import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class DateMemoryPage extends StatelessWidget {
  final MemoryItem item;

  const DateMemoryPage({super.key, required this.item, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: item.title),
      body: const Center(child: Text("일자별 페이지")),
    );
  }
}
