import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/sources/memory_storage.dart';

// MARK: - MemoryRepository
// 이 클래스는 ViewModel과 Storage 사이의 중간 계층이다.
// ViewModel은 Repository에 요청을 보내고,
// Repository는 Storage로부터 데이터를 로드하거나 저장하도록 전달한다.
// 구조적으로 확장성(예: API 연동 가능성)을 고려한 레이어이므로 그대로 유지하는 것이 좋다.

class MemoryRepository {
  // 실제 데이터 저장 및 불러오기를 담당하는 Storage 인스턴스.
  final MemoryStorage _storage = MemoryStorage();

  // MARK: - 데이터 불러오기
  // SharedPreferences에서 MemoryItem 리스트를 읽어와 반환한다.
  Future<List<MemoryItem>> loadItems() => _storage.loadItems();

  // MARK: - 데이터 저장
  // 변경된 MemoryItem 리스트를 SharedPreferences에 저장한다.
  Future<void> saveItems(List<MemoryItem> items) => _storage.saveItems(items);
}
