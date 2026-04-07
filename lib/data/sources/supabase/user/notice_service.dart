import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/notice_item_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class NoticeService {
  static const _table = 'notices';

  SupabaseClient get _client {
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Supabase 설정이 없습니다. --dart-define=SUPABASE_URL=... 과 '
        '--dart-define=SUPABASE_ANON_KEY=... 를 추가하세요.',
      );
    }

    return Supabase.instance.client;
  }

  Future<List<NoticeItem>> fetchNotices() async {
    final response = await _client
        .from(_table)
        .select('*')
        .order('is_important', ascending: false)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((row) => NoticeItem.fromMap(Map<String, dynamic>.from(row as Map)))
        .toList();
  }

  Future<NoticeItem> fetchNoticeDetail(String noticeId) async {
    final response = await _client
        .from(_table)
        .select('*')
        .eq('id', noticeId)
        .single();

    return NoticeItem.fromMap(Map<String, dynamic>.from(response));
  }
}
