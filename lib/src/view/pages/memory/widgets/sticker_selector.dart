import 'package:flutter/material.dart';

class StickerSelector extends StatelessWidget {
  final String? selectedSticker;
  final Function(String) onSelect;
  final VoidCallback onRemove;

  const StickerSelector({
    super.key,
    required this.selectedSticker,
    required this.onSelect,
    required this.onRemove,
  });

  static const List<String> _stickers = [
    "assets/images/angry.png",
    "assets/images/happy.png",
    "assets/images/laugh.png",
    "assets/images/shame.png",
    "assets/images/sad.png",
    "assets/images/ttiyong.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ───── 선택된 스티커 미리보기
        if (selectedSticker != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 96, // ⬅️ 크기 키움
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45), // ⬅️ 검정 배경만
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Image.asset(selectedSticker!, width: 64, height: 64),
                  ),
                ),

                /// X 버튼
                Positioned(
                  top: -6,
                  right: -6,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        /// ───── 스티커 선택 영역 (테두리 1개)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3E3E3), width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _stickers.map((path) {
              return GestureDetector(
                onTap: () => onSelect(path),
                child: Image.asset(path, width: 56, height: 60),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
