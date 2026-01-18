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
        // 스티커 선택 영역
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
