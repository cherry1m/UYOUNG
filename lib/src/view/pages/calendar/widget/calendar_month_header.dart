import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class CalendarMonthHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback? onTapArrow; // 🔥 추가

  const CalendarMonthHeader({Key? key, required this.month, this.onTapArrow})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = '${month.year}년 ${month.month}월';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(text, style: AppFontStyle.M_20),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onTapArrow, // 🔥 여기에서 콜백 실행
            child: const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ],
      ),
    );
  }
}
