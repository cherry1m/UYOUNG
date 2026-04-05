import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceBoardLayout extends StatelessWidget {
  const AttendanceBoardLayout({super.key, required this.viewModel});

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const starWidth = 160.0;
        const iconSize = 75.0;

        final labelStyle = AppFontStyle.H6.copyWith(
          color: const Color(0xFF6EA8EB),
        );

        final boardWidth = constraints.maxWidth;
        final boardHeight = constraints.maxHeight;

        const pathHorizontalInset = 18.0;
        const pathBottom = 130.0;
        final pathWidth = boardWidth - (pathHorizontalInset * 2);

        return Stack(
          children: [
            Positioned(
              left: pathHorizontalInset,
              right: pathHorizontalInset,
              bottom: pathBottom,
              child: Image.asset(ImagePath.attendanceBoardPath),
            ),

            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.03,
              top: boardHeight * 0.02,
              day: 1,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(1),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.44,
              top: boardHeight * 0.00,
              day: 2,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(2),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.75,
              top: boardHeight * 0.18,
              day: 3,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(3),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.35,
              top: boardHeight * 0.30,
              day: 4,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(4),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.00 - 40.0,
              top: boardHeight * 0.42,
              day: 5,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(5),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.25,
              top: boardHeight * 0.61,
              day: 6,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(6),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: pathHorizontalInset + pathWidth * 0.70,
              top: boardHeight * 0.54,
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

class _BoardTile extends StatelessWidget {
  const _BoardTile({
    required this.left,
    required this.top,
    required this.day,
    required this.starWidth,
    required this.iconSize,
    required this.imagePath,
    required this.labelStyle,
    this.highlighted = false,
  });

  final double left;
  final double top;
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
      top: top,
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
            child: SizedBox(
              width: starWidth,
              height: starWidth,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: Image.asset(
                        ImagePath.attendanceBoardStar,
                        width: starWidth,
                        height: starWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text('$day일차', style: labelStyle),
        ],
      ),
    );
  }
}
