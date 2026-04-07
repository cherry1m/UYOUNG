import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/user/app_notification_model.dart';
import 'package:uyoung/src/viewModel/home/notification_view_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
    this.viewModel,
  });

  final NotificationViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: const _NotificationPageView(),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => NotificationViewModel()..load(),
      child: const _NotificationPageView(),
    );
  }
}

class _NotificationPageView extends StatelessWidget {
  const _NotificationPageView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();

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
            onPressed: viewModel.hasUnread && !viewModel.isMarkingAll
                ? viewModel.markAllAsRead
                : null,
            icon: ImageData(path: ImagePath.setting, width: 35, height: 35),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _NotificationFilterBar(
            selected: viewModel.filter,
            onSelected: viewModel.setFilter,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.errorText != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        viewModel.errorText!,
                        style: AppFontStyle.H8.copyWith(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (viewModel.notifications.isEmpty) {
                  return Center(
                    child: Text(
                      '표시할 알림이 없어요.',
                      style: AppFontStyle.H8.copyWith(color: AppColors.g03),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewModel.notifications.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final item = viewModel.notifications[index];
                    return _NotificationCard(
                      item: item,
                      timeAgo: viewModel.formatTimeAgo(item.createdAt),
                      onTap: () => viewModel.markAsRead(item.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.item,
    required this.timeAgo,
    required this.onTap,
  });

  final AppNotification item;
  final String timeAgo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = AppFontStyle.H8.copyWith(
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

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: isMultiLine ? 98 : 74,
            padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9DC),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!item.isRead)
                      const Positioned(
                        top: -1,
                        right: -1,
                        child: _UnreadDot(),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.H7.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            timeAgo,
                            style: AppFontStyle.H8.copyWith(
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

class _NotificationFilterBar extends StatelessWidget {
  const _NotificationFilterBar({
    required this.selected,
    required this.onSelected,
  });

  final NotificationFilter selected;
  final ValueChanged<NotificationFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _FilterChip(
            label: '전체',
            selected: selected == NotificationFilter.all,
            onTap: () => onSelected(NotificationFilter.all),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: '초대',
            selected: selected == NotificationFilter.invite,
            onTap: () => onSelected(NotificationFilter.invite),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: '활동',
            selected: selected == NotificationFilter.activity,
            onTap: () => onSelected(NotificationFilter.activity),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: '공지',
            selected: selected == NotificationFilter.notice,
            onTap: () => onSelected(NotificationFilter.notice),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.b03 : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppColors.b02 : AppColors.bg02,
          ),
        ),
        child: Text(
          label,
          style: AppFontStyle.H8.copyWith(
            color: selected ? AppColors.b01 : AppColors.g02,
          ),
        ),
      ),
    );
  }
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xFFFF4D4F),
        shape: BoxShape.circle,
      ),
    );
  }
}
