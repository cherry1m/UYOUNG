import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class MemoryStorage {
  // MARK: - SharedPreferences에 사용할 key 값
  static const String _key = "memory_items";

  // MARK: - 앱 기본 실행 시 최초로 표시되는 기본 기억섬 리스트
  // 앱을 처음 설치했거나 저장된 값이 없을 때 이 리스트를 사용해 초기 데이터 구성
  final List<MemoryItem> defaultItems = [
    MemoryItem(
      id: "1",
      title: "일본팸 ✈️",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory_seaotter2.png",
    ),
    MemoryItem(
      id: "2",
      title: "상콩즈 🐼",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory_seaotter1.png",
    ),
    MemoryItem(
      id: "3",
      title: "물개 달란트 🐬",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory_seaotter3.png",
    ),
    MemoryItem(
      id: "4",
      title: "칼챔",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/sample11.png",
    ),
    MemoryItem(
      id: "5",
      title: "울 애깅",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory/couple/couple.png",
    ),
    MemoryItem(
      id: "6",
      title: "술독 🍻",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory/alcohol/alcohol1.jpeg",
    ),
    MemoryItem(
      id: "7",
      title: "유러피안",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/memory/europe/prague1.jpeg",
    ),
  ];

  // MARK: - 저장된 기억섬 리스트 불러오기
  // 1. 저장된 데이터가 없으면 defaultItems 저장 후 반환
  // 2. 데이터가 비어 있으면 defaultItems로 복구
  // 3. 정상 데이터 있으면 그대로 반환
  Future<List<MemoryItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // 1) 저장된 값 자체가 없을 때
    if (jsonString == null || jsonString.isEmpty) {
      await saveItems(defaultItems);
      return List<MemoryItem>.from(defaultItems);
    }

    // 2) JSON 파싱 및 비어있는지 체크
    final List data = jsonDecode(jsonString);
    if (data.isEmpty) {
      await saveItems(defaultItems);
      return List<MemoryItem>.from(defaultItems);
    }

    // 3) 정상 데이터 반환
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
