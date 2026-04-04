import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceBoardLayout extends StatelessWidget {
  const AttendanceBoardLayout({
    super.key,
    required this.viewModel,
  });

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final starWidth = (constraints.maxWidth * 0.26).clamp(84.0, 110.0);
        final iconSize = (starWidth * 0.52).clamp(34.0, 50.0);
        final labelStyle = constraints.maxWidth < 360
            ? AppFontStyle.S8.copyWith(color: const Color(0xFF6EA8EB))
            : AppFontStyle.H6.copyWith(color: const Color(0xFF6EA8EB));

        return Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 12,
                ),
                child: Image.asset(
                  ImagePath.attendanceBoardPath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            AttendanceBoardTile(
              left: constraints.maxWidth * 0.05,
              top: constraints.maxHeight * 0.05,
              day: 1,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(1),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              left: constraints.maxWidth * 0.39,
              top: constraints.maxHeight * 0.00,
              day: 2,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(2),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              right: constraints.maxWidth * 0.03,
              top: constraints.maxHeight * 0.14,
              day: 3,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(3),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              left: constraints.maxWidth * 0.40,
              top: constraints.maxHeight * 0.38,
              day: 4,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(4),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              left: constraints.maxWidth * 0.02,
              top: constraints.maxHeight * 0.60,
              day: 5,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(5),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              left: constraints.maxWidth * 0.40,
              bottom: constraints.maxHeight * 0.01,
              day: 6,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(6),
              labelStyle: labelStyle,
            ),
            AttendanceBoardTile(
              right: constraints.maxWidth * 0.03,
              bottom: constraints.maxHeight * 0.12,
              day: 7,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(7),
              highlighted: viewModel.checkedDays >= 7,
              labelStyle: labelStyle,
            ),
          ],
        );
      },
    );
  }
}

class AttendanceBoardTile extends StatelessWidget {
  const AttendanceBoardTile({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.day,
    required this.starWidth,
    required this.iconSize,
    required this.imagePath,
    required this.labelStyle,
    this.highlighted = false,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final int day;
  final double starWidth;
  final double iconSize;
  final String imagePath;
  final TextStyle labelStyle;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: highlighted
                ? BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x66FFF5A6),
                        blurRadius: 24,
                        spreadRadius: 8,
                      ),
                    ],
                  )
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImagePath.attendanceBoardStar,
                  width: starWidth,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  imagePath,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text('$day일차', style: labelStyle),
        ],
      ),
    );
  }
}
