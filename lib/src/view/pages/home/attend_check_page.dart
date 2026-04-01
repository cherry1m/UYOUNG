import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/home/attendance_result_model.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day1_page.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day2_page.dart';
import 'package:uyoung/src/view/pages/home/attend/attend_day3_page.dart';
import 'package:uyoung/src/viewModel/home/attendance_view_model.dart';

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
        final attendTop = (safeTop + 58).clamp(96.0, 122.0);

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/home_check.png",
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
              _attendBoxes(
                context,
                viewModel,
                top: attendTop,
                horizontalPadding: horizontalPadding,
                boxSpacing: boxSpacing,
                boxWidth: boxWidth,
                boxHeight: boxHeight,
                iconSize: iconSize,
              ),
              _bottomStoryCard(
                context,
                viewModel,
                safeBottom: safeBottom,
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
    await viewModel.checkIn();

    if (!context.mounted) {
      return;
    }

    if (viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(viewModel.errorMessage!)));
      return;
    }

    if (viewModel.isAlreadyChecked) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('오늘 출석은 이미 완료했어요.')));
      return;
    }

    final result = viewModel.result;
    if (result == null || !result.isSuccess) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _pageForResult(result)),
    );

    if (context.mounted) {
      setState(() {});
    }
  }

  Widget _pageForResult(AttendanceResult result) {
    switch (result.streak) {
      case 1:
        return const AttendDay1Page();
      case 2:
        return const AttendDay2Page();
      case 3:
        return const AttendDay3Page();
      default:
        if (result.isWin && result.reward > 0) {
          return const AttendDay1Page();
        }
        return const AttendDay3Page();
    }
  }

  Widget _attendBoxes(
    BuildContext context,
    AttendanceViewModel viewModel, {
    required double top,
    required double horizontalPadding,
    required double boxSpacing,
    required double boxWidth,
    required double boxHeight,
    required double iconSize,
  }) {
    final checkedDays = viewModel.streak.clamp(0, 7);
    final currentDay = (checkedDays + 1).clamp(1, 7);
    const iconPaths = <String>[
      'assets/images/pearl.png',
      'assets/images/trash3.png',
      'assets/images/question.png',
      'assets/images/question.png',
      'assets/images/question.png',
      'assets/images/question.png',
      'assets/images/pearls.png',
    ];

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (index) {
            final day = index + 1;
            final isChecked = day <= checkedDays;
            final isToday = day == currentDay;
            final isTappable = isToday && !isChecked && !viewModel.isLoading;

            return Padding(
              padding: EdgeInsets.only(right: index == 6 ? 0 : boxSpacing),
              child: GestureDetector(
                onTap: isTappable ? () => _handleCheckIn(context) : null,
                child: Opacity(
                  opacity: isChecked || isToday ? 1.0 : 0.45,
                  child: Container(
                    width: boxWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isToday
                            ? const Color(0xFFFFD54F)
                            : isChecked
                            ? const Color(0xFFB9D7FF)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          iconPaths[index],
                          width: iconSize,
                          height: iconSize,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: boxHeight < 62 ? 2 : 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("$day일차", style: AppFontStyle.S8),
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
    );
  }

  Widget _bottomStoryCard(
    BuildContext context,
    AttendanceViewModel viewModel, {
    required double safeBottom,
  }) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: safeBottom > 0 ? 10 : 19,
      child: GestureDetector(
        onTap: viewModel.isLoading ? null : () => _handleCheckIn(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/home_alert_background.png",
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
                      viewModel.summaryTitle,
                      style: AppFontStyle.M_18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.summaryBody,
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
