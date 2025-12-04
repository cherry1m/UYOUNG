import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  /// 해당 날짜에 기억섬 사진이 있으면 색 원 표시
  final Color? dotColor;

  /// 해당 날짜에 표시할 썸네일 이미지 경로 (사진 있는 날)
  /// null이면 기본 calendar 아이콘 표시
  final String? thumbnailPath;

  /// 바텀시트가 열려 있을 때 사용하는 “간소화 모드”
  final bool isCompactMode;

  const CalendarDayCell({
    Key? key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
    this.dotColor,
    this.thumbnailPath,
    this.isCompactMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseTextColor = isOutside
        ? Colors.grey.shade400
        : const Color(0xFF444444);

    final backgroundColor = isSelected
        ? AppColors.mainBlue
        : Colors.transparent;

    final dayTextColor = isSelected ? Colors.white : baseTextColor;

    // 간소화 모드: 날짜 + dot만, 빈공간 없음
    if (isCompactMode) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${date.day}',
                style: AppFontStyle.M_16.copyWith(color: dayTextColor),
              ),
            ),
            const SizedBox(height: 8),
            if (dotColor != null)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 6),
          ],
        ),
      );
    }

    // 기본 모드: 아이콘/썸네일 + dot까지 다 보여줌
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          // 날짜 텍스트
          Container(
            width: 36,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${date.day}',
              style: AppFontStyle.M_16.copyWith(color: dayTextColor),
            ),
          ),

          // 썸네일 or 기본 아이콘
          Container(
            width: 42,
            height: 42,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  thumbnailPath ?? 'assets/images/calendar_icon.png',
                ),
              ),
            ),
          ),

          const SizedBox(height: 2),

          if (dotColor != null)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(height: 6),
        ],
      ),
    );
  }
}
