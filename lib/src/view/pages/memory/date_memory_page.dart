import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';
import 'package:uyoung/src/view/pages/memory/photo_detail_page.dart';

class DateMemoryPage extends StatelessWidget {
  final MemoryItem item;

  const DateMemoryPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final posts = MemoryPostDummy.postsByMemoryId[item.id] ?? [];

    // ✅ 날짜별로 그룹핑: (yyyy-mm-dd) -> 해당 날짜의 사진들
    final grouped = _groupPhotosByDay(posts);

    // ✅ 최신 날짜가 위로 오게
    final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(title: item.title, islandId: item.id),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final photos = grouped[date] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ 날짜 텍스트 (원하는 스타일)
              Text(_formatKoreanDate(date), style: AppFontStyle.M_14),
              const SizedBox(height: 12),

              GridView.builder(
                itemCount: photos.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, i) {
                  final p = photos[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhotoDetailPage(
                            imagePath: p.imagePath,
                            uploaderName: p.uploaderName,
                            uploaderProfile: p.uploaderProfile,
                          ),
                        ),
                      );
                    },
                    child: _photoItem(p.imagePath),
                  );
                },
              ),

              const SizedBox(height: 22),
            ],
          );
        },
      ),
    );
  }

  // ✅ 실제 이미지 박스
  Widget _photoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  // =========================
  // 그룹핑 로직
  // =========================

  Map<DateTime, List<_FlatPhoto>> _groupPhotosByDay(
    List<MemoryPostModel> posts,
  ) {
    final map = <DateTime, List<_FlatPhoto>>{};

    for (final post in posts) {
      final dt = _toDateTime(post.createdAt);
      final dayKey = DateTime(dt.year, dt.month, dt.day);

      final list = map.putIfAbsent(dayKey, () => []);
      for (final img in post.images) {
        list.add(
          _FlatPhoto(
            imagePath: img,
            uploaderName: post.name,
            uploaderProfile: post.profileImage,
          ),
        );
      }
    }

    return map;
  }

  DateTime _toDateTime(dynamic createdAt) {
    if (createdAt is DateTime) return createdAt;

    if (createdAt is String) {
      final s = createdAt.trim();
      final normalized = s.replaceAll('.', '-').replaceAll('/', '-');
      final parsed1 = DateTime.tryParse(normalized);
      if (parsed1 != null) return parsed1;

      final nums = RegExp(
        r'\d+',
      ).allMatches(s).map((m) => m.group(0)!).toList();

      if (nums.length >= 3) {
        return DateTime(
          int.parse(nums[0]),
          int.parse(nums[1]),
          int.parse(nums[2]),
        );
      }
      if (nums.length == 2) {
        return DateTime(2025, int.parse(nums[0]), int.parse(nums[1]));
      }
    }

    return DateTime(1999, 1, 1);
  }

  String _formatKoreanDate(DateTime d) {
    const w = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = w[d.weekday - 1];
    return '${d.year}년 ${d.month}월 ${d.day}일 $weekday요일';
  }
}

// ✅ 날짜별 grid에 들어갈 1칸 데이터
class _FlatPhoto {
  final String imagePath;
  final String uploaderName;
  final String uploaderProfile;

  const _FlatPhoto({
    required this.imagePath,
    required this.uploaderName,
    required this.uploaderProfile,
  });
}
