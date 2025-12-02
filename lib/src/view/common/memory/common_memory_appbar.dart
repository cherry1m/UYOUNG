import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/member_inquiry_page.dart';

class MemoryCommonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const MemoryCommonAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      // MARK: - 타이틀 왼쪽 정렬
      title: Text(title, style: AppFontStyle.M_20, textAlign: TextAlign.left),

      centerTitle: false,

      // MARK: - 오른쪽 아이콘 3개 (기본 placeholder)
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/search.png', width: 22),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/check.png', width: 18),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberInquiryPage()),
            );
          },
          icon: Image.asset('assets/images/menu.png', width: 18),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
