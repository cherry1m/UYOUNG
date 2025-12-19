import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/data/model/common/memory_island_list.dart';
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

    final orderedDates = _getOrderedDatesFromIsland(memoryId);
    final grouped = _groupPostsByMonthDay(posts);

    final fallbackDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    final datesToRender = orderedDates.isNotEmpty
        ? orderedDates
        : fallbackDates.map((d) => MemoryDate(d.month, d.day)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _buildBody(datesToRender, grouped)),
    );
  }

  Widget _buildBody(
    List<MemoryDate> datesToRender,
    Map<DateTime, List<MemoryPostModel>> grouped,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      itemCount: datesToRender.length,
      itemBuilder: (context, index) {
        final md = datesToRender[index];

        final matchedKey = grouped.keys.cast<DateTime?>().firstWhere(
          (k) => k != null && k.month == md.month && k.day == md.day,
          orElse: () => null,
        );

        final dayPosts = matchedKey == null
            ? <MemoryPostModel>[]
            : grouped[matchedKey]!;

        final dateForLabel = matchedKey ?? DateTime(2025, md.month, md.day);

        return Column(
          children: [
            Center(child: _buildDateLabel(dateForLabel)),
            const SizedBox(height: 14),
            if (dayPosts.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  '이 날짜에는 저장된 사진이 없어요.',
                  style: AppFontStyle.M_14.copyWith(
                    color: const Color(0xFF999999),
                  ),
                ),
              )
            else
              ListView.builder(
                itemCount: dayPosts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) => MemoryPostItem(post: dayPosts[i]),
              ),
            const SizedBox(height: 22),
          ],
        );
      },
    );
  }

  Widget _buildDateLabel(DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6EA8EB), width: 1),
      ),
      child: Text(
        _formatKoreanDate(date),
        style: AppFontStyle.M_14.copyWith(color: const Color(0xFF6EA8EB)),
      ),
    );
  }

  DateTime _toDateTime(dynamic createdAt) {
    if (createdAt is DateTime) return createdAt;

    if (createdAt is String) {
      final s = createdAt.trim();

      // 1) ISO/일반 포맷 먼저 시도
      final normalized = s.replaceAll('.', '-').replaceAll('/', '-');
      final parsed1 = DateTime.tryParse(normalized);
      if (parsed1 != null) return parsed1;

      // 2) 숫자만 뽑아서 (년/월/일) 추출
      final nums = RegExp(
        r'\d+',
      ).allMatches(s).map((m) => m.group(0)!).toList();

      // 예: [2025, 12, 7] or [12, 7]
      if (nums.length >= 3) {
        final y = int.parse(nums[0]);
        final m = int.parse(nums[1]);
        final d = int.parse(nums[2]);
        return DateTime(y, m, d);
      }

      // 예: [12, 7] 처럼 년도가 없으면 2025로 가정(원하면 현재연도로 바꿔도 됨)
      if (nums.length == 2) {
        final m = int.parse(nums[0]);
        final d = int.parse(nums[1]);
        return DateTime(2025, m, d);
      }
    }

    // 파싱 실패 시: 눈에 띄게 튀는 값으로(디버깅용)
    return DateTime(1999, 1, 1);
  }

  Map<DateTime, List<MemoryPostModel>> _groupPostsByMonthDay(
    List<MemoryPostModel> posts,
  ) {
    final map = <DateTime, List<MemoryPostModel>>{};

    for (final p in posts) {
      final created = _toDateTime(p.createdAt);
      final key = DateTime(created.year, created.month, created.day);

      map.putIfAbsent(key, () => []);
      map[key]!.add(p);
    }

    // 각 날짜 안에서 최신순 정렬(원하면 제거 가능)
    for (final e in map.entries) {
      e.value.sort((a, b) {
        final da = _toDateTime(a.createdAt);
        final db = _toDateTime(b.createdAt);
        return db.compareTo(da);
      });
    }

    return map;
  }

  List<MemoryDate> _getOrderedDatesFromIsland(String memoryId) {
    final idx = int.tryParse(memoryId);
    if (idx == null) return [];

    final islandIndex = idx - 1;
    if (islandIndex < 0 || islandIndex >= defaultMemoryIslands.length) {
      return [];
    }

    final island = defaultMemoryIslands[islandIndex];

    final seen = <String>{};
    final result = <MemoryDate>[];

    for (final d in island.photoDates) {
      final key = '${d.month}-${d.day}';
      if (seen.add(key)) result.add(MemoryDate(d.month, d.day));
    }

    result.sort((a, b) {
      if (a.month != b.month) return b.month.compareTo(a.month);
      return b.day.compareTo(a.day);
    });

    return result;
  }

  String _formatKoreanDate(DateTime d) {
    const w = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = w[d.weekday - 1];
    return '${d.year}년 ${d.month}월 ${d.day}일 ${weekday}요일';
  }
}
