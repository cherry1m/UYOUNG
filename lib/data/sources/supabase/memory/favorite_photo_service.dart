import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/memory/favorite_photo_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class FavoritePhotoService {
  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  Future<List<FavoritePhoto>> getMyFavoritePhotos(String islandId) async {
    final response = await _client.rpc(
      'get_my_favorite_photos',
      params: {'target_island_id': islandId},
    );

    return (response as List<dynamic>)
        .map((row) => FavoritePhoto.fromMap(Map<String, dynamic>.from(row as Map)))
        .toList();
  }

  Future<bool> toggleFavoritePhoto({
    required String islandId,
    required String photoKey,
  }) async {
    final response = await _client.rpc(
      'toggle_favorite_photo',
      params: {
        'target_island_id': islandId,
        'target_photo_key': photoKey,
      },
    );

    return response == true;
  }
}
