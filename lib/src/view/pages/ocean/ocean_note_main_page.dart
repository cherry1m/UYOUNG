import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/ocean/template_main_page.dart';

class OceanNoteMainPage extends StatelessWidget {
  const OceanNoteMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const TemplateMainPage()));
        },
        backgroundColor: AppColors.mainBlue,
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/images/template_plus.png',
          width: 24,
          height: 24,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 타이틀 + 더보기 아이콘
              Row(
                children: [
                  Text('바다노트', style: AppFontStyle.H5),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // TODO: 정렬/필터/설정 바텀시트 등
                    },
                    icon: const Icon(Icons.more_horiz, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ✅ 카드 2개만 고정
              Wrap(
                spacing: 12,
                runSpacing: 16,
                children: [
                  _OceanAlbumCard(
                    title: '최근항목',
                    count: 3, // ← 하드코딩
                    thumbnailPath:
                        'assets/images/ocean_recent.png', // ← 너 이미지로 바꿔
                    onTap: () {},
                  ),
                  _OceanAlbumCard(
                    title: '상콩즈 🐼',
                    count: 1, // ← 하드코딩
                    thumbnailPath:
                        'assets/images/ocean_shang.png', // ← 너 이미지로 바꿔
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 앨범 카드 위젯 (썸네일 이미지까지 하드코딩 가능)
class _OceanAlbumCard extends StatelessWidget {
  final String title;
  final int count;
  final String? thumbnailPath;
  final VoidCallback onTap;

  const _OceanAlbumCard({
    required this.title,
    required this.count,
    required this.onTap,
    this.thumbnailPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일 박스 112x112, radius 18
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 112,
                height: 112,
                child: thumbnailPath == null
                    ? Container(color: AppColors.mainBlue)
                    : Image.asset(thumbnailPath!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              title,
              style: AppFontStyle.M_16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),

            Text(
              '$count개',
              style: AppFontStyle.S9.copyWith(color: AppColors.gray_12),
            ),
          ],
        ),
      ),
    );
  }
}
