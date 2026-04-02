import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_primary_button.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceResultPage extends StatelessWidget {
  const AttendanceResultPage({super.key, required this.viewModel});

  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const _AttendanceResultView(),
    );
  }
}

class _AttendanceResultView extends StatelessWidget {
  const _AttendanceResultView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttendanceViewModel>();
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final safeTop = mediaQuery.padding.top;
    final safeBottom = mediaQuery.padding.bottom;
    // Main reward object block position on the result screen.
    final objectTop = safeTop + size.height * 0.17;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImagePath.attendanceMainBg, fit: BoxFit.cover),
          ),
          Positioned(
            top: safeTop + 8,
            left: 18,
            child: IconButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              icon: const Icon(Icons.chevron_left_rounded, size: 32),
              color: Colors.black,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    // Reward item + title + body block.
                    left: 28,
                    right: 28,
                    top: objectTop,
                    child: Column(
                      children: [
                        Image.asset(
                          viewModel.rewardImagePath,
                          width: 194,
                          height: 194,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          viewModel.resultTitle,
                          style: AppFontStyle.F3.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          viewModel.resultBody,
                          style: AppFontStyle.H8.copyWith(
                            color: Colors.white,
                            height: 1.45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    // Bottom button row on the result screen.
                    left: 28,
                    right: 28,
                    bottom: safeBottom + 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: AttendancePrimaryButton(
                            text: '출석 확인하기',
                            backgroundColor: Colors.white,
                            textColor: const Color(0xFF6EA8EB),
                            height: 54,
                            onTap: () {
                              viewModel.showBoard();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AttendanceBoardPage(viewModel: viewModel),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AttendancePrimaryButton(
                            text: '홈으로 가기',
                            backgroundColor: Colors.white,
                            textColor: const Color(0xFF6EA8EB),
                            height: 54,
                            onTap: () {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                          ),
                        ),
                      ],
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
