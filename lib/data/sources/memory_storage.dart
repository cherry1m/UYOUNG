import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';

class MemoryStorage {
  // SharedPreferences에 사용할 key 값
  static const String _key = "memory_items";

  // MARK: 앱 기본 실행 시 최초로 표시되는 기본 기억섬 리스트
  // 앱을 처음 설치했거나 저장된 값이 없을 때 이 리스트를 사용해 초기 데이터를 구성한다.
  final List<MemoryItem> defaultItems = [
    MemoryItem(
      id: "1",
      title: "우.정.포.에.버",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/1.png",
    ),
    MemoryItem(
      id: "2",
      title: "오키나와 팸✈️",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/2.png",
    ),
    MemoryItem(
      id: "3",
      title: "전국 카페 투어☕",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/3.png",
    ),
    MemoryItem(
      id: "4",
      title: "인덕대 술 모임🍹",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/4.png",
    ),
    MemoryItem(
      id: "5",
      title: "한승하",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/5.png",
    ),
    MemoryItem(
      id: "6",
      title: "최보빈",
      isFavorite: false,
      isNotificationOn: true,
      imagePath: "assets/images/6.png",
    ),
  ];

  // MARK: - 저장된 기억섬 리스트를 불러오는 함수
  // SharedPreferences에서 JSON 문자열을 읽어와 MemoryItem 리스트로 변환해 반환한다.
  // 데이터가 존재하지 않으면 기본 리스트를 저장하고 그대로 반환한다.
  Future<List<MemoryItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // 1) 저장된 값 자체가 없을 때
    if (jsonString == null || jsonString.isEmpty) {
      await saveItems(defaultItems);
      return List<MemoryItem>.from(defaultItems);
    }

    // 2) 파싱했더니 리스트가 비어 있을 때 (빌드/클린 등으로 날아간 경우)
    final List data = jsonDecode(jsonString);
    if (data.isEmpty) {
      await saveItems(defaultItems);
      return List<MemoryItem>.from(defaultItems);
    }

    // 3) 정상적으로 데이터가 있을 때
    return data.map((e) => MemoryItem.fromMap(e)).toList();
  }

  // MARK: - 기억섬 리스트를 저장하는 함수
  // MemoryItem 리스트를 JSON 문자열로 변환한 뒤 SharedPreferences에 저장한다.
  Future<void> saveItems(List<MemoryItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(items.map((e) => e.toMap()).toList());
    await prefs.setString(_key, jsonString);
  }
}
