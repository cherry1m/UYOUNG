import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';
import 'package:uyoung/src/view/pages/memory/photo_detail_page.dart';

class DateMemoryPage extends StatelessWidget {
  final MemoryItem item;

  const DateMemoryPage({super.key, required this.item, required String title});

  @override
  Widget build(BuildContext context) {
    // MARK: - 해당 기억섬의 전체 게시물 리스트
    final posts = MemoryPostDummy.postsByMemoryId[item.id] ?? [];

    // MARK: - 이미지 + 업로더 정보까지 평탄화
    final List<Map<String, String>> flatPhotos = posts
        .expand(
          (post) => post.images.map(
            (img) => {
              "image": img,
              "name": post.name,
              "profile": post.profileImage,
            },
          ),
        )
        .toList();

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
              itemCount: flatPhotos.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, index) {
                final imagePath = flatPhotos[index]["image"]!;
                final uploaderName = flatPhotos[index]["name"]!;
                final uploaderProfile = flatPhotos[index]["profile"]!;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhotoDetailPage(
                          imagePath: imagePath,
                          uploaderName: uploaderName,
                          uploaderProfile: uploaderProfile,
                        ),
                      ),
                    );
                  },
                  child: _photoItem(imagePath),
                );
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
}
