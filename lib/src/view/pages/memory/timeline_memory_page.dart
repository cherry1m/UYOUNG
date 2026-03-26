import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';
import 'package:uyoung/data/sources/memory/memory_location_dummy.dart';
import 'package:uyoung/src/view/common/memory/common_memory_appbar.dart';

class TimelineMemoryPage extends StatefulWidget {
  final MemoryItem item;

  const TimelineMemoryPage({
    super.key,
    required this.item,
    required String title, // (지금 너 코드에 남아있어서 유지)
  });

  @override
  State<TimelineMemoryPage> createState() => _TimelineMemoryPageState();
}

class _TimelineMemoryPageState extends State<TimelineMemoryPage> {
  String? _selectedDate; // ex) "12월 7일"

  @override
  Widget build(BuildContext context) {
    final List<MemoryPostModel> posts =
        MemoryPostDummy.postsByMemoryId[widget.item.id] ?? [];

    // ✅ 드롭다운에 들어갈 날짜 목록 (createdAt)
    final dates =
        posts
            .map((p) => p.createdAt.toString().trim())
            .where((s) => s.isNotEmpty)
            .toSet()
            .toList()
          ..sort((a, b) => _dateSortKey(b).compareTo(_dateSortKey(a))); // 최신 우선

    // ✅ 최초 1회 기본 선택값 세팅
    _selectedDate ??= dates.isNotEmpty ? dates.first : null;

    // ✅ 선택 날짜의 post만 필터링
    final filteredPosts = posts
        .where((p) => p.createdAt.toString().trim() == (_selectedDate ?? ""))
        .toList();

    // ✅ (고유키 기준) 사진 리스트 만들기
    final List<_PhotoKeyed> photos = _flattenWithKey(
      memoryId: widget.item.id,
      posts: filteredPosts,
    );

    // ✅ 위치별 그룹핑 (LocationDummy 없으면 "위치 미지정")
    final groupedByLocation = _groupByLocation(photos);

    // ✅ 위치 섹션 순서: label 기준 정렬 (원하면 커스텀 가능)
    final locationKeys = groupedByLocation.keys.toList()..sort();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MemoryCommonAppBar(
        title: widget.item.title,
        islandId: widget.item.id,
      ),
      body: Column(
        children: [
          // ✅ MAP 자리 -> 이미지로 대체
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.asset('assets/images/map.png', fit: BoxFit.cover),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),

                  // ✅ 날짜 드롭다운
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: _dateDropdown(dates),
                  ),

                  const SizedBox(height: 14),

                  if (_selectedDate == null || dates.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text("선택할 날짜가 없어요.", style: AppFontStyle.M_14),
                    )
                  else if (photos.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "이 날짜에는 저장된 사진이 없어요.",
                        style: AppFontStyle.M_14,
                      ),
                    )
                  else ...[
                    // ✅ 위치 섹션들
                    for (final loc in locationKeys) ...[
                      const SizedBox(height: 10),
                      _locationLabel(loc),
                      const SizedBox(height: 10),

                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupedByLocation[loc]!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (_, i) {
                          final p = groupedByLocation[loc]![i];
                          return _photoItem(p.imagePath);
                        },
                      ),

                      const SizedBox(height: 18),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // UI
  // ---------------------------

  Widget _dateDropdown(List<String> dates) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDate,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: dates
              .map(
                (d) => DropdownMenuItem(
                  value: d,
                  child: Text(d, style: AppFontStyle.M_14),
                ),
              )
              .toList(),
          onChanged: (v) {
            setState(() => _selectedDate = v);
          },
        ),
      ),
    );
  }

  Widget _locationLabel(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          const CircleAvatar(radius: 4, backgroundColor: Color(0xFFAFAFAF)),
          const SizedBox(width: 6),
          Text(title, style: AppFontStyle.M_14),
        ],
      ),
    );
  }

  Widget _photoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  // ---------------------------
  // DATA
  // ---------------------------

  // createdAt 정렬용: "12월 7일" -> 1207
  int _dateSortKey(String s) {
    final nums = RegExp(r'\d+').allMatches(s).map((m) => m.group(0)!).toList();
    if (nums.length >= 2) {
      final m = int.tryParse(nums[0]) ?? 0;
      final d = int.tryParse(nums[1]) ?? 0;
      return m * 100 + d;
    }
    return 0;
  }

  List<_PhotoKeyed> _flattenWithKey({
    required String memoryId,
    required List<MemoryPostModel> posts,
  }) {
    final List<_PhotoKeyed> out = [];
    for (final post in posts) {
      final date = post.createdAt.toString().trim();
      for (final img in post.images) {
        final key = "${memoryId}_${date}_$img"; // ✅ 고유키(중복 방지용)
        out.add(_PhotoKeyed(key: key, imagePath: img));
      }
    }
    return out;
  }

  Map<String, List<_PhotoKeyed>> _groupByLocation(List<_PhotoKeyed> photos) {
    final map = <String, List<_PhotoKeyed>>{};

    for (final p in photos) {
      // ✅ LocationDummy의 key는 "이미지 경로"라고 가정
      final info = MemoryLocationDummy.get(p.imagePath);

      // label 우선, 없으면 groupKey, 그것도 없으면 "위치 미지정"
      final label = info?.label ?? info?.groupKey ?? "위치 미지정";

      (map[label] ??= []).add(p);
    }
    return map;
  }
}

class _PhotoKeyed {
  final String key; // memoryId_createdAt_imagePath (중복 방지/식별용)
  final String imagePath; // asset path (LocationDummy lookup key)
  const _PhotoKeyed({required this.key, required this.imagePath});
}
