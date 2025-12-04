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
    Key? key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onFocusedDayChanged,
    required this.onSelectedDayChanged,
    required this.onOpenMemoryBottomSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        locale: 'ko_KR',
        headerVisible: false,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        rowHeight: calendarVM.isBottomSheetOpen ? 45 : 95,
        daysOfWeekVisible: false,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),

        onDaySelected: (selected, newFocused) {
          final vm = context.read<CalendarViewModel>();

          // 부모 상태 업데이트
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
            final dotColor = calendarVM.getDotColor(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);
            final compact = calendarVM.isBottomSheetOpen;

            return CalendarDayCell(
              date: day,
              isOutside: day.month != focusedDay.month,
              isSelected: isSameDay(day, selectedDay),
              dotColor: dotColor,
              thumbnailPath: thumbnailPath,
              isCompactMode: compact,
            );
          },
          selectedBuilder: (context, day, _) {
            final dotColor = calendarVM.getDotColor(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);
            final compact = calendarVM.isBottomSheetOpen;

            return CalendarDayCell(
              date: day,
              isSelected: true,
              isOutside: day.month != focusedDay.month,
              dotColor: dotColor,
              thumbnailPath: thumbnailPath,
              isCompactMode: compact,
            );
          },
          todayBuilder: (context, day, _) {
            final dotColor = calendarVM.getDotColor(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);
            final compact = calendarVM.isBottomSheetOpen;

            return CalendarDayCell(
              date: day,
              isToday: true,
              isSelected: isSameDay(day, selectedDay),
              isOutside: day.month != focusedDay.month,
              dotColor: dotColor,
              thumbnailPath: thumbnailPath,
              isCompactMode: compact,
            );
          },
          outsideBuilder: (context, day, _) {
            final dotColor = calendarVM.getDotColor(day);
            final thumbnailPath = calendarVM.getThumbnailPath(day);
            final compact = calendarVM.isBottomSheetOpen;

            return CalendarDayCell(
              date: day,
              isOutside: true,
              dotColor: dotColor,
              thumbnailPath: thumbnailPath,
              isCompactMode: compact,
            );
          },
        ),
      ),
    );
  }
}
