import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class MemoryStorage {
  // MARK: - SharedPreferences에 사용할 key 값
  static const String _key = "memory_items";

  // MARK: - 저장된 기억섬 리스트 불러오기
  // 저장된 캐시가 없으면 빈 리스트를 반환한다.
  Future<List<MemoryItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List data = jsonDecode(jsonString);
    if (data.isEmpty) {
      return [];
    }

    return data.map((e) => MemoryItem.fromMap(e)).toList();
  }

  // MARK: - 기억섬 리스트 저장
  // MemoryItem 리스트를 JSON 문자열로 변환하여 SharedPreferences에 저장
  Future<void> saveItems(List<MemoryItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString(_key, jsonString);
  }

  // MARK: - 모든 기억섬 데이터 초기화 (ID 꼬였을 때 필수)
  // 일본팸/상콩즈 데이터 잘못 매칭될 때 딱 1번만 실행
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
