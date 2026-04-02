import 'package:flutter/material.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_day_row.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_story_card.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceEntryStep extends StatelessWidget {
  const AttendanceEntryStep({
    super.key,
    required this.onCheckTap,
    required this.top,
    required this.safeBottom,
    required this.horizontalPadding,
    required this.boxSpacing,
    required this.boxWidth,
    required this.boxHeight,
    required this.iconSize,
    required this.viewModel,
  });

  final VoidCallback onCheckTap;
  final double top;
  final double safeBottom;
  final double horizontalPadding;
  final double boxSpacing;
  final double boxWidth;
  final double boxHeight;
  final double iconSize;
  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // Attendance day boxes row.
          top: top,
          left: 0,
          right: 0,
          child: AttendanceDayRow(
            horizontalPadding: horizontalPadding,
            boxSpacing: boxSpacing,
            boxWidth: boxWidth,
            boxHeight: boxHeight,
            iconSize: iconSize,
            viewModel: viewModel,
            onCheckTap: onCheckTap,
          ),
        ),
        Positioned(
          // Main otter illustration on the entry screen.
          left: 0,
          right: 0,
          top: top + boxHeight + 34,
          child: Center(
            child: Image.asset(
              ImagePath.attendanceOtterDive,
              width: 316,
              fit: BoxFit.contain,
            ),
          ),
        ),
        AttendanceStoryCard(
          title: '해달이 무언가를 밑에서 가져오려해요',
          body: '오늘은 어떤 걸 주워올까요?',
          safeBottom: safeBottom,
          assetPath: ImagePath.attendanceStoryCard,
          onTap: onCheckTap,
        ),
      ],
    );
  }
}
