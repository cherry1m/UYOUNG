import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/attendance/attendance_model.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_result_page.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_day_row.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_primary_button.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_story_card.dart';
import 'package:uyoung/src/viewModel/attendance/attendance_view_model.dart';

class AttendCheckPage extends StatefulWidget {
  const AttendCheckPage({super.key});

  @override
  State<AttendCheckPage> createState() => _AttendCheckPageState();
}

class _AttendCheckPageState extends State<AttendCheckPage> {
  late final AttendanceViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AttendanceViewModel();
    _viewModel.loadBoardData();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        final viewModel = context.watch<AttendanceViewModel>();
        final mediaQuery = MediaQuery.of(context);
        final size = mediaQuery.size;
        final safeTop = mediaQuery.padding.top;
        final safeBottom = mediaQuery.padding.bottom;
        final horizontalPadding = 16.0;
        final boxSpacing = 2.0;
        final boxWidth =
            ((size.width - (horizontalPadding * 2) - (boxSpacing * 6)) / 7)
                .clamp(39.0, 44.0);
        final boxHeight = (boxWidth * 1.52).clamp(58.0, 66.0);
        final iconSize = (boxWidth * 0.46).clamp(18.0, 22.0);
        // Top row of 1~7 day boxes.
        final boardTop = safeTop + 50;

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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.chevron_left_rounded, size: 32),
                  color: Colors.black,
                ),
              ),
              if (viewModel.isRevealStep)
                _RevealStep(
                  onClamTap: () {
                    viewModel.showResult();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AttendanceResultPage(viewModel: _viewModel),
                      ),
                    );
                  },
                  top: boardTop,
                  safeBottom: safeBottom,
                )
              else
                _EntryStep(
                  onCheckTap: () => _handleCheckIn(context),
                  top: boardTop,
                  safeBottom: safeBottom,
                  horizontalPadding: horizontalPadding,
                  boxSpacing: boxSpacing,
                  boxWidth: boxWidth,
                  boxHeight: boxHeight,
                  iconSize: iconSize,
                  viewModel: viewModel,
                ),
              if (viewModel.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.08),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleCheckIn(BuildContext context) async {
    final viewModel = context.read<AttendanceViewModel>();
    final nextStep = await viewModel.checkIn();

    if (!context.mounted) {
      return;
    }

    if (viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
      return;
    }

    if (nextStep == AttendanceFlowStep.board && viewModel.isAlreadyChecked) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AttendanceBoardPage(viewModel: _viewModel),
        ),
      );
    }
  }
}

class _EntryStep extends StatelessWidget {
  const _EntryStep({
    required this.onCheckTap,
    required this.top,
    required this.safeBottom,
    required this.horizontalPadding,
    required this.boxSpacing,
    required this.boxWidth,
    required this.boxHeight,
    required this.iconSize,
    required this.viewModel,
  });

  final VoidCallback onCheckTap;
  final double top;
  final double safeBottom;
  final double horizontalPadding;
  final double boxSpacing;
  final double boxWidth;
  final double boxHeight;
  final double iconSize;
  final AttendanceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // Attendance day boxes row.
          top: top,
          left: 0,
          right: 0,
          child: AttendanceDayRow(
            horizontalPadding: horizontalPadding,
            boxSpacing: boxSpacing,
            boxWidth: boxWidth,
            boxHeight: boxHeight,
            iconSize: iconSize,
            viewModel: viewModel,
            onCheckTap: onCheckTap,
          ),
        ),
        Positioned(
          // Main otter illustration on the entry screen.
          left: 0,
          right: 0,
          top: top + boxHeight + 34,
          child: Center(
            child: Image.asset(
              ImagePath.attendanceOtterDive,
              width: 316,
              fit: BoxFit.contain,
            ),
          ),
        ),
        AttendanceStoryCard(
          title: '해달이 무언가를 밑에서 가져오려해요',
          body: '오늘은 어떤 걸 주워올까요?',
          safeBottom: safeBottom,
          assetPath: ImagePath.attendanceStoryCard,
          onTap: onCheckTap,
        ),
      ],
    );
  }
}

class _RevealStep extends StatelessWidget {
  const _RevealStep({
    required this.onClamTap,
    required this.top,
    required this.safeBottom,
  });

  final VoidCallback onClamTap;
  final double top;
  final double safeBottom;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    // Clam object vertical anchor on the reveal screen.
    final clamTop = top + size.height * 0.035;
    // Text block under the clam on the reveal screen.
    final textTop = clamTop + 210;

    return Stack(
      children: [
        Positioned(
          // Clam object position.
          left: 0,
          right: 0,
          top: clamTop,
          child: Center(
            child: GestureDetector(
              onTap: onClamTap,
              child: Image.asset(
                ImagePath.attendanceItemClam,
                width: 214,
                height: 214,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          // Reveal text position.
          left: 0,
          right: 0,
          top: textTop,
          child: Column(
            children: [
              Text(
                '어! 심해에서',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '해달이 무언갈 주웠나봐요,',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          // Bottom CTA button on the reveal screen.
          left: 16,
          right: 16,
          bottom: safeBottom + 2,
          child: AttendancePrimaryButton(
            text: '아이템 확인해보기',
            onTap: onClamTap,
          ),
        ),
      ],
    );
  }
}
