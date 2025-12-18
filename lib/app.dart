// lib/src/app/uyoung_app.dart
import 'package:flutter/material.dart';
import 'package:uyoung/src/view/common/navigation/uyoung_bottom_nav_bar.dart';
import 'package:uyoung/src/view/pages/home/home_main.dart';
import 'package:uyoung/src/view/pages/memory/memory_main_page.dart';
import 'package:uyoung/src/view/pages/calendar/calendar_main_page.dart';
import 'package:uyoung/src/view/pages/mypage/my_page_fake_main_screen.dart';
import 'package:uyoung/src/view/pages/ocean/ocean_note_main_page.dart';

class UyoungApp extends StatefulWidget {
  const UyoungApp({Key? key}) : super(key: key);

  @override
  State<UyoungApp> createState() => _UyoungAppState();
}

class _UyoungAppState extends State<UyoungApp> {
  // 기본 탭: 기억섬 (원하면 2로 바꿔서 캘린더부터 열어도 됨)
  int _currentIndex = 0;

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

// 임시 화면 – 나중에 실제 페이지로 교체
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
