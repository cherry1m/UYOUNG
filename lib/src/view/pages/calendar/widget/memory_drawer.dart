import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';

class MemoryIslandDrawer extends StatelessWidget {
  final List<MemoryIsland> islands;
  final void Function(int index, bool value) onChanged;

  const MemoryIslandDrawer({
    Key? key,
    required this.islands,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 312,
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 헤더: "내 기억섬" + 우측 설정 아이콘
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text('내 기억섬', style: AppFontStyle.M_18),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      // TODO: 기억섬 관리/설정 화면
                    },
                    icon: ImageData(
                      path: ImagePath.setting,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),

            // 구분선
            Container(
              height: 1,
              color: const Color(0xFFE9E9ED),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),

            const SizedBox(height: 16),

            // 체크리스트
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: islands.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final island = islands[index];

                  return GestureDetector(
                    onTap: () => onChanged(index, !island.isSelected),
                    child: Row(
                      children: [
                        // 체크박스
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: island.isSelected
                                  ? Colors.transparent
                                  : const Color(0xFFD2D2D7),
                              width: 1.5,
                            ),
                            color: island.isSelected
                                ? island.color
                                : Colors.white,
                          ),
                          child: island.isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 10),

                        // 이름 텍스트
                        Expanded(
                          child: Text(
                            island.name,
                            style: AppFontStyle.M_16.copyWith(
                              color: AppColors.gray_17,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
