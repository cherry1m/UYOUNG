import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  /// 해당 날짜에 기억섬 색 원들 (여러 개 가능)
  final List<Color> dotColors;

  /// 해당 날짜에 표시할 썸네일 이미지 경로 (사진 있는 날)
  /// null이면 기본 calendar 아이콘 표시
  final String? thumbnailPath;

  /// 바텀시트가 열려 있을 때 사용하는 “간소화 모드”
  final bool isCompactMode;

  /// ✅ 5주/6주 정보 (간소화 모드 spacing 조절용)
  final int compactWeeks;

  const CalendarDayCell({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
    this.dotColors = const [],
    this.thumbnailPath,
    this.isCompactMode = false,
    this.compactWeeks = 6, // ✅ 기본값은 여기서
  });

  @override
  Widget build(BuildContext context) {
    final baseTextColor = isOutside
        ? Colors.grey.shade400
        : const Color(0xFF444444);

    final backgroundColor = isSelected
        ? AppColors.mainBlue
        : Colors.transparent;
    final dayTextColor = isSelected ? Colors.white : baseTextColor;

    // 공용: dot 영역 위젯
    Widget _buildDotRow() {
      if (dotColors.isEmpty) {
        return const SizedBox(height: 6);
      }

      if (dotColors.length <= 4) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final color in dotColors)
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
          ],
        );
      }

      final visibleDots = dotColors.take(2).toList();
      final remainingCount = dotColors.length - 2;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final color in visibleDots)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          const SizedBox(width: 4),
          Text(
            '+$remainingCount',
            style: TextStyle(fontSize: 10, color: AppColors.gray_12),
          ),
        ],
      );
    }

    // ✅ 간소화 모드 5주/6주에 따라 내부 spacing도 같이 줄이기
    final bool isSixWeeks = compactWeeks >= 6;
    final double compactDateBoxHeight = isSixWeeks ? 22 : 24;
    final double compactGap = isSixWeeks ? 6 : 8;
    final double compactBottomPadding = isSixWeeks ? 4 : 6;

    // 간소화 모드: 날짜 + dot만
    if (isCompactMode) {
      return Padding(
        padding: EdgeInsets.only(bottom: compactBottomPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: compactDateBoxHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${date.day}',
                style: AppFontStyle.M_16.copyWith(
                  color: dayTextColor,
                  height: 0.0,
                ),
              ),
            ),
            SizedBox(height: compactGap),
            _buildDotRow(),
          ],
        ),
      );
    }

    // 기본 모드: 날짜 + 썸네일/아이콘 + dot
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${date.day}',
              style: AppFontStyle.M_16.copyWith(
                color: dayTextColor,
                height: 0.0,
              ),
            ),
          ),
          const SizedBox(height: 5),

          SizedBox(
            width: 42,
            height: 42,
            child: Stack(
              children: [
                if (thumbnailPath != null)
                  Transform.rotate(
                    angle: 12 * 3.141592 / 180,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(thumbnailPath!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.15),
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                    ),
                  ),

                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: thumbnailPath != null
                        ? Border.all(color: const Color(0xFFE5E5E5), width: 0.8)
                        : null,
                    image: DecorationImage(
                      image: AssetImage(
                        thumbnailPath ?? 'assets/images/calendar_icon.png',
                      ),
                      fit: thumbnailPath != null
                          ? BoxFit.cover
                          : BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),
          _buildDotRow(),
        ],
      ),
    );
  }
}
