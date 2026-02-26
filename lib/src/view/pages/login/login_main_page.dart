import 'package:flutter/material.dart';

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

          // 로그인 버튼 영역 (중앙보다 살짝 아래)
          Align(
            alignment: const Alignment(0, 0.4), // 0 = 중앙, 0.4 = 살짝 아래
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _loginButton('assets/images/kakao_login.png'),
                const SizedBox(width: 20),
                _loginButton('assets/images/google_login.png'),
                const SizedBox(width: 20),
                _loginButton('assets/images/apple_login.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(String assetPath) {
    return GestureDetector(
      onTap: () {
        // TODO: 로그인 로직 연결
      },
      child: Image.asset(assetPath, width: 60, height: 60),
    );
  }
}
