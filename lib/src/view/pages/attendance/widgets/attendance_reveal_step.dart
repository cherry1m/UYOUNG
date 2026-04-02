import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_primary_button.dart';

class AttendanceRevealStep extends StatelessWidget {
  const AttendanceRevealStep({
    super.key,
    required this.onClamTap,
    required this.top,
    required this.safeBottom,
  });

  final VoidCallback onClamTap;
  final double top;
  final double safeBottom;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    // Clam object vertical anchor on the reveal screen.
    final clamTop = top + size.height * 0.035;
    // Text block under the clam on the reveal screen.
    final textTop = clamTop + 210;

    return Stack(
      children: [
        Positioned(
          // Clam object position.
          left: 0,
          right: 0,
          top: clamTop,
          child: Center(
            child: GestureDetector(
              onTap: onClamTap,
              child: Image.asset(
                ImagePath.attendanceItemClam,
                width: 214,
                height: 214,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          // Reveal text position.
          left: 0,
          right: 0,
          top: textTop,
          child: Column(
            children: [
              Text(
                '어! 심해에서',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '해달이 무언갈 주웠나봐요,',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          // Bottom CTA button on the reveal screen.
          left: 16,
          right: 16,
          bottom: safeBottom + 2,
          child: AttendancePrimaryButton(
            text: '아이템 확인해보기',
            onTap: onClamTap,
          ),
        ),
      ],
    );
  }
}
