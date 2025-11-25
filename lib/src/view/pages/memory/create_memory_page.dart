import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:uyoung/src/view/pages/memory/select_member_page.dart';

class CreateMemoryPage extends StatefulWidget {
  const CreateMemoryPage({super.key});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // MARK: - Image Picker
  Future<void> _pickImage() async {
    debugPrint("gallery button clicked");

    if (!kIsWeb && Platform.isIOS && !Platform.isAndroid) {
      debugPrint("iOS simulator: gallery disabled");
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      debugPrint(">>> 선택된 파일 경로: ${file.path}");
    } else {
      debugPrint(">>> 선택 취소");
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MARK: - 상단 placeholder + 뒤로가기 + 갤러리 버튼
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  color: const Color(0xFFE6E6E6),
                ),

                // 뒤로가기 버튼 & 타이틀
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 44,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 115),
                            child: Text(
                              "기억섬 만들기",
                              style: AppFontStyle.M_20.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ),

                // MARK: 갤러리 버튼
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: const Icon(
                        Icons.photo_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // MARK: - 내용 영역
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("어떤 기억을 담을\n섬을 만들까요?", style: AppFontStyle.M_26),
                  const SizedBox(height: 8),
                  Text(
                    "바다 위에 새로운 섬이 떠오르고 있어요.",
                    style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SelectMemberPage(),
                            ),
                          );
                        },
                        child: _addProfileButton(),
                      ),
                      const SizedBox(width: 16),
                      _selectedProfile("최보빈"),
                      const SizedBox(width: 16),
                      _selectedProfile("한승하"),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // MARK: 기억섬 이름
                  Text("기억섬 이름", style: AppFontStyle.M_14),
                  const SizedBox(height: 8),

                  Stack(
                    children: [
                      // 밑줄 (디바이더)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 1,
                            color: _titleController.text.isEmpty
                                ? Colors
                                      .grey // 텍스트 없을 때 회색
                                : const Color(0xFF6EA8EB), // 텍스트 존재하면 메인 파란색
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              focusNode: _focusNode,
                              onChanged: (_) => setState(() {}), // 변경사항 감지
                              style: AppFontStyle.M_16.copyWith(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: "최보빈, 한승하",
                                hintStyle: AppFontStyle.M_16.copyWith(
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                              ),
                            ),
                          ),

                          // 글자 수 카운트
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              "${_titleController.text.length}/@@",
                              style: AppFontStyle.M_14.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF6EA8EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "기억섬 만들기",
                        style: AppFontStyle.M_18.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - 프로필 추가 (+) 원형 버튼
  Widget _addProfileButton() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
      ),
      child: const Icon(Icons.add, color: Color(0xFF4880ED), size: 28),
    );
  }

  // MARK: - 선택된 프로필
  Widget _selectedProfile(String name) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6EA8EB),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(name, style: AppFontStyle.M_14),
      ],
    );
  }
}
