import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/calendar/calendar_main_page.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';

class MemberInquiryPage extends StatelessWidget {
  const MemberInquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/alert.png", width: 25),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: IconButton(
              icon: Image.asset("assets/images/setting.png", width: 30),
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          children: [
            // 프로필 박스
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                "assets/images/memory_seaotter1.png",
                width: 200,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text("상콩즈 🐼", style: AppFontStyle.M_22.copyWith(letterSpacing: 2)),
            const SizedBox(height: 18),

            // 캘린더 & 조개 이야기
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: ImageData(path: ImagePath.calendarOn, width: 30),
                    title: Text("캘린더", style: AppFontStyle.S7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CalendarMainPage()),
                      );
                    },
                  ),
                  Container(height: 1, color: const Color(0xFFE6E6E6)),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/shell_content.png",
                      width: 45,
                    ),
                    title: Text("조개 이야기", style: AppFontStyle.S7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShellStoryPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 버블 메이트
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("버블 메이트 4", style: AppFontStyle.M_16),
                  const SizedBox(height: 8),

                  // 초대하기
                  ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Icon(Icons.add, size: 22),
                    ),
                    title: Text("초대하기", style: AppFontStyle.M_16),
                    onTap: () {},
                  ),

                  _member("윤채림", "assets/images/yoon_profile.png"),
                  _member("이윤서", "assets/images/lee_profile.png"),
                  _member("조성은", "assets/images/cho_profile.png"),
                  _member("최보빈", "assets/images/choi_profile.png"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 나가기 버튼
            Center(
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE6E6E6), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // 왼쪽 정렬 시에 컨테이너 작아지는 문제, 가운데 정렬 시에 문제 X
                    children: [
                      Text(
                        "기억섬 나가기",
                        style: AppFontStyle.M_16.copyWith(
                          color: const Color(0xFFE4533A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _member(String name, String image) {
    return ListTile(
      leading: CircleAvatar(radius: 18, backgroundImage: AssetImage(image)),
      title: Text(name, style: AppFontStyle.M_16),
      onTap: () {},
    );
  }
}
