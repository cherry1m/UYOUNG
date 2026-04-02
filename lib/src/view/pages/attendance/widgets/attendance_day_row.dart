import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceDayRow extends StatelessWidget {
  const AttendanceDayRow({
    super.key,
    required this.horizontalPadding,
    required this.boxSpacing,
    required this.boxWidth,
    required this.boxHeight,
    required this.iconSize,
    required this.viewModel,
    required this.onCheckTap,
  });

  final double horizontalPadding;
  final double boxSpacing;
  final double boxWidth;
  final double boxHeight;
  final double iconSize;
  final AttendanceViewModel viewModel;
  final VoidCallback onCheckTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(7, (index) {
          final day = index + 1;
          final isReceived = day <= viewModel.checkedDays;
          final isToday =
              !viewModel.hasCheckedToday && day == viewModel.currentDay;
          final isFuture =
              day >
              (viewModel.hasCheckedToday
                  ? viewModel.checkedDays
                  : viewModel.currentDay);
          final imagePath = isReceived
              ? viewModel.entryBoardItemPath(day)
              : ImagePath.attendanceItemQuestion;

          return Padding(
            padding: EdgeInsets.only(right: index == 6 ? 0 : boxSpacing),
            child: GestureDetector(
              onTap: isToday && !viewModel.isLoading ? onCheckTap : null,
              child: Opacity(
                opacity: isFuture ? 0.45 : 1.0,
                child: Container(
                  width: boxWidth,
                  height: boxHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isToday
                          ? const Color(0xFFFFD54F)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        imagePath,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: boxHeight < 62 ? 2 : 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('$day일차', style: AppFontStyle.S8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
