import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  const CalendarDayCell({
    Key? key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
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

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 날짜
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

          const SizedBox(height: 5),

          // 아이콘
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/calendar_icon.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
