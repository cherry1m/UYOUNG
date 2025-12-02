import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/sources/memory_storage.dart';

class MemoryViewModel extends ChangeNotifier {
  // MARK: - 저장소 인스턴스
  // SharedPreferences를 통해 데이터를 저장하고 불러오기 위한 클래스이다.
  final MemoryStorage _storage = MemoryStorage();

  // MARK: - 상태 값
  // 화면에 표시할 기억섬 데이터 리스트.
  List<MemoryItem> items = [];

  // 데이터 로딩 여부를 판단하는 플래그.
  bool isLoaded = false;

  // MARK: - 이름 변경 관련 상태
  // 현재 편집 중인 카드의 index 값.
  int? editingIndex;

  // 텍스트 필드를 컨트롤하기 위한 컨트롤러.
  final TextEditingController textController = TextEditingController();

  // MARK: - 초기 데이터 불러오기
  // 앱 실행 시 저장된 기억섬 데이터를 읽어와 리스트에 넣고 화면을 갱신한다.
  Future<void> load() async {
    items = await _storage.loadItems();
    isLoaded = true;
    notifyListeners();
  }

  // MARK: - 편집 모드 시작
  // 특정 index의 카드를 이름 수정 상태로 전환하고, 텍스트 필드에 기존 제목을 채운다.
  void startEditing(int index) {
    editingIndex = index;
    textController.text = items[index].title;
    notifyListeners();
  }

  // MARK: - 편집 모드 종료
  // 선택된 편집 상태를 초기화한다.
  void stopEditing() {
    editingIndex = null;
    notifyListeners();
  }

  // MARK: - 이름 변경 처리
  // 수정된 제목을 리스트에 반영하고 저장소에도 동일하게 반영한 뒤 화면을 갱신한다.
  void renameItem(int index, String newTitle) {
    items[index].title = newTitle;
    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 즐겨찾기 토글
  // 선택된 카드의 즐겨찾기 상태를 반전시키고 저장한다.
  void toggleFavorite(int index) {
    items[index].isFavorite = !items[index].isFavorite;
    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 알람 토글
  // 알림 설정 여부를 반전시키고 저장한 뒤 화면에 반영한다.
  void toggleAlarm(int index) {
    items[index].isNotificationOn = !items[index].isNotificationOn;
    _storage.saveItems(items);
    notifyListeners();
  }

  // MARK: - 기억섬 삭제
  // 특정 카드를 리스트에서 제거하고 저장소에 반영한다.
  void removeItem(int index) {
    items.removeAt(index);
    _storage.saveItems(items);
    notifyListeners();
  }
}
