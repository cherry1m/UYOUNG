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
      await _auth.signInWithOAuth(
        provider,
        redirectTo: 'uyoung://login-callback',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
