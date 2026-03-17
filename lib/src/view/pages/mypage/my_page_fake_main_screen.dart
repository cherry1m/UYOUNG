import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';
import 'package:uyoung/src/view/pages/mypage/friend_list_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/invite_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/pear_fake_page.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart';

class MyPageFakeScreen extends StatelessWidget {
  const MyPageFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    const double buttonTop = 450;
    const double buttonHeight = 90;
    final double buttonWidth = (w - 130) / 3;

    const double pearlTop = 365;
    const double pearlHeight = 58;

    const double inviteTop = 650;
    const double inviteHeight = 60;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
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
                Positioned(
                  top: pearlTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: w - 36,
                    height: pearlHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PearFakePage()),
                      );
                    },
                  ),
                ),
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
                Positioned(
                  top: inviteTop,
                  left: 18,
                  child: _FakeTapArea(
                    width: w - 36,
                    height: inviteHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InviteFakePage()),
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
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(width: width, height: height),
    );
  }
}
