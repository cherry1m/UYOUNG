import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/ocean/ocean_note_main_page.dart';

class TemplateResultPage extends StatelessWidget {
  const TemplateResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,

        /// 👉 저장하기 버튼
        actions: [
          TextButton(
            onPressed: () {
              // OceanNote 메인으로 이동 (뒤 스택 정리하고 싶으면 pushAndRemoveUntil)
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const OceanNoteMainPage()),
                (route) => false,
              );
            },
            child: Text(
              '저장하기',
              style: AppFontStyle.S8.copyWith(color: AppColors.black),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 18,
              top: 20,
              child: SizedBox(
                width: 353,
                height: 629,
                child: Image.asset(
                  'assets/images/temp_result.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
