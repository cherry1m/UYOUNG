import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class LocationSheet extends StatefulWidget {
  const LocationSheet({super.key});

  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _hasKeyword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ───────── 상단 액션 바 ─────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("취소", style: AppFontStyle.H7),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("저장", style: AppFontStyle.H7),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ───────── 원본 / 조정 ─────────
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _infoRow("원본", "서울특별시 월계2동", isDisabled: true),
                const Divider(height: 1),
                _infoRow("조정", "서울특별시 월계2동", isDisabled: false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ───────── 검색창 ─────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: Color(0xFF999999)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _hasKeyword = value.isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "새로운 위치 입력",
                      border: InputBorder.none,
                    ),
                    style: AppFontStyle.S8,
                  ),
                ),
                if (_hasKeyword)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      setState(() => _hasKeyword = false);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// ───────── 검색 결과 리스트 ─────────
          if (_hasKeyword)
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: Color(0xFFEDEDED)),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("한강진역", style: AppFontStyle.H7),
                        const SizedBox(height: 4),
                        Text(
                          "대한민국 서울특별시 용산구 한남동 728-22,043",
                          style: AppFontStyle.S8.copyWith(
                            color: const Color(0xFF888888),
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
    );
  }

  Widget _infoRow(String title, String value, {required bool isDisabled}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppFontStyle.S8),
          Text(
            value,
            style: AppFontStyle.S8.copyWith(
              color: isDisabled
                  ? const Color(0xFFB0B0B0)
                  : const Color(0xFF222222),
            ),
          ),
        ],
      ),
    );
  }
}
