import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/model/home/attendance_result_model.dart';
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

  Future<AttendanceResult> checkInAndDraw() async {
    final response = await _client.rpc('daily_check_in_and_draw');
    return AttendanceResult.fromRpc(response);
  }
}
