import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/user/app_notification_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class NotificationService {
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

  Future<List<AppNotification>> fetchNotifications() async {
    final response = await _client
        .from('notifications')
        .select('*')
        .eq('user_id', _currentUser.id)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map(
          (row) => AppNotification.fromMap(Map<String, dynamic>.from(row as Map)),
        )
        .toList();
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId)
        .eq('user_id', _currentUser.id);
  }

  Future<void> markAllNotificationsAsRead() async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('user_id', _currentUser.id)
        .eq('is_read', false);
  }
}
