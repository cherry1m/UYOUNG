import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceBoardPage extends StatelessWidget {
  const AttendanceBoardPage({super.key, required this.viewModel});

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
    // Shared horizontal inset for the board screen.
    const horizontalPadding = 20.0;

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
              padding: const EdgeInsets.fromLTRB(
                horizontalPadding,
                14,
                horizontalPadding,
                0,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '출석체크',
                            style: AppFontStyle.H4.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _AttendanceBoardHeader(viewModel: viewModel),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 214,
                          bottom: 82,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 16, 10, 18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9E9FF),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: _AttendanceBoardLayout(viewModel: viewModel),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    // Bottom CTA button on the board screen.
                    left: 0,
                    right: 0,
                    bottom: safeBottom + 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceBoardHeader extends StatelessWidget {
  const _AttendanceBoardHeader({required this.viewModel});

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.boardItemSummary,
                    style: AppFontStyle.F3.copyWith(
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    viewModel.boardSubSummary,
                    style: AppFontStyle.H6.copyWith(
                      color: const Color(0xFF7E7E7E),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          Image.asset(
            ImagePath.attendanceItemTrashBundle,
            width: 180,
            height: 180,
            fit: BoxFit.contain,
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
        const starWidth = 200.0;
        final iconSize = (starWidth * 0.52).clamp(34.0, 50.0);
        final labelStyle = constraints.maxWidth < 360
            ? AppFontStyle.S8.copyWith(color: const Color(0xFF6EA8EB))
            : AppFontStyle.H6.copyWith(color: const Color(0xFF6EA8EB));
        final boardWidth = constraints.maxWidth;
        final boardHeight = constraints.maxHeight;

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
            _BoardTile(
              left: boardWidth * -0.07,
              top: boardHeight * 0.02,
              day: 1,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(1),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * 0.27,
              top: boardHeight * -0.03,
              day: 2,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(2),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * 0.64,
              top: boardHeight * 0.14,
              day: 3,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(3),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * 0.27,
              top: boardHeight * 0.34,
              day: 4,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(4),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * -0.06,
              top: boardHeight * 0.56,
              day: 5,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(5),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * 0.19,
              top: boardHeight * 0.76,
              day: 6,
              starWidth: starWidth,
              iconSize: iconSize,
              imagePath: viewModel.boardItemPathForDay(6),
              labelStyle: labelStyle,
            ),
            _BoardTile(
              left: boardWidth * 0.62,
              top: boardHeight * 0.69,
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
    this.top,
    required this.day,
    required this.starWidth,
    required this.iconSize,
    required this.imagePath,
    required this.labelStyle,
    this.highlighted = false,
  });

  final double? left;
  final double? top;
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
