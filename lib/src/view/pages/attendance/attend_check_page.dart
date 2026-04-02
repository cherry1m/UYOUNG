import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/attendance/attendance_model.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_board_page.dart';
import 'package:uyoung/src/view/pages/attendance/attendance_result_page.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_entry_step.dart';
import 'package:uyoung/src/view/pages/attendance/widgets/attendance_reveal_step.dart';
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
                AttendanceRevealStep(
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
                AttendanceEntryStep(
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
