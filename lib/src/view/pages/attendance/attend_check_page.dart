import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/attendance/attendance_model.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_result_page.dart';
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
        final horizontalPadding = size.width < 390 ? 12.0 : 16.0;
        final boxSpacing = size.width < 390 ? 4.0 : 6.0;
        final boxWidth =
            ((size.width - (horizontalPadding * 2) - (boxSpacing * 6)) / 7)
                .clamp(38.0, 46.0);
        final boxHeight = (boxWidth * 1.48).clamp(56.0, 68.0);
        final iconSize = (boxWidth * 0.48).clamp(18.0, 22.0);
        final boardTop = (safeTop + 58).clamp(96.0, 122.0);

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
                        builder: (_) => AttendanceResultPage(viewModel: _viewModel),
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
          top: top,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(7, (index) {
                final day = index + 1;
                final isReceived = day <= viewModel.checkedDays;
                final isToday =
                    !viewModel.hasCheckedToday && day == viewModel.currentDay;
                final isFuture =
                    day > (viewModel.hasCheckedToday
                        ? viewModel.checkedDays
                        : viewModel.currentDay);
                final imagePath = isReceived
                    ? viewModel.entryBoardItemPath(day)
                    : ImagePath.attendanceItemQuestion;

                return Padding(
                  padding: EdgeInsets.only(right: index == 6 ? 0 : boxSpacing),
                  child: GestureDetector(
                    onTap: isToday && !viewModel.isLoading ? onCheckTap : null,
                    child: Opacity(
                      opacity: isFuture ? 0.45 : 1.0,
                      child: Container(
                        width: boxWidth,
                        height: boxHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isToday
                                ? const Color(0xFFFFD54F)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imagePath,
                              width: iconSize,
                              height: iconSize,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: boxHeight < 62 ? 2 : 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('$day일차', style: AppFontStyle.S8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: top + boxHeight + 42,
          child: Center(
            child: Image.asset(
              ImagePath.attendanceOtterDive,
              width: 260,
              fit: BoxFit.contain,
            ),
          ),
        ),
        _StoryCard(
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
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: top + 60,
          child: Center(
            child: GestureDetector(
              onTap: onClamTap,
              child: Image.asset(
                ImagePath.attendanceItemClam,
                width: 190,
                height: 190,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: top + 280,
          child: Column(
            children: [
              Text(
                '어! 심해에서',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                '해달이 무언갈 주웠나봐요,',
                style: AppFontStyle.F3.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: safeBottom > 0 ? 10 : 19,
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: onClamTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6EA8EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                '아이템 확인해보기',
                style: AppFontStyle.H6.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.body,
    required this.safeBottom,
    required this.assetPath,
    this.onTap,
  });

  final String title;
  final String body;
  final double safeBottom;
  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: safeBottom > 0 ? 10 : 19,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              assetPath,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.M_18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      body,
                      style: AppFontStyle.S8.copyWith(
                        color: const Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
