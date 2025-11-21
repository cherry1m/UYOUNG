import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class TimelineMemoryPage extends StatelessWidget {
  final MemoryItem item;

  const TimelineMemoryPage({
    super.key,
    required this.item,
    required String title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: item.title),
      body: const Center(child: Text("타임라인 페이지")),
    );
  }
}
