import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/data/sources/memory/memory_storage.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

// MARK: - MemoryRepository
// 이 클래스는 ViewModel과 Storage 사이의 중간 계층이다.
// ViewModel은 Repository에 요청을 보내고,
// Repository는 Storage로부터 데이터를 로드하거나 저장하도록 전달한다.
// 구조적으로 확장성(예: API 연동 가능성)을 고려한 레이어이므로 그대로 유지하는 것이 좋다.

class MemoryRepository {
  // 실제 데이터 저장 및 불러오기를 담당하는 Storage 인스턴스.
  final MemoryStorage _storage = MemoryStorage();

  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }
    return Supabase.instance.client;
  }

  // MARK: - 데이터 불러오기
  // SharedPreferences에서 MemoryItem 리스트를 읽어와 반환한다.
  Future<List<MemoryItem>> loadItems() => _storage.loadItems();

  // MARK: - 데이터 저장
  // 변경된 MemoryItem 리스트를 SharedPreferences에 저장한다.
  Future<void> saveItems(List<MemoryItem> items) => _storage.saveItems(items);

  Future<List<InviteeUser>> searchUsers(String searchTerm) async {
    final response = await _client.rpc(
      'search_users',
      params: {'search_term': searchTerm},
    );

    final rows = (response as List<dynamic>)
        .map((row) => InviteeUser.fromMap(Map<String, dynamic>.from(row as Map)))
        .toList();

    return rows;
  }

  Future<String> uploadIslandBackground(XFile imageFile) async {
    final Uint8List bytes = await imageFile.readAsBytes();
    final originalName = imageFile.name.isEmpty ? 'background.jpg' : imageFile.name;
    final sanitizedName = originalName.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
    final path =
        'memory_islands/${DateTime.now().microsecondsSinceEpoch}_$sanitizedName';

    await _client.storage.from('island_backgrounds').uploadBinary(
      path,
      bytes,
      fileOptions: FileOptions(
        upsert: true,
        contentType: _contentTypeFor(sanitizedName),
      ),
    );

    return _client.storage.from('island_backgrounds').getPublicUrl(path);
  }

  Future<String> createIslandWithMembers({
    required String islandName,
    required String color,
    String? bgUrl,
    List<String> inviteeIds = const [],
  }) async {
    final response = await _client.rpc(
      'create_island_with_members',
      params: {
        'island_name': islandName,
        'color': color,
        'bg_url': bgUrl,
        'invitee_ids': inviteeIds,
      },
    );

    return response as String;
  }

  String _contentTypeFor(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }
}
