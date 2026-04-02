import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/attendance/attendance_model.dart';
import 'package:uyoung/data/model/attendance/attendance_result_model.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';

class AttendanceService {
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

  Future<AttendanceResult> checkInAndDraw() async {
    final response = await _client.rpc('daily_check_in_and_draw');
    return AttendanceResult.fromRpc(response);
  }

  Future<List<AttendanceLogEntry>> fetchAttendanceLogs() async {
    final response = await _client
        .from('attendance_logs')
        .select('reward_item')
        .eq('user_id', _currentUser.id)
        .limit(7);

    final rows = List<Map<String, dynamic>>.from(response);
    return rows.map(AttendanceLogEntry.fromMap).toList();
  }
}
