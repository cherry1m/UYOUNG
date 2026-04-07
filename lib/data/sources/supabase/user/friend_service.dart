import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class FriendService {
  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  User get _currentUser {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('로그인이 필요합니다.');
    }
    return user;
  }

  Future<List<FriendUser>> fetchFriends() async {
    final friendRows = await _client
        .from('friends')
        .select('friend_id')
        .eq('user_id', _currentUser.id);

    final friendIds = (friendRows as List<dynamic>)
        .map((row) => (row as Map)['friend_id'] as String?)
        .whereType<String>()
        .toList();

    if (friendIds.isEmpty) {
      return const [];
    }

    final profiles = await _client
        .from('profiles')
        .select('id, nickname, avatar_url, user_code')
        .inFilter('id', friendIds);

    final profileById = {
      for (final row in profiles as List<dynamic>)
        (row as Map)['id'] as String: FriendUser.fromMap(
          Map<String, dynamic>.from(row),
        ),
    };

    return friendIds.map((id) => profileById[id]).whereType<FriendUser>().toList();
  }

  Future<void> addFriendByCode(String inputCode) async {
    await _client.rpc(
      'add_friend_by_code',
      params: {'input_code': inputCode.trim()},
    );
  }

  Future<void> addFriendDirect(String friendId) async {
    await _client.from('friends').insert({'friend_id': friendId});
  }
}
