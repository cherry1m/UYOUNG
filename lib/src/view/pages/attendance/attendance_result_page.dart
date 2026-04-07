import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_primary_button.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_stage_layout.dart';
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
    final safeBottom = mediaQuery.padding.bottom;
    final objectTop = mediaQuery.padding.top + size.height * 0.15;

    return Scaffold(
      body: AttendanceStageLayout(
        top: objectTop,
        safeBottom: safeBottom,
        backgroundAssetPath: ImagePath.attendanceItemBg,
        textTopSpacing: 330,
        actionHorizontalPadding: 28,
        object: Column(
          children: [
            Image.asset(
              viewModel.rewardImagePath,
              width: 320,
              height: 320,
              fit: BoxFit.contain,
            ),
          ],
        ),
        text: Column(
          children: [
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
        action: Row(
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
                      builder: (_) => AttendanceBoardPage(viewModel: viewModel),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AttendancePrimaryButton(
                text: '홈으로 가기',
                backgroundColor: Colors.white,
                textColor: const Color(0xFF6EA8EB),
                height: 54,
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
