import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceBoardPage extends StatelessWidget {
  const AttendanceBoardPage({
    super.key,
    required this.viewModel,
  });

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const _AttendanceBoardView(),
    );
  }
}

class _AttendanceBoardView extends StatelessWidget {
  const _AttendanceBoardView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttendanceViewModel>();
    final mediaQuery = MediaQuery.of(context);
    final safeTop = mediaQuery.padding.top;
    final safeBottom = mediaQuery.padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: safeTop + 8,
            left: 18,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left_rounded, size: 32),
              color: Colors.black,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '출석체크',
                      style: AppFontStyle.H4.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    '오늘도 출석완료!\n아이템 확인해주세요',
                    style: AppFontStyle.F3.copyWith(
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '연속 출석체크 스타트!',
                    style: AppFontStyle.H6.copyWith(
                      color: const Color(0xFF7E7E7E),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      viewModel.boardDecorationImagePath,
                      width: 146,
                      height: 146,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9E9FF),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: _AttendanceBoardLayout(viewModel: viewModel),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6EA8EB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        '홈으로 가기',
                        style: AppFontStyle.H6.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: safeBottom > 0 ? 8 : 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceBoardLayout extends StatelessWidget {
  const _AttendanceBoardLayout({required this.viewModel});

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final starWidth = (constraints.maxWidth * 0.23).clamp(74.0, 102.0);
        final iconSize = (starWidth * 0.48).clamp(28.0, 46.0);
        final labelStyle = constraints.maxWidth < 360
            ? AppFontStyle.S8.copyWith(color: const Color(0xFF6EA8EB))
            : AppFontStyle.H6.copyWith(color: const Color(0xFF6EA8EB));

        return Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
                child: Image.asset(
                  ImagePath.attendanceBoardPath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            _BoardTile(
              left: constraints.maxWidth * 0.05,
              top: constraints.maxHeight * 0.02,
              day: 1,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(1),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: constraints.maxWidth * 0.35,
              top: 0,
              day: 2,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(2),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              right: constraints.maxWidth * 0.05,
              top: constraints.maxHeight * 0.10,
              day: 3,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(3),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: constraints.maxWidth * 0.34,
              top: constraints.maxHeight * 0.37,
              day: 4,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(4),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: constraints.maxWidth * 0.03,
              top: constraints.maxHeight * 0.56,
              day: 5,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(5),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: constraints.maxWidth * 0.37,
              bottom: constraints.maxHeight * 0.02,
              day: 6,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(6),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              right: constraints.maxWidth * 0.05,
              bottom: constraints.maxHeight * 0.10,
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
          const SizedBox(height: 6),
          Text(
            '$day일차',
            style: labelStyle,
          ),
        ],
      ),
    );
  }
}
