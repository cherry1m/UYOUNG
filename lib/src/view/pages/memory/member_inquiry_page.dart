import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class MemberInquiryPage extends StatelessWidget {
  final String albumName;
  final String albumImage; // 선택된 앨범 이미지 경로 (asset or network)

  const MemberInquiryPage({
    super.key,
    required this.albumName,
    required this.albumImage,
  });

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
            icon: Image.asset("assets/images/alert.png", width: 22),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: IconButton(
              icon: Image.asset("assets/images/setting.png", width: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          children: [
            // 선택된 앨범 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                albumImage,
                width: 200,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // 선택된 앨범명
            Text(
              albumName,
              style: AppFontStyle.M_22.copyWith(letterSpacing: 2),
            ),
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
                  InkWell(
                    onTap: () {
                      print("캘린더 클릭");
                    },
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/calendar.png",
                        width: 26,
                      ),
                      title: Text("캘린더", style: AppFontStyle.M_16),
                    ),
                  ),
                  Container(height: 1, color: const Color(0xFFE6E6E6)),
                  InkWell(
                    onTap: () {
                      print("조개 이야기 클릭");
                    },
                    child: ListTile(
                      leading: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFD9D9D9),
                        ),
                      ),
                      title: Text("조개 이야기", style: AppFontStyle.M_16),
                    ),
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

                  _member("이윤서", "assets/images/user1.png"),
                  _member("최보빈", "assets/images/user2.png"),
                  _member("한승하", "assets/images/user3.png"),
                  _member("김가영", "assets/images/user4.png"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 기억섬 나가기 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
