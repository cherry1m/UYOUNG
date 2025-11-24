import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/src/view/pages/memory/widgets/memory_post_item.dart';

class AllMemoryPage extends StatelessWidget {
  final String title;

  const AllMemoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // MARK: - 더미 게시물 리스트
    final List<MemoryPostModel> dummyPosts = List.generate(
      10,
      (i) => MemoryPostModel(
        name: i % 2 == 0 ? "윤채림" : "조성은",
        profileImage: i % 2 == 0
            ? "assets/images/profile1.png"
            : "assets/images/profile2.png",
        createdAt: "${i + 1}분 전",

        // MARK: - 홀/짝 이미지 변경
        images: i % 2 == 0
            ? [
                "assets/images/sample1.png",
                "assets/images/sample2.png",
                "assets/images/sample3.png",
              ]
            : [
                "assets/images/sample4.png",
                "assets/images/sample7.png",
                "assets/images/sample6.png",
                "assets/images/sample5.png",
              ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _date()),
            const SizedBox(height: 18),

            // MARK: - 게시물 리스트
            ListView.builder(
              itemCount: dummyPosts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) => MemoryPostItem(post: dummyPosts[i]),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - 날짜 라벨 UI
  Widget _date() {
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
