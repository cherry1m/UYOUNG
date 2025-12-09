import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:provider/provider.dart';

import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/src/view/pages/calendar/widget/memory_drawer.dart';
import 'package:uyoung/src/view/pages/calendar/widget/memory_bottom_sheet.dart';
import 'package:uyoung/src/view/pages/calendar/widget/calendar_table_section.dart'; // ⭐ 새로 추가

import 'widget/calendar_month_header.dart';
import 'widget/calendar_week_header.dart';

class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({Key? key}) : super(key: key);

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      endDrawer: MemoryIslandDrawer(
        islands: calendarVM.islands,
        onChanged: (index, value) {
          calendarVM.updateIslandSelection(index, value);
        },
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(context),
            const SizedBox(height: 9),
            CalendarMonthHeader(
              month: _focusedDay,
              onTapArrow: _openMonthPicker,
            ),
            const SizedBox(height: 23),
            const CalendarWeekHeader(),
            const SizedBox(height: 18),
            Expanded(
              child: _buildCalendar(), // ⭐ 내부에서 분리된 위젯 사용
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  //  상단 앱바
  // -------------------------------
  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text('캘린더', style: AppFontStyle.M_20),

          const Spacer(),

          // 필터 버튼
          Builder(
            builder: (context) {
              return IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: ImageData(path: ImagePath.filter, width: 44, height: 44),
              );
            },
          ),

          // 오늘 버튼
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
            icon: ImageData(path: ImagePath.today, height: 44),
          ),
        ],
      ),
    );
  }

  // -------------------------------
  //  캘린더 위젯 (이제는 분리된 섹션 위젯 사용)
  // -------------------------------
  Widget _buildCalendar() {
    return CalendarTableSection(
      focusedDay: _focusedDay,
      selectedDay: _selectedDay,
      onFocusedDayChanged: (day) {
        setState(() {
          _focusedDay = day;
        });
      },
      onSelectedDayChanged: (day) {
        setState(() {
          _selectedDay = day;
        });
      },
      onOpenMemoryBottomSheet: _openMemoryBottomSheet, // ⭐ 바텀시트 콜백
    );
  }

  // -------------------------------
  //  월/연도 선택 팝업
  // -------------------------------
  void _openMonthPicker() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        int tempYear = _focusedDay.year;
        int tempMonth = _focusedDay.month;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 연도 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          setStateDialog(() => tempYear--);
                        },
                      ),
                      Text("$tempYear년", style: AppFontStyle.M_20),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          setStateDialog(() => tempYear++);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 월 선택 그리드
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(12, (index) {
                      final month = index + 1;
                      final isTempSelected = tempMonth == month;

                      return GestureDetector(
                        onTap: () {
                          setStateDialog(() => tempMonth = month);
                        },
                        child: Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isTempSelected
                                ? AppColors.mainBlue.withOpacity(0.12)
                                : const Color(0xFFF3F4F7),
                            borderRadius: BorderRadius.circular(8),
                            border: isTempSelected
                                ? Border.all(
                                    color: AppColors.mainBlue,
                                    width: 1,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "$month월",
                            style: AppFontStyle.M_16.copyWith(
                              fontSize: 14,
                              color: isTempSelected
                                  ? AppColors.mainBlue
                                  : const Color(0xFF333333),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  // 🔥 취소/확인 버튼
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          child: Text(
                            "취소",
                            style: AppFontStyle.M_16.copyWith(
                              color: AppColors.mainGray,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(tempYear, tempMonth, 1);
                              _selectedDay = null;
                            });
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "확인",
                            style: AppFontStyle.M_16.copyWith(
                              color: AppColors.mainBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // -------------------------------
  //  기억섬 바텀시트
  // -------------------------------
  void _openMemoryBottomSheet(DateTime date) {
    final calendarVM = context.read<CalendarViewModel>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 내부에서 흰 배경 + shadow
      barrierColor: Colors.transparent, // 뒤 배경 안 어둡게
      builder: (context) {
        return MemoryBottomSheet(date: date);
      },
    ).whenComplete(() {
      // 바텀시트 닫힐 때 간소화 모드 해제
      calendarVM.closeBottomSheet();
    });
  }
}
