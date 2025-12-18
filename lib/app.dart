import 'package:flutter/material.dart';
import 'package:uyoung/src/view/common/navigation/uyoung_bottom_nav_bar.dart';
import 'package:uyoung/src/view/pages/home/home_main.dart';
import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';
import 'package:uyoung/src/view/pages/calendar/calendar_main_page.dart';
import 'package:uyoung/src/view/pages/mypage/my_page_fake_main_screen.dart';
import 'package:uyoung/src/view/pages/ocean/ocean_note_main_page.dart';

class UyoungApp extends StatefulWidget {
  final int initialIndex;

  const UyoungApp({
    Key? key,
    this.initialIndex = 0, // 기본 탭
  }) : super(key: key);

  @override
  State<UyoungApp> createState() => _UyoungAppState();
}

class _UyoungAppState extends State<UyoungApp> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // ✅ 여기서 초기 탭 설정
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeMain(), // 0
            MemoryMainPage(), // 1 기억섬
            CalendarMainPage(), // 2 캘린더
            OceanNoteMainPage(), // 3 바다노트
            MyPageFakeScreen(), // 4
          ],
        ),
      ),
      bottomNavigationBar: UyoungBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// 임시 마이페이지
class _DummyPage extends StatelessWidget {
  final String title;

  const _DummyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }
}
