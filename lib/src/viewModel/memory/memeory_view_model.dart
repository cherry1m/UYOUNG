import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/repositories/memory/memory_repository.dart';

class MemoryViewModel extends ChangeNotifier {
  final MemoryRepository _repository = MemoryRepository();

  // MARK: - 화면에 표시할 기억섬 리스트
  List<MemoryItem> items = [];

  // MARK: - 데이터 로딩 여부
  bool isLoaded = false;

  // MARK: - 이름 수정 관련 상태
  int? editingIndex;
  final TextEditingController textController = TextEditingController();
  String? errorMessage;

  // MARK: - 초기 데이터 불러오기
  Future<void> load() async {
    // 로딩 시작
    isLoaded = false;
    notifyListeners();

    // MARK: - 기존 저장된 기억섬 데이터 초기화 (필요할 때만 사용)
    // 상콩즈, 일본팸 ID 꼬일 때 반드시 필요함
    // 최초 1회만 쓰고 이후엔 주석 처리 권장
    // await _repository.clearAll();

    try {
      items = await _repository.loadItems();
      _sortItems();
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    }

    // 로딩 완료
    isLoaded = true;
    notifyListeners();
  }

  // MARK: - 편집 모드 시작
  void startEditing(int index) {
    editingIndex = index;
    textController.text = items[index].title;
    notifyListeners();
  }

  // MARK: - 편집 모드 종료
  void stopEditing() {
    editingIndex = null;
    notifyListeners();
  }

  // MARK: - 이름 변경
  Future<void> renameItem(int index, String newTitle) async {
    if (index < 0 || index >= items.length) return;

    final previousTitle = items[index].title;
    items[index].title = newTitle;
    editingIndex = null;
    notifyListeners();

    try {
      await _repository.updateIslandName(
        islandId: items[index].id,
        name: newTitle,
      );
      items[index].updatedAt = DateTime.now();
      _sortItems();
      await _repository.saveItems(items);
      notifyListeners();
    } catch (_) {
      items[index].title = previousTitle;
      notifyListeners();
      rethrow;
    }
  }

  // MARK: - 즐겨찾기 토글
  Future<void> toggleFavorite(int index) async {
    if (index < 0 || index >= items.length) return;

    final previousValue = items[index].isFavorite;
    items[index].isFavorite = !items[index].isFavorite;
    notifyListeners();

    try {
      await _repository.updateIslandMemberSettings(
        islandId: items[index].id,
        isFavorite: items[index].isFavorite,
      );
      _sortItems();
      await _repository.saveItems(items);
      notifyListeners();
    } catch (_) {
      items[index].isFavorite = previousValue;
      _sortItems();
      notifyListeners();
      rethrow;
    }
  }

  // MARK: - 알림 토글
  Future<void> toggleAlarm(int index) async {
    if (index < 0 || index >= items.length) return;

    final previousValue = items[index].isNotificationOn;
    items[index].isNotificationOn = !items[index].isNotificationOn;
    notifyListeners();

    try {
      await _repository.updateIslandMemberSettings(
        islandId: items[index].id,
        isMuted: !items[index].isNotificationOn,
      );
      await _repository.saveItems(items);
      notifyListeners();
    } catch (_) {
      items[index].isNotificationOn = previousValue;
      notifyListeners();
      rethrow;
    }
  }

  // MARK: - 기억섬 삭제
  Future<void> removeItem(int index) async {
    if (index < 0 || index >= items.length) return;

    final removedItem = items[index];
    items.removeAt(index);
    notifyListeners();

    try {
      await _repository.leaveIsland(removedItem.id);
      await _repository.saveItems(items);
    } catch (_) {
      items.insert(index, removedItem);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> insertCreatedItem(MemoryItem item) async {
    items.insert(0, item);
    _sortItems();
    await _repository.saveItems(items);
    notifyListeners();
  }

  Future<void> insertOrUpdateItem(MemoryItem item) async {
    final index = items.indexWhere((existing) => existing.id == item.id);
    if (index >= 0) {
      items[index] = item;
    } else {
      items.insert(0, item);
    }
    _sortItems();
    await _repository.saveItems(items);
    notifyListeners();
  }

  void _sortItems() {
    items.sort((a, b) {
      if (a.isFavorite != b.isFavorite) {
        return a.isFavorite ? -1 : 1;
      }

      final aUpdatedAt = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bUpdatedAt = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bUpdatedAt.compareTo(aUpdatedAt);
    });
  }
}
