import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MARK: 날짜 텍스트
            Text("2025년 8월 14일 화요일", style: AppFontStyle.M_14),

            const SizedBox(height: 12),

            // MARK: - 3열 Grid
            GridView.builder(
              itemCount: 9, // 총 30칸
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 한 줄에 3개
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, i) {
                if (i == 0) return _photoItem("assets/images/sample8.png");
                if (i == 1) return _photoItem("assets/images/sample9.png");
                if (i == 2) return _photoItem("assets/images/sample10.png");
                return _emptyBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  // MARK: 실제 이미지 박스
  Widget _photoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  // MARK: 빈 회색 박스
  Widget _emptyBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
