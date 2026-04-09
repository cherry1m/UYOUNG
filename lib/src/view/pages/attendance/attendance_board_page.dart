import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_board_layout.dart';
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
            bottom: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 14,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            '출석체크',
                            style: AppFontStyle.H4.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      _AttendanceBoardHeader(viewModel: viewModel),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 230,
                        bottom: 0,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
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
                  left: 28,
                  right: 28,
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
      top: 36,
      left: 20,
      right: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 52),
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
          Image.asset(
            ImagePath.attendanceItemTrashBundle,
            width: 156,
            height: 156,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
