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
        const starWidth = 150.0;
        const iconSize = 75.0;

        final labelStyle = AppFontStyle.H6.copyWith(
          color: const Color(0xFF6EA8EB),
        );

        final boardWidth = constraints.maxWidth;
        final boardHeight = constraints.maxHeight;

        // Path image keeps its own horizontal inset.
        const pathHorizontalInset = 18.0;
        const basePathBottom = 150.0;
        const pathBottom = 150.0;
        final pathWidth = boardWidth - (pathHorizontalInset * 2);
        final verticalShift = basePathBottom - pathBottom;

        double syncedLeft(double ratio, {double offset = 0}) {
          return pathHorizontalInset + pathWidth * ratio + offset;
        }

        double syncedTop(double ratio, {double offset = 0}) {
          return boardHeight * ratio + verticalShift + offset;
        }

        return Stack(
          children: [
            Positioned(
              left: pathHorizontalInset,
              right: pathHorizontalInset,
              bottom: pathBottom,
              child: Image.asset(ImagePath.attendanceBoardPath),
            ),

            _BoardTile(
              left: syncedLeft(0.00),
              top: syncedTop(0.01),
              day: 1,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(1),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.41),
              top: syncedTop(0.00),
              day: 2,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(2),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.75),
              top: syncedTop(0.18),
              day: 3,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(3),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.35),
              top: syncedTop(0.27),
              day: 4,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(4),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.00, offset: -20),
              top: syncedTop(0.42),
              day: 5,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(5),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.27),
              top: syncedTop(0.57),
              day: 6,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(6),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: syncedLeft(0.70),
              top: syncedTop(0.54),
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
          Transform.translate(
            offset: const Offset(0, -20),
            child: Text('$day일차', style: labelStyle),
          ),
        ],
      ),
    );
  }
}
