import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> signInWithGoogle() async {
    await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: signInWithGoogle,
          child: const Text("Google 로그인"),
        ),
      ),
    );
  }
}
