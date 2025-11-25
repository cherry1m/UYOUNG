import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class PhotoDetailPage extends StatelessWidget {
  final String imagePath; // 전달받은 이미지 경로

  const PhotoDetailPage({
    super.key,
    required this.imagePath, // 생성자에서 전달받음
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _body(context),
      bottomNavigationBar: _bottomInputField(),
    );
  }

  // MARK: - 상단 앱바
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      // 뒤로가기 버튼
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),

      centerTitle: true,

      // 주소 + 날짜
      title: Column(
        children: [
          Text("서울특별시 월계 2동", style: AppFontStyle.M_18),
          const SizedBox(height: 2),
          Text(
            "2025년 10월 16일 오후 3:38",
            style: AppFontStyle.M_12.copyWith(color: Colors.grey),
          ),
        ],
      ),

      // 다운로드 + 메뉴 버튼
      actions: [
        GestureDetector(
          onTap: () {
            // 다운로드 로직
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image(
              image: AssetImage("assets/images/download.png"),
              width: 42,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // 메뉴 호출 로직
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Image(
              image: AssetImage("assets/images/menu.png"),
              width: 22,
            ),
          ),
        ),
      ],
    );
  }

  // MARK: - 본문 (사진 + 업로드 정보)
  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // MARK: 큰 사진 영역
          GestureDetector(
            onTap: () {
              // 이미지 클릭 시 동작
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: double.infinity,
                height: 530, // 요청한 높이
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath), // ← 전달받은 경로 적용!
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // MARK: 업로드 정보
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage("assets/images/profile1.png"),
                ),
                const SizedBox(width: 10),
                Text("윤채림 업로드", style: AppFontStyle.M_16),
              ],
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }

  // MARK: - 하단 입력창
  Widget _bottomInputField() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: Row(
          children: [
            // MARK: Rounded 별표 버튼
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6EA8EB), width: 1.6),
              ),
              child: const Center(
                child: Icon(
                  Icons.star_border,
                  color: Color(0xFF6EA8EB),
                  size: 26,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // MARK: 둥근 입력 컨테이너
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF6EA8EB),
                    width: 1.4,
                  ),
                ),
                child: Row(
                  children: [
                    // 이모지 아이콘
                    Image(
                      image: const AssetImage("assets/images/emo.png"),
                      width: 26,
                    ),
                    const SizedBox(width: 8),

                    // 텍스트
                    Expanded(
                      child: Text(
                        "느끼는 감정을 적어 주세요!",
                        style: AppFontStyle.M_16.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
