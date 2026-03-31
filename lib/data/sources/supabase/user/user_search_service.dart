import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class UserSearchService {
  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  Future<List<InviteeUser>> searchUsers(String query) async {
    final response = await _client.rpc(
      'search_users',
      params: {'search_term': query.trim()},
    );

    return (response as List<dynamic>)
        .map((row) => InviteeUser.fromMap(Map<String, dynamic>.from(row as Map)))
        .toList();
  }
}
