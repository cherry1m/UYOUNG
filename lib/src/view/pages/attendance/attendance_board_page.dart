import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_board_header.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_board_layout.dart';
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
              padding: const EdgeInsets.fromLTRB(horizontalPadding, 14, horizontalPadding, 0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '출석체크',
                            style: AppFontStyle.H4.copyWith(color: Colors.black),
                          ),
                        ),
                        AttendanceBoardHeader(
                          decorationImagePath: viewModel.boardDecorationImagePath,
                        ),
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
                            child: AttendanceBoardLayout(viewModel: viewModel),
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
