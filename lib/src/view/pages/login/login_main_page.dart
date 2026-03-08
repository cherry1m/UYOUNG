import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart'; // 경로 확인 필요

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset('assets/images/login.png', fit: BoxFit.cover),
          ),

          // 로그인 버튼 영역
          Align(
            alignment: const Alignment(0, 0.4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _loginButton(
                  context,
                  'assets/images/kakao_login.png',
                  OAuthProvider.kakao,
                ),
                const SizedBox(width: 20),
                _loginButton(
                  context,
                  'assets/images/google_login.png',
                  OAuthProvider.google,
                ),
                const SizedBox(width: 20),
                _loginButton(
                  context,
                  'assets/images/apple_login.png',
                  OAuthProvider.apple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // context와 provider를 인자로 받도록 수정
  Widget _loginButton(
    BuildContext context,
    String assetPath,
    OAuthProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        // 버튼 클릭 시 해당 provider로 로그인 실행
        context.read<AuthViewModel>().signInWithSocial(provider);
      },
      child: Image.asset(assetPath, width: 60, height: 60),
    );
  }
}
