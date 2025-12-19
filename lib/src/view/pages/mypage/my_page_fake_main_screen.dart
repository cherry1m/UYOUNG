import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';

/// ✅ 마이페이지 “이미지로 속이는” 화면 + 버튼 3개(친구목록/조개이야기/상점)
class MyPageFakeScreen extends StatelessWidget {
  const MyPageFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ✅ 디버그용(버튼 영역 보이게). 위치 맞추면 false로 바꿔!
    const bool debugHitAreas = true;

    // ✅ 네가 잡아둔 기준 값(필요하면 조정)
    const double buttonTop = 450; // ← 여기만 위아래로 미세조정하면 됨
    const double buttonHeight = 90; // ← 버튼 높이(필요하면 조정)
    final double buttonWidth = (w - 130) / 3; // 좌우 padding 18*2 기준 3등분

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                // ✅ 배경 이미지(마이페이지 스샷)
                Image.asset(
                  'assets/images/my_page_main.png',
                  width: w,
                  fit: BoxFit.fitWidth,
                ),

                // =========================
                // ✅ 친구 목록 버튼
                Positioned(
                  top: buttonTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: buttonWidth,
                    height: buttonHeight,
                    debug: debugHitAreas,
                    debugColor: Colors.red,
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
                    debug: debugHitAreas,
                    debugColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShellStoryPage(),
                        ), // ✅ 여기!
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

/// ✅ 공용 “투명 버튼” 위젯
class _FakeTapArea extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;

  final bool debug;
  final Color debugColor;

  const _FakeTapArea({
    required this.width,
    required this.height,
    required this.onTap,
    required this.debug,
    required this.debugColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // ✅ 투명이어도 터치 잘 됨
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        color: debug ? debugColor.withOpacity(0.25) : Colors.transparent,
      ),
    );
  }
}

/// ✅ 친구목록 “이미지로 속이는” 페이지
class FriendListFakePage extends StatelessWidget {
  const FriendListFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/friend_list.png',
              width: width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
