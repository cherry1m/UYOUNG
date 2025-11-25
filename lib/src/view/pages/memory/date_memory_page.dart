import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';
import 'package:uyoung/src/view/pages/memory/photo_detail_page.dart'; // 추가

class DateMemoryPage extends StatelessWidget {
  final MemoryItem item;

  const DateMemoryPage({super.key, required this.item, required String title});

  @override
  Widget build(BuildContext context) {
    // 더미 이미지 리스트
    final List<String> photoList = [
      "assets/images/sample8.png",
      "assets/images/sample9.png",
      "assets/images/sample10.png",
    ];

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
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, index) {
                // 사진 존재하는 경우 → 클릭 가능
                if (index < photoList.length) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PhotoDetailPage(imagePath: photoList[index]),
                        ),
                      );
                    },
                    child: _photoItem(photoList[index]),
                  );
                }

                // 빈 박스
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
