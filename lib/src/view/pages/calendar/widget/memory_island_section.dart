import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';

class MemoryIslandSection extends StatelessWidget {
  final MemoryIsland island;
  final DateTime date;

  const MemoryIslandSection({
    super.key,
    required this.island,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // 이 섬에서, 이 날짜에 해당하는 썸네일들만 모으기
    final thumbPaths = island.photoThumbnails.entries
        .where((entry) => entry.key.isSameDay(date))
        .map((e) => e.value)
        .toList();

    if (thumbPaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 섬 색상 + 이름 (가운데 정렬)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: island.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(island.name, style: AppFontStyle.H6),
            ],
          ),

          const SizedBox(height: 12),

          // 🔹 사진 2장 + +N 박스
          _MemoryPhotoRow(thumbPaths: thumbPaths),
        ],
      ),
    );
  }
}

/// 가로로 1 ~ 2장 + +N 박스를 보여주는 Row
class _MemoryPhotoRow extends StatelessWidget {
  final List<String> thumbPaths;

  const _MemoryPhotoRow({required this.thumbPaths});

  @override
  Widget build(BuildContext context) {
    final firstThumb = thumbPaths[0];
    final String? secondThumb = thumbPaths.length > 1 ? thumbPaths[1] : null;
    final int remainingCount = thumbPaths.length > 2
        ? thumbPaths.length - 2
        : 0;

    return SizedBox(
      height: 142.4,
      child: Row(
        children: [
          _PhotoCard(imagePath: firstThumb, angleDegrees: -3.98),
          const SizedBox(width: 5),

          if (secondThumb != null) ...[
            _PhotoCard(imagePath: secondThumb, angleDegrees: 2.98),
            const SizedBox(width: 5),
          ],

          if (remainingCount > 0)
            _MoreCountCard(count: remainingCount, angleDegrees: -2.99),
        ],
      ),
    );
  }
}

/// 실제 사진 카드
class _PhotoCard extends StatelessWidget {
  final String imagePath;
  final double angleDegrees;

  const _PhotoCard({required this.imagePath, required this.angleDegrees});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleDegrees * 3.141592 / 180,
      child: Container(
        width: 106.8,
        height: 142.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: Color(0x2E000000), // #0000002E
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// +N 박스 카드
class _MoreCountCard extends StatelessWidget {
  final int count;
  final double angleDegrees;

  const _MoreCountCard({required this.count, required this.angleDegrees});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleDegrees * 3.141592 / 180,
      child: Container(
        width: 106.7,
        height: 142.4,
        decoration: BoxDecoration(
          color: const Color(0x80414141), // #41414180
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: Color(0x2E000000), // #0000002E
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '+$count',
          style: AppFontStyle.M_20.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
