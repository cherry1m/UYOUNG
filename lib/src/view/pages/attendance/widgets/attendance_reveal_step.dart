import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_primary_button.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_stage_layout.dart';

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
    final objectTop = top + size.height * 0.2;

    return AttendanceStageLayout(
      top: objectTop,
      safeBottom: safeBottom,
      backgroundAssetPath: ImagePath.attendanceItemBg,
      textTopSpacing: 230,
      object: Center(
        child: GestureDetector(
          onTap: onClamTap,
          child: Image.asset(
            ImagePath.attendanceItemClam,
            width: 230,
            height: 230,
            fit: BoxFit.contain,
          ),
        ),
      ),
      text: Column(
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
      action: AttendancePrimaryButton(
        text: '아이템 확인해보기',
        onTap: onClamTap,
      ),
    );
  }
}
