import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/calendar/memory_island_list.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';

class OceanNoteMainPage extends StatelessWidget {
  const OceanNoteMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 바다노트에서 사용할 기본 기억섬 리스트
    final List<MemoryIsland> islands = defaultMemoryIslands;

    // 아직 노트 개수는 따로 없으니 0으로 고정 (나중에 실제 노트 데이터랑 연동)
    const int totalNoteCount = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 새 바다노트 작성 화면으로 이동
        },
        backgroundColor: AppColors.mainBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.note_add_outlined, color: Colors.white),
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

              // 앨범 카드들 (최근항목 + 기억섬 리스트)
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 16,
                    children: [
                      // 1) 최근항목 고정 카드
                      _OceanAlbumCard(
                        title: '최근항목',
                        count: totalNoteCount,
                        isRecent: true,
                        onTap: () {
                          // TODO: 전체/최근 바다노트 리스트 화면으로 이동
                        },
                      ),

                      // 2) 기억섬별 앨범 카드
                      for (final island in islands)
                        _OceanAlbumCard(
                          title: island.name,
                          count: 0, // 🔥 나중에 island.noteCount 등으로 교체 예정
                          onTap: () {
                            // TODO: 이 기억섬에 해당하는 바다노트 리스트로 이동
                            // Navigator.push(... OceanNoteListPage(island: island));
                          },
                        ),
                    ],
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

/// 앨범 카드 위젯
class _OceanAlbumCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  /// '최근항목' 카드 여부
  final bool isRecent;

  const _OceanAlbumCard({
    required this.title,
    required this.count,
    required this.onTap,
    this.isRecent = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      // 카드 전체 너비 112
      child: SizedBox(
        width: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일 박스 112x112, radius 18
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: AppColors.mainBlue,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 8),

            // 앨범 이름 (색 점은 나중에 필요 없으면 빼면 됨)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppFontStyle.M_16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),

            Text(
              '$count개',
              style: AppFontStyle.S9.copyWith(color: AppColors.g03),
            ),
          ],
        ),
      ),
    );
  }
}
