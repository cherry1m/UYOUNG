import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 소셜 로그인 로직
  Future<void> signInWithSocial(OAuthProvider provider) async {
    _isLoading = true;
    notifyListeners();

    try {
      // redirectTo는 로그인이 완료된 후 다시 앱으로 돌아오기 위한 딥링크 주소 (추후 설정 필요)
      await _supabase.auth.signInWithOAuth(
        provider,
        redirectTo: 'uyoung://login-callback',
      );
    } catch (e) {
      debugPrint('로그인 에러: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }
}
