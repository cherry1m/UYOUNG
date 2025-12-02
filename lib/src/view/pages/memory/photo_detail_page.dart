import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class PhotoDetailPage extends StatelessWidget {
  final String imagePath;

  PhotoDetailPage({super.key, required this.imagePath});

  final double _popupWidth = 220;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _body(context),
      bottomNavigationBar: _bottomInputField(),
    );
  }

  // MARK: 상단 AppBar
  AppBar _appBar(BuildContext context) {
    final GlobalKey moreKey = GlobalKey();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Image(
            image: const AssetImage("assets/images/download.png"),
            width: 42,
          ),
        ),

        GestureDetector(
          key: moreKey,
          onTap: () => _showMorePopup(context, moreKey),
          child: const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Image(
              image: AssetImage("assets/images/more.png"),
              width: 22,
            ),
          ),
        ),
      ],
    );
  }

  // MARK: 더보기 아이콘 클릭 시 호출되는 팝업
  void _showMorePopup(BuildContext context, GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenWidth = MediaQuery.of(context).size.width;

    double left = position.dx - (_popupWidth - size.width);

    if (left < 16) left = 16;
    if (left + _popupWidth > screenWidth) {
      left = screenWidth - _popupWidth - 16;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      barrierDismissible: true,
      builder: (_) {
        return Stack(
          children: [
            Positioned(
              left: left,
              top: position.dy,
              //+ size.height,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: _popupWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _popupItem(
                        imagePath: "assets/images/date.png",
                        label: "날짜 및 시간 조정",
                        onTap: () => Navigator.pop(context),
                      ),

                      _divider(),

                      _popupItem(
                        imagePath: "assets/images/location.png",
                        label: "위치 조정",
                        onTap: () => Navigator.pop(context),
                      ),

                      _divider(),

                      _popupItem(
                        imagePath: "assets/images/delete.png",
                        label: "삭제하기",
                        color: const Color(0xFFE34B32),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // MARK: 팝업 아이템 UI
  Widget _popupItem({
    required String imagePath, // ← 아이콘 대신 이미지 경로
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.asset(imagePath, width: 20, height: 20),
            const SizedBox(width: 12),
            Text(label, style: AppFontStyle.M_16.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(height: 1, color: const Color(0xFFE6E6E6));

  // MARK: 본문 이미지 및 업로드 한 사용자 이름 출력
  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              height: 530,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
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

  // MARK: 하단 댓글 입력 필드
  Widget _bottomInputField() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: Row(
          children: [
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
                    Image(
                      image: const AssetImage("assets/images/emo.png"),
                      width: 26,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "느끼는 감정을 적어 주세요!",
                          hintStyle: AppFontStyle.M_16.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        style: AppFontStyle.M_16.copyWith(color: Colors.black),
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
