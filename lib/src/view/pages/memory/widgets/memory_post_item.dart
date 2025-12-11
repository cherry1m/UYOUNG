import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';

class MemoryPostItem extends StatefulWidget {
  final MemoryPostModel post;

  const MemoryPostItem({super.key, required this.post});

  @override
  State<MemoryPostItem> createState() => _MemoryPostItemState();
}

class _MemoryPostItemState extends State<MemoryPostItem> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MARK: 작성자 정보
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                widget.post.profileImage,
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.post.name, style: AppFontStyle.S7),
                Text(
                  widget.post.createdAt,
                  style: AppFontStyle.S8.copyWith(
                    color: const Color(0xFF707070),
                  ),
                ),
              ],
            ),

            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.more_horiz, size: 22),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // MARK: 이미지(스와이프) + 프레임 오버레이
        SizedBox(
          height: 380,
          width: double.infinity,
          child: Stack(
            children: [
              // MARK: 실제 이미지 PageView
              PageView.builder(
                controller: _controller,
                itemCount: widget.post.images.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (_, i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      widget.post.images[i],
                      width: double.infinity,
                      height: 380,
                      fit: BoxFit.cover, // 사진 꽉 채우기
                    ),
                  );
                },
              ),

              // MARK: 프레임 PNG 오버레이
              Positioned.fill(
                child: IgnorePointer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/images/memory_feed_frame.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // MARK: 페이지 표시 텍스트 (ex: 1/4)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${_currentIndex + 1}/${widget.post.images.length}",
                    style: AppFontStyle.S8.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // MARK: Shell Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.post.images.length,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Image.asset(
                i == _currentIndex
                    ? "assets/images/shell_filled.png"
                    : "assets/images/shell_empty.png",
                width: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
