import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class FriendAddByCodePage extends StatelessWidget {
  const FriendAddByCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '코드로 친구 추가',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: Center(
        child: Text(
          '다음 단계에서 구현 예정이에요.',
          style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
        ),
      ),
    );
  }
}
