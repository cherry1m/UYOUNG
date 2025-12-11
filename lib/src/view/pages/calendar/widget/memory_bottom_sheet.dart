import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/viewModel/calendar/calendar_view_model.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/src/view/pages/calendar/widget/memory_island_section.dart';

class MemoryBottomSheet extends StatelessWidget {
  final DateTime date;

  const MemoryBottomSheet({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();

    // Drawer에서 체크된 섬만 && 해당 날짜에 메모리가 있는 섬들만 추출
    final List<MemoryIsland> islandsForDay = calendarVM.islands
        .where(
          (island) =>
              island.isSelected &&
              island.photoDates.any((d) => d.isSameDay(date)),
        )
        .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -4),
                blurRadius: 16,
                spreadRadius: 0,
                color: Color(0x14000000), // #00000014
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // 상단 핸들바
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(height: 16),

              // 날짜 타이틀 (쓰고 싶으면 주석 풀기)
              Text("${date.month}월 ${date.day}일", style: AppFontStyle.M_20),
              const SizedBox(height: 12),

              // 내용 영역
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  children: [
                    for (final island in islandsForDay)
                      MemoryIslandSection(island: island, date: date),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
