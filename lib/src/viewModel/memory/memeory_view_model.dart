import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
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
  bool isSubmitting = false;

  // MARK: - 초기 데이터 불러오기
  Future<void> load() async {
    // 로딩 시작
    isLoaded = false;
    notifyListeners();

    // MARK: - 기존 저장된 기억섬 데이터 초기화 (필요할 때만 사용)
    // 상콩즈, 일본팸 ID 꼬일 때 반드시 필요함
    // 최초 1회만 쓰고 이후엔 주석 처리 권장
    // await _repository.clearAll();

    // SharedPreferences에서 데이터 로드
    items = await _repository.loadItems();

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

    _repository.saveItems(items);
    notifyListeners();
  }

  // MARK: - 즐겨찾기 토글
  void toggleFavorite(int index) {
    if (index < 0 || index >= items.length) return;

    items[index].isFavorite = !items[index].isFavorite;

    _repository.saveItems(items);
    notifyListeners();
  }

  // MARK: - 알림 토글
  void toggleAlarm(int index) {
    if (index < 0 || index >= items.length) return;

    items[index].isNotificationOn = !items[index].isNotificationOn;

    _repository.saveItems(items);
    notifyListeners();
  }

  // MARK: - 기억섬 삭제
  void removeItem(int index) {
    if (index < 0 || index >= items.length) return;

    items.removeAt(index);

    _repository.saveItems(items);
    notifyListeners();
  }

  Future<List<InviteeUser>> searchUsers(String searchTerm) {
    return _repository.searchUsers(searchTerm);
  }

  Future<String> createIsland({
    required String? islandName,
    required String color,
    XFile? backgroundImage,
    List<InviteeUser> invitees = const [],
  }) async {
    isSubmitting = true;
    notifyListeners();

    try {
      final resolvedName = _resolveIslandName(
        islandName: islandName,
        invitees: invitees,
      );
      final bgUrl = backgroundImage == null
          ? null
          : await _repository.uploadIslandBackground(backgroundImage);

      final islandId = await _repository.createIslandWithMembers(
        islandName: resolvedName,
        color: color,
        bgUrl: bgUrl,
        inviteeIds: invitees.map((user) => user.id).toList(),
      );

      items.insert(
        0,
        MemoryItem(
          id: islandId,
          title: resolvedName,
          isFavorite: false,
          isNotificationOn: true,
          imagePath: bgUrl,
        ),
      );
      await _repository.saveItems(items);
      return islandId;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  String _resolveIslandName({
    required String? islandName,
    required List<InviteeUser> invitees,
  }) {
    final trimmed = islandName?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      return trimmed;
    }

    if (invitees.isEmpty) {
      return '나의 기억섬';
    }

    if (invitees.length == 1) {
      return '${invitees.first.nickname}의 기억섬';
    }

    final names = invitees.take(2).map((user) => user.nickname).join(', ');
    return invitees.length > 2 ? '$names 외 ${invitees.length - 2}명' : names;
  }
}
