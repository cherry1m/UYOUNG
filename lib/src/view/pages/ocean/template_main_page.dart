import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/ocean/template_use_page.dart';

class TemplateMainPage extends StatelessWidget {
  const TemplateMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('템플릿', style: AppFontStyle.S5),
      ),

      body: Column(
        children: [
          _CategoryTabBar(),
          const SizedBox(height: 12),
          Expanded(child: _TemplateGrid()),
        ],
      ),
    );
  }
}

class _CategoryTabBar extends StatelessWidget {
  final List<String> tabs = ['인기', '즐겨찾기', '데일리', '빈티지', '여행'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 카테고리 텍스트 영역
        SizedBox(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabs.length, (index) {
              final isSelected = index == 0; // 인기 고정 선택

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tabs[index],
                    style: AppFontStyle.S6.copyWith(
                      color: isSelected
                          ? AppColors.mainBlue
                          : const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 선택 인디케이터
                  Container(
                    width: 24,
                    height: 2,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.mainBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),

        // 🔽 하단 구분선
        Container(height: 1, color: AppColors.bg02),
      ],
    );
  }
}

class _TemplateGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return _TemplateCard(
          imagePath: 'assets/images/template_${index + 1}.png',
        );
      },
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String imagePath;

  const _TemplateCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        Positioned(
          bottom: 12,
          right: 12,
          child: SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TemplateUsePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                elevation: 0,
              ),
              child: Text(
                '사용하기',
                style: AppFontStyle.H7.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
