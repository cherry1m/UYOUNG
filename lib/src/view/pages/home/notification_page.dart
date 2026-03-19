import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const List<_NotificationItem> _items = [
    _NotificationItem(
      category: '카테고리 텍스트',
      body: '알림 본문 내용 텍스트 (최대 두줄로 작성)',
      timeAgo: '5시간 전',
    ),
    _NotificationItem(
      category: '‘김신최루’ 기억섬에 초대되었어요',
      body: '최예진님이 최보빈님을 ‘김신최루’ 기억섬에 초대했어요. 바로 확인해보세요!',
      timeAgo: '5시간 전',
    ),
    _NotificationItem(
      category: '카테고리 텍스트',
      body: '알림 본문 내용 텍스트 (최대 두줄로 작성)',
      timeAgo: '5시간 전',
    ),
    _NotificationItem(
      category: '‘김신최루’ 기억섬에 초대되었어요',
      body: '최예진님이 최보빈님을 ‘김신최루’ 기억섬에 초대했어요. 바로 확인해보세요!',
      timeAgo: '5시간 전',
    ),
    _NotificationItem(
      category: '카테고리 텍스트',
      body: '알림 본문 내용 텍스트 (최대 두줄로 작성)',
      timeAgo: '5시간 전',
    ),
    _NotificationItem(
      category: '카테고리 텍스트',
      body: '알림 본문 내용 텍스트 (최대 두줄로 작성)',
      timeAgo: '5시간 전',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.black,
        ),
        centerTitle: true,
        title: Text(
          '알림',
          style: AppFontStyle.H4.copyWith(color: AppColors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('알림 설정은 준비 중이에요.')),
                );
            },
            icon: const Icon(Icons.settings_outlined),
            color: AppColors.black,
            iconSize: 34,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        physics: const BouncingScrollPhysics(),
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          final item = _items[index];
          return _NotificationCard(item: item);
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = AppFontStyle.H7.copyWith(
      color: AppColors.black,
      height: 1.45,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidth = constraints.maxWidth - 44 - 16 - 18 - 18;
        final isMultiLine = _isMultiLineText(
          text: item.body,
          style: bodyStyle,
          maxWidth: textWidth,
        );

        return Container(
          height: isMultiLine ? 98 : 75,
          padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F2),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9DC),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.H6.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.timeAgo,
                          style: AppFontStyle.H7.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: bodyStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isMultiLineText({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: maxWidth);

    return painter.computeLineMetrics().length > 1;
  }
}

class _NotificationItem {
  const _NotificationItem({
    required this.category,
    required this.body,
    required this.timeAgo,
  });

  final String category;
  final String body;
  final String timeAgo;
}
