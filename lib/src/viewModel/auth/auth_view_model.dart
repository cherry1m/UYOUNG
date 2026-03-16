import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final GoTrueClient _auth = Supabase.instance.client.auth;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> signInWithSocial(OAuthProvider provider) async {
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('[auth] start OAuth login: $provider');
      await _auth.signInWithOAuth(
        provider,
        redirectTo: 'uyoung://login-callback',
        authScreenLaunchMode: LaunchMode.externalApplication,
      );
      debugPrint('[auth] OAuth browser launched: $provider');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint('[auth] signed out');
    notifyListeners();
  }
}
