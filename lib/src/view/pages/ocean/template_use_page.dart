import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/ocean/template_photo_select_page.dart';

class TemplateUsePage extends StatelessWidget {
  const TemplateUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
      body: Column(
        children: [
          /// 🔹 템플릿 이미지 영역 (가운데)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Image.asset(
                'assets/images/template_2.png',
                width: 300,
                // fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 67),

          /// 🔹 하단 정보 영역
          Container(
            color: Colors.white,
            height: 115,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 왼쪽: 텍스트
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('푸르른', style: AppFontStyle.H6),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.g03,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '150회 사용됨',
                          style: AppFontStyle.M_14.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// 오른쪽: 사용하기 버튼
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TemplatePhotoSelectPage(
                              templatePreviewPath:
                                  'assets/images/template_2.png',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBlue,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        '사용하기',
                        style: AppFontStyle.H6.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
