import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/sources/memory/memory_storage.dart';

class MemoryViewModel extends ChangeNotifier {
  // MARK: - 저장소 인스턴스
  // SharedPreferences를 통해 데이터를 저장하고 불러오기 위한 클래스
  final MemoryStorage _storage = MemoryStorage();

  // MARK: - 화면에 표시할 기억섬 리스트
  List<MemoryItem> items = [];

  // MARK: - 데이터 로딩 여부
  bool isLoaded = false;

  // MARK: - 이름 수정 관련 상태
  int? editingIndex;
  final TextEditingController textController = TextEditingController();

  // MARK: - 초기 데이터 불러오기
  Future<void> load() async {
    // 로딩 시작
    isLoaded = false;
    notifyListeners();

    // MARK: - 기존 저장된 기억섬 데이터 초기화 (필요할 때만 사용)
    // 상콩즈, 일본팸 ID 꼬일 때 반드시 필요함
    // 최초 1회만 쓰고 이후엔 주석 처리 권장
    // await _storage.clearAll();

    // SharedPreferences에서 데이터 로드
    items = await _storage.loadItems();

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
  void renameItem(int index, String newTitle) {
    if (index < 0 || index >= items.length) return;

    items[index].title = newTitle;
    editingIndex = null;

    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 즐겨찾기 토글
  void toggleFavorite(int index) {
    if (index < 0 || index >= items.length) return;

    items[index].isFavorite = !items[index].isFavorite;

    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 알림 토글
  void toggleAlarm(int index) {
    if (index < 0 || index >= items.length) return;

    items[index].isNotificationOn = !items[index].isNotificationOn;

    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 기억섬 삭제
  void removeItem(int index) {
    if (index < 0 || index >= items.length) return;

    items.removeAt(index);

    _storage.saveItems(items);
    notifyListeners();
  }
}
