import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';

class MemoryIslandDetailPage extends StatelessWidget {
  final MemoryIsland island;
  final DateTime date;

  const MemoryIslandDetailPage({
    super.key,
    required this.island,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // 이 섬에서 이 날짜에 해당하는 모든 사진 경로
    final thumbPaths = island.photoThumbnails.entries
        .where((entry) => entry.key.isSameDay(date))
        .map((e) => e.value)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 상단 영역 (뒤로가기, 이름, 날짜, 선택 버튼)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              child: Row(
                children: [
                  // 뒤로가기
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  // 가운데: 섬 이름 + 날짜
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          island.name,
                          style: AppFontStyle.H6,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.year}년 ${date.month}월 ${date.day}일',
                          style: AppFontStyle.S9.copyWith(
                            color: AppColors.gray_12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // 우측: 사진 선택 버튼 (동작은 아직 미정 → TODO)
                  IconButton(
                    onPressed: () {
                      // TODO: 선택 모드 기능 연결
                    },
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    icon: Image.asset(
                      ImagePath.checkBlack,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 썸네일 그리드 영역
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  itemCount: thumbPaths.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    final path = thumbPaths[index];
                    return SizedBox(
                      width: 114,
                      height: 114,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(path, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
