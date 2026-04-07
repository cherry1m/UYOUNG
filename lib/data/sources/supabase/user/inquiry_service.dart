import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/inquiry_item_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class InquiryService {
  static const _table = 'inquiries';

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

  Future<List<InquiryItem>> fetchMyInquiries() async {
    final response = await _client
        .from(_table)
        .select('title, created_at, status, answer')
        .eq('user_id', _currentUser.id)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((row) => InquiryItem.fromMap(Map<String, dynamic>.from(row as Map)))
        .toList();
  }
}
