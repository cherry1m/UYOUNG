import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/member_inquiry_page.dart';

class MemoryCommonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const MemoryCommonAppBar({super.key, required this.title});

  // MARK: - AppBar 전체 높이 축소 (기존 56 → 48)
  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      // MARK: - 타이틀 왼쪽 정렬
      title: Text(title, style: AppFontStyle.H5),
      centerTitle: false,

      // MARK: - 내부 여백도 함께 축소
      titleSpacing: 12,

      // MARK: - 오른쪽 아이콘들
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Image.asset('assets/images/search.png', width: 20),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: Image.asset('assets/images/check.png', width: 16),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberInquiryPage()),
            );
          },
          icon: Image.asset('assets/images/menu.png', width: 16),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}
