import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/user/notice_item_model.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/notice_detail_page.dart';
import 'package:uyoung/src/viewModel/mypage/notice_list_view_model.dart';

class NoticeListPage extends StatelessWidget {
  const NoticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoticeListViewModel()..load(),
      child: const _NoticeListView(),
    );
  }
}

class _NoticeListView extends StatelessWidget {
  const _NoticeListView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NoticeListViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '공지사항',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: context.read<NoticeListViewModel>().load,
          child: Builder(
            builder: (context) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.errorText != null) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 180),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        viewModel.errorText!,
                        style: AppFontStyle.H8.copyWith(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }

              if (viewModel.notices.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 180),
                    Center(
                      child: Text(
                        '공지사항이 없어요.',
                        style: AppFontStyle.H8.copyWith(color: AppColors.g03),
                      ),
                    ),
                  ],
                );
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
                itemCount: viewModel.notices.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notice = viewModel.notices[index];
                  return _NoticeRow(
                    notice: notice,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoticeDetailPage(noticeId: notice.id),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NoticeRow extends StatelessWidget {
  const _NoticeRow({
    required this.notice,
    required this.onTap,
  });

  final NoticeItem notice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE7E7EC)),
          ),
          child: Row(
            children: [
              if (notice.isImportant) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEFE3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '중요',
                    style: AppFontStyle.H8.copyWith(color: const Color(0xFFE58B31)),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.title,
                      style: AppFontStyle.H7.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(notice.createdAt),
                      style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.black,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return '${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}';
  }
}
