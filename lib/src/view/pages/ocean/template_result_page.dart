import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/src/view/pages/ocean/template_save_complete_page.dart'; // ✅ 여기! (RootPage가 app.dart에 있을 때)

class TemplateResultPage extends StatelessWidget {
  const TemplateResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TemplateSaveCompletePage(),
                ),
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
