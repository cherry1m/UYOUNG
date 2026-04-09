import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/viewModel/mypage/notice_detail_view_model.dart';

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage({
    super.key,
    required this.noticeId,
  });

  final String noticeId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoticeDetailViewModel(noticeId: noticeId)..load(),
      child: const _NoticeDetailView(),
    );
  }
}

class _NoticeDetailView extends StatelessWidget {
  const _NoticeDetailView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NoticeDetailViewModel>();
    final notice = viewModel.notice;

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

            if (notice == null) {
              return Center(
                child: Text(
                  '공지사항을 찾을 수 없어요.',
                  style: AppFontStyle.H8.copyWith(color: AppColors.g03),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE7E7EC)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (notice.isImportant)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEFE3),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '중요',
                          style: AppFontStyle.H8.copyWith(
                            color: const Color(0xFFE58B31),
                          ),
                        ),
                      ),
                    if (notice.isImportant) const SizedBox(height: 14),
                    Text(
                      notice.title,
                      style: AppFontStyle.H5.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(notice.createdAt),
                      style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      notice.body,
                      style: AppFontStyle.H8.copyWith(
                        color: AppColors.black,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
