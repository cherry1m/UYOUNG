import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/login.png', fit: BoxFit.cover),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCCFFFFFF)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    '기억이 머무는 곳,\nUYOUNG',
                    style: AppFontStyle.F6.copyWith(
                      color: const Color(0xFF202020),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '카카오 또는 구글 계정으로 로그인하고\n기억섬 초대를 바로 이어서 진행할 수 있어요.',
                    style: AppFontStyle.F4.copyWith(
                      color: const Color(0xFF6E6E73),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _LoginButton(
                    label: '카카오로 시작하기',
                    assetPath: 'assets/images/kakao_login.png',
                    backgroundColor: const Color(0xFFFEE500),
                    foregroundColor: const Color(0xFF191919),
                    onTap: authVm.isLoading
                        ? null
                        : () => _signIn(context, OAuthProvider.kakao),
                  ),
                  const SizedBox(height: 12),
                  _LoginButton(
                    label: '구글로 시작하기',
                    assetPath: 'assets/images/google_login.png',
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF202020),
                    borderColor: const Color(0xFFE1E3E8),
                    onTap: authVm.isLoading
                        ? null
                        : () => _signIn(context, OAuthProvider.google),
                  ),
                  const SizedBox(height: 12),
                  _LoginButton(
                    label: '애플 로그인 준비 중',
                    assetPath: 'assets/images/apple_login.png',
                    backgroundColor: const Color(0xFF111111),
                    foregroundColor: Colors.white70,
                    onTap: null,
                  ),
                  const SizedBox(height: 12),
                  if (authVm.isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context, OAuthProvider provider) async {
    try {
      await context.read<AuthViewModel>().signInWithSocial(provider);
    } catch (error) {
      if (!context.mounted) {
        debugPrint('[auth] login error after dispose: $error');
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 오류가 발생했어요: $error')),
      );
    }
  }
}

class _LoginButton extends StatelessWidget {
  final String label;
  final String assetPath;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const _LoginButton({
    required this.label,
    required this.assetPath,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: borderColor == null
              ? null
              : Border.all(color: borderColor!, width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),
            Image.asset(assetPath, width: 26, height: 26),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppFontStyle.M_18.copyWith(color: foregroundColor),
              ),
            ),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
