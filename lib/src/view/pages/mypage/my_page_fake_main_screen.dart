import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';
import 'package:uyoung/src/view/pages/mypage/friend_list_fake_page.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart';

/// ✅ 마이페이지 “이미지로 속이는” 화면 + 버튼(친구목록 / 조개이야기)
class MyPageFakeScreen extends StatelessWidget {
  const MyPageFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ✅ 버튼 위치 기준값 (이미지에 맞춰 조정)
    const double buttonTop = 450;
    const double buttonHeight = 90;
    final double buttonWidth = (w - 130) / 3; // 3등분

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                /// ✅ 배경 이미지 (마이페이지 스샷)
                Image.asset(
                  'assets/images/my_page_main.png',
                  width: w,
                  fit: BoxFit.fitWidth,
                ),

                if (kDebugMode)
                  Positioned(
                    top: 12,
                    right: 16,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () async {
                          await context.read<AuthViewModel>().signOut();
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                // =========================
                // ✅ 친구 목록 버튼
                Positioned(
                  top: buttonTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FriendListFakePage(),
                        ),
                      );
                    },
                  ),
                ),

                // ✅ 조개 이야기 버튼
                Positioned(
                  top: buttonTop,
                  left: 18 + buttonWidth,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShellStoryPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ 완전 투명 터치 영역
class _FakeTapArea extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;

  const _FakeTapArea({
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 투명이어도 터치 가능
      onTap: onTap,
      child: SizedBox(width: width, height: height),
    );
  }
}
