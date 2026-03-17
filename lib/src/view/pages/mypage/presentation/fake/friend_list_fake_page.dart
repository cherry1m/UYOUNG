import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/image_data.dart';
import 'friend_profile_fake_page.dart';

class FriendListFakePage extends StatelessWidget {
  const FriendListFakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              // ✅ 배경 이미지 터치 방해 방지
              AbsorbPointer(
                absorbing: true,
                child: Image.asset(
                  ImagePath.friendList,
                  width: w,
                  fit: BoxFit.fitWidth,
                ),
              ),

              // ✅ 뒤로가기
              Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.transparent,
                  ),
                ),
              ),

              // ✅ 첫번째 친구 프로필
              Positioned(
                top: 150,
                left: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FriendProfileFakePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: w,
                    height: 90,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
