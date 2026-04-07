import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/user_asset_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class UserAssetService {
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

  Future<UserAsset> fetchUserAsset() async {
    final response = await _client
        .from('user_assets')
        .select('pearl_count')
        .eq('user_id', _currentUser.id)
        .maybeSingle();

    if (response == null) {
      return const UserAsset(pearlCount: 0);
    }

    return UserAsset.fromMap(Map<String, dynamic>.from(response));
  }
}
