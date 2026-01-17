import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/widgets/comment_sheet.dart';
import 'package:uyoung/src/view/pages/memory/widgets/sticker_selector.dart';

class CommentInputBar extends StatefulWidget {
  final String uploaderProfile;

  // 부모 상태(사진 페이지)에서 내려주는 값/이벤트
  final String? selectedSticker;
  final ValueChanged<String> onStickerSelected;
  final VoidCallback onStickerRemoved;
  final VoidCallback onSend;

  const CommentInputBar({
    super.key,
    required this.uploaderProfile,
    required this.selectedSticker,
    required this.onStickerSelected,
    required this.onStickerRemoved,
    required this.onSend,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  bool _isInputMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
        constraints: const BoxConstraints(minHeight: 160),
        child: _isInputMode ? _commentInputUI() : _defaultButtons(),
      ),
    );
  }

  // 기본 상태 (3개 버튼)
  Widget _defaultButtons() {
    return Row(
      children: [
        _circleButton(
          image: "assets/images/smile.png",
          onTap: () {
            setState(() => _isInputMode = true);
          },
        ),
        const SizedBox(width: 6),
        _circleButton(
          image: "assets/images/comment.png",
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return Container(
                  height: 750,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: CommentSheet(),
                );
              },
            );
          },
        ),
        const SizedBox(width: 6),
        _circleButton(image: "assets/images/star.png"),
      ],
    );
  }

  // 입력 모드 전체 UI
  Widget _commentInputUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),

        // 스티커 선택 영역
        StickerSelector(
          selectedSticker: widget.selectedSticker,
          onSelect: (path) {
            widget.onStickerSelected(path);
          },
          onRemove: () {
            widget.onStickerRemoved();
          },
        ),

        const SizedBox(height: 14),

        // 입력창 + 프로필 + 전송
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(widget.uploaderProfile),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE3E3E3), width: 2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "느끼는 감정을 적어 주세요!",
                    hintStyle: AppFontStyle.S8.copyWith(
                      color: const Color(0xFFAAAAAA),
                    ),
                    border: InputBorder.none,
                  ),
                  style: AppFontStyle.S8,
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: () {
                widget.onSend();

                setState(() {
                  _isInputMode = false;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEAF2FF),
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  size: 18,
                  color: Color(0xFF4880ED),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 공통 원형 버튼
  Widget _circleButton({required String image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 2),
        ),
        child: Center(child: Image.asset(image, width: 23, height: 23)),
      ),
    );
  }
}
