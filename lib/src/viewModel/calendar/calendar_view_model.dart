import 'package:flutter/material.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/data/model/common/memory_island_list.dart';

class CalendarViewModel extends ChangeNotifier {
  /// 내부 상태: 기억섬 리스트
  final List<MemoryIsland> _islands = List.from(defaultMemoryIslands);

  /// 외부에서 읽기 전용으로 접근
  List<MemoryIsland> get islands => List.unmodifiable(_islands);

  /// 체크박스 선택/해제 (캘린더 필터 Drawer)
  void updateIslandSelection(int index, bool isSelected) {
    if (index < 0 || index >= _islands.length) return;

    _islands[index] = _islands[index].copyWith(isSelected: isSelected);
    notifyListeners();
  }

  /// 선택된 섬들만 가져오기 (나중에 캘린더 필터링용)
  List<MemoryIsland> get selectedIslands =>
      _islands.where((e) => e.isSelected).toList();

  /// 기억섬 순서 변경 (정렬 모드에서 사용)
  void reorderIslands(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _islands.length) return;
    if (newIndex < 0 || newIndex > _islands.length) return;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = _islands.removeAt(oldIndex);
    _islands.insert(newIndex, item);
    notifyListeners();
  }

  /// 알림 토글 (상세 설정 화면의 스위치)
  void toggleAlert(int index, bool enabled) {
    if (index < 0 || index >= _islands.length) return;

    _islands[index] = _islands[index].copyWith(alertEnabled: enabled);
    notifyListeners();
  }

  /// 이름/색상 수정
  void updateIslandInfo(int index, {String? name, Color? color}) {
    if (index < 0 || index >= _islands.length) return;

    _islands[index] = _islands[index].copyWith(name: name, color: color);
    notifyListeners();
  }

  /// 인덱스로 섬 가져오기
  MemoryIsland getIsland(int index) => _islands[index];

  /// 해당 날짜에 표시할 dot 색상 (선택된 기억섬 기준)
  List<Color> getDotColors(DateTime day) {
    final List<Color> colors = [];

    for (final island in _islands) {
      if (!island.isSelected) continue; // Drawer에서 체크된 섬만

      final hasPhoto = island.photoDates.any(
        (memoryDate) => memoryDate.isSameDay(day),
      );

      if (hasPhoto) {
        colors.add(island.color);
      }
    }

    return colors;
  }

  /// 해당 날짜에 표시할 썸네일 이미지 경로
  ///   - 사진이 있으면 썸네일 asset path
  ///   - 없으면 null (→ 기본 아이콘 사용)
  String? getThumbnailPath(DateTime day) {
    // 선택된 기억섬 중에서 먼저 매칭되는 애 하나만 사용
    for (final island in _islands) {
      if (!island.isSelected) continue;

      for (final entry in island.photoThumbnails.entries) {
        if (entry.key.isSameDay(day)) {
          return entry.value; // 해당 날짜 썸네일 path
        }
      }
    }
    return null;
  }

  /// 바텀시트 / 간소화 모드 상태
  bool isBottomSheetOpen = false;
  DateTime? openedDate; // 바텀시트가 열려 있는 날짜

  void openBottomSheet(DateTime date) {
    isBottomSheetOpen = true;
    openedDate = date;
    notifyListeners();
  }

  void closeBottomSheet() {
    isBottomSheetOpen = false;
    openedDate = null;
    notifyListeners();
  }

  /// 해당 날짜에 기억섬 사진 메모리가 있는지 여부
  bool hasMemory(DateTime day) {
    return _islands.any(
      (island) => island.photoDates.any(
        (d) => d.month == day.month && d.day == day.day,
      ),
    );
  }
}
