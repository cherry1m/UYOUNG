import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendanceResultPage extends StatelessWidget {
  const AttendanceResultPage({
    super.key,
    required this.viewModel,
  });

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
    final safeTop = mediaQuery.padding.top;
    final safeBottom = mediaQuery.padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImagePath.attendanceMainBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: safeTop + 8,
            left: 18,
            child: IconButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              icon: const Icon(Icons.chevron_left_rounded, size: 32),
              color: Colors.black,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    viewModel.rewardImagePath,
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    viewModel.resultTitle,
                    style: AppFontStyle.F3.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    viewModel.resultBody,
                    style: AppFontStyle.H8.copyWith(
                      color: Colors.white,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: _BottomButton(
                          text: '출석 확인하기',
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF6EA8EB),
                          onTap: () {
                            viewModel.showBoard();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AttendanceBoardPage(
                                  viewModel: viewModel,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _BottomButton(
                          text: '홈으로 가기',
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFF6EA8EB),
                          onTap: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                        ),
                      ),
                    ],
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

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppFontStyle.H6.copyWith(color: textColor),
        ),
      ),
    );
  }
}
