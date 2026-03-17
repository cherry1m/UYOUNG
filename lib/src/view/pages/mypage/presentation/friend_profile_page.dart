import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class FriendProfilePage extends StatelessWidget {
  final String name;
  final String imagePath;

  const FriendProfilePage({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 28),
            SizedBox(
              height: 250,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 210,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              name,
              style: AppFontStyle.F2.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: 134,
              height: 48,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.b02,
                  foregroundColor: Colors.white,
                  textStyle: AppFontStyle.H7.copyWith(color: Colors.white),
                ),
                child: const Text('놀러가기'),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '친구 삭제하기',
                  style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
