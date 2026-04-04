import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendanceBoardHeader extends StatelessWidget {
  const AttendanceBoardHeader({
    super.key,
    required this.decorationImagePath,
  });

  final String decorationImagePath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 68,
      left: 0,
      right: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘도 출석완료!\n아이템 확인해주세요',
                    style: AppFontStyle.F3.copyWith(
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '연속 출석체크 스타트!',
                    style: AppFontStyle.H6.copyWith(
                      color: const Color(0xFF7E7E7E),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Image.asset(
              decorationImagePath,
              width: 124,
              height: 124,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
