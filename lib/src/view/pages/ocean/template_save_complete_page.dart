import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/app.dart';

class TemplateSaveCompletePage extends StatelessWidget {
  const TemplateSaveCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text('저장완료', style: AppFontStyle.H6),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/save_home.png',
              width: 44,
              height: 44,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const UyoungApp(initialIndex: 0),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// 결과 이미지
            SizedBox(
              width: 300,
              height: 535,
              child: Image.asset(
                'assets/images/temp_result.png',
                fit: BoxFit.fill,
              ),
            ),

            const Spacer(),

            /// 버튼 영역
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _SaveButton(
                      label: '앨범에 저장',
                      onTap: () {
                        // TODO: 바다노트 저장 로직
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UyoungApp(initialIndex: 3),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SaveButton(
                      label: '공유하기',
                      onTap: () {
                        // TODO: 앨범 저장 로직
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UyoungApp(initialIndex: 3),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SaveButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.mainBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: AppFontStyle.H7.copyWith(color: AppColors.mainBlue),
        ),
      ),
    );
  }
}
