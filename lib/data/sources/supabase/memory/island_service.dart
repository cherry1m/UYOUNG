import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/memory/island_model.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
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

  Future<List<AppUserProfile>> fetchIslandMembers(String islandId) async {
    final memberRows = await _client
        .from('island_members')
        .select('user_id')
        .eq('island_id', islandId);

    final userIds = (memberRows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .map((row) => row['user_id'] as String?)
        .whereType<String>()
        .toList();

    if (userIds.isEmpty) {
      return const [];
    }

    final profileRows = await _client
        .from('profiles')
        .select('id, nickname, avatar_url, user_code, created_at')
        .inFilter('id', userIds);

    final profilesById = (profileRows as List<dynamic>)
        .map((row) => AppUserProfile.fromMap(Map<String, dynamic>.from(row as Map)))
        .fold<Map<String, AppUserProfile>>(
          <String, AppUserProfile>{},
          (map, profile) => map..[profile.id] = profile,
        );

    return userIds
        .map((userId) => profilesById[userId])
        .whereType<AppUserProfile>()
        .toList();
  }

  Future<void> inviteMembersToIsland({
    required String islandId,
    required List<String> selectedUserIds,
  }) async {
    if (selectedUserIds.isEmpty) {
      return;
    }

    await _client.rpc(
      'invite_members_to_island',
      params: {
        'target_island_id': islandId,
        'target_user_ids': selectedUserIds,
      },
    );
  }
}
