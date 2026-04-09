import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/user/inquiry_item_model.dart';
import 'package:uyoung/src/viewModel/mypage/inquiry_history_view_model.dart';

class InquiryHistoryPage extends StatelessWidget {
  const InquiryHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InquiryHistoryViewModel()..load(),
      child: const _InquiryHistoryView(),
    );
  }
}

class _InquiryHistoryView extends StatelessWidget {
  const _InquiryHistoryView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<InquiryHistoryViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '문의 내역',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: context.read<InquiryHistoryViewModel>().load,
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

              if (viewModel.inquiries.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 180),
                    Center(
                      child: Text(
                        '문의 내역이 없어요.',
                        style: AppFontStyle.H8.copyWith(color: AppColors.g03),
                      ),
                    ),
                  ],
                );
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
                itemCount: viewModel.inquiries.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final inquiry = viewModel.inquiries[index];
                  return _InquiryCard(inquiry: inquiry);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InquiryCard extends StatelessWidget {
  const _InquiryCard({required this.inquiry});

  final InquiryItem inquiry;

  @override
  Widget build(BuildContext context) {
    final statusText = inquiry.status.trim().isEmpty
        ? (inquiry.isAnswered ? '답변 완료' : '답변 대기')
        : inquiry.status;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7E7EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  inquiry.title,
                  style: AppFontStyle.H7.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: inquiry.isAnswered
                      ? const Color(0xFFE7F3FF)
                      : const Color(0xFFF3F3F6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusText,
                  style: AppFontStyle.H8.copyWith(
                    color: inquiry.isAnswered
                        ? const Color(0xFF5E98DB)
                        : const Color(0xFF8B8B91),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _formatDate(inquiry.createdAt),
            style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
          ),
          if (inquiry.isAnswered) ...[
            const SizedBox(height: 12),
            Text(
              inquiry.answer!.trim(),
              style: AppFontStyle.H8.copyWith(
                color: AppColors.black,
                height: 1.5,
              ),
            ),
          ],
        ],
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
