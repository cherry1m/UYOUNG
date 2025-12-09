import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/src/view/pages/memory/widgets/memory_post_item.dart';

class AllMemoryPage extends StatelessWidget {
  final String title;
  final String memoryId;

  const AllMemoryPage({super.key, required this.title, required this.memoryId});

  @override
  Widget build(BuildContext context) {
    final List<MemoryPostModel> posts =
        MemoryPostDummy.postsByMemoryId[memoryId] ?? [];

    return Scaffold(backgroundColor: Colors.white, body: _buildBody(posts));
  }

  // MARK: 바디 UI 구성
  Widget _buildBody(List<MemoryPostModel> posts) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _buildDateLabel()),
          const SizedBox(height: 18),

          // MARK: 게시물 리스트 영역
          ListView.builder(
            itemCount: posts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => MemoryPostItem(post: posts[i]),
          ),
        ],
      ),
    );
  }

  // MARK: 날짜 라벨 UI
  Widget _buildDateLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6EA8EB), width: 1),
      ),
      child: Text(
        "2025년 8월 14일 화요일",
        style: AppFontStyle.M_14.copyWith(color: const Color(0xFF6EA8EB)),
      ),
    );
  }
}
