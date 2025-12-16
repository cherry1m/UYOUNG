import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/src/view/pages/calendar/widget/calendar_day_cell.dart';

class CalendarTableSection extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;

  final ValueChanged<DateTime> onFocusedDayChanged;
  final ValueChanged<DateTime?> onSelectedDayChanged;

  /// 기억섬 있는 날짜를 탭했을 때 바텀시트 열도록 부모에 알려주는 콜백
  final void Function(DateTime) onOpenMemoryBottomSheet;

  const CalendarTableSection({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onFocusedDayChanged,
    required this.onSelectedDayChanged,
    required this.onOpenMemoryBottomSheet,
  });

  // 해당 month가 달력에서 5주인지 6주인지 계산 (StartingDayOfWeek.sunday 기준)
  int _weeksInMonth(DateTime day) {
    final firstOfMonth = DateTime(day.year, day.month, 1);
    final lastOfMonth = DateTime(day.year, day.month + 1, 0);

    DateTime start = firstOfMonth;
    // dart weekday: Mon=1..Sun=7
    while (start.weekday != DateTime.sunday) {
      start = start.subtract(const Duration(days: 1));
    }

    DateTime end = lastOfMonth;
    while (end.weekday != DateTime.saturday) {
      end = end.add(const Duration(days: 1));
    }

    final totalDays = end.difference(start).inDays + 1;
    return (totalDays / 7).ceil(); // 5 or 6
  }

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();

    final isCompact = calendarVM.isBottomSheetOpen;
    final weeks = _weeksInMonth(focusedDay);

    /// ✅ rowHeight는 여기서만 결정
    /// - 일반 모드: 95
    /// - 간소화 모드: 5주 / 6주 다르게
    final double rowHeight = isCompact ? (weeks == 5 ? 45 : 40) : 95;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        locale: 'ko_KR',
        headerVisible: false,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: false,

        // ✅ 5주 달은 5줄만 나오게
        sixWeekMonthsEnforced: false,

        rowHeight: rowHeight,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),

        onDaySelected: (selected, newFocused) {
          final vm = context.read<CalendarViewModel>();

          onSelectedDayChanged(selected);
          onFocusedDayChanged(newFocused);

          final hasMemory = vm.hasMemory(selected);

          if (hasMemory) {
            vm.openBottomSheet(selected);
            onOpenMemoryBottomSheet(selected);
          } else {
            vm.closeBottomSheet();
          }
        },

        onPageChanged: (newFocused) {
          onFocusedDayChanged(newFocused);
        },

        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, _) {
            final dotColors = calendarVM.getDotColors(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);

            return CalendarDayCell(
              date: day,
              isOutside: day.month != focusedDay.month,
              isSelected: isSameDay(day, selectedDay),
              dotColors: dotColors,
              thumbnailPath: thumbnailPath,
              isCompactMode: isCompact,
              compactWeeks: weeks, // ✅ 전달
            );
          },
          selectedBuilder: (context, day, _) {
            final dotColors = calendarVM.getDotColors(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);

            return CalendarDayCell(
              date: day,
              isSelected: true,
              isOutside: day.month != focusedDay.month,
              dotColors: dotColors,
              thumbnailPath: thumbnailPath,
              isCompactMode: isCompact,
              compactWeeks: weeks, // ✅ 전달
            );
          },
          todayBuilder: (context, day, _) {
            final dotColors = calendarVM.getDotColors(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);

            return CalendarDayCell(
              date: day,
              isToday: true,
              isSelected: isSameDay(day, selectedDay),
              isOutside: day.month != focusedDay.month,
              dotColors: dotColors,
              thumbnailPath: thumbnailPath,
              isCompactMode: isCompact,
              compactWeeks: weeks, // ✅ 전달
            );
          },
          outsideBuilder: (context, day, _) {
            final dotColors = calendarVM.getDotColors(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);

            return CalendarDayCell(
              date: day,
              isOutside: true,
              dotColors: dotColors,
              thumbnailPath: thumbnailPath,
              isCompactMode: isCompact,
              compactWeeks: weeks, // ✅ 전달
            );
          },
        ),
      ),
    );
  }
}
