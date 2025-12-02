import 'package:flutter/material.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/data/model/calendar/memory_island_list.dart';

class CalendarViewModel extends ChangeNotifier {
  // 내부 상태
  final List<MemoryIsland> _islands = List.from(defaultMemoryIslands);

  // 외부에서 읽는 용
  List<MemoryIsland> get islands => List.unmodifiable(_islands);

  /// 체크박스 선택/해제
  void updateIslandSelection(int index, bool isSelected) {
    if (index < 0 || index >= _islands.length) return;

    _islands[index] = _islands[index].copyWith(isSelected: isSelected);
    notifyListeners();
  }

  /// 선택된 섬들만 가져오기 (나중에 캘린더 필터링용)
  List<MemoryIsland> get selectedIslands =>
      _islands.where((e) => e.isSelected).toList();
}
