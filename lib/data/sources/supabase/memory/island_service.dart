import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/memory/island_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class IslandService {
  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  Future<IslandModel?> fetchIsland(String islandId) async {
    final response = await _client
        .from('islands')
        .select('id, name, owner_id')
        .eq('id', islandId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return IslandModel.fromMap(Map<String, dynamic>.from(response));
  }

  Future<List<IslandMemberModel>> fetchIslandMembers(String islandId) async {
    final response = await _client
        .from('island_members')
        .select('user_id, profiles!user_id(id, nickname, avatar_url)')
        .eq('island_id', islandId);

    return (response as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .map((row) => row['profiles'])
        .whereType<Map>()
        .map((profile) => IslandMemberModel.fromProfileMap(
              Map<String, dynamic>.from(profile),
            ))
        .toList();
  }
}
