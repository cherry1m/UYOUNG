import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/viewModel/mypage/friend_add_by_code_view_model.dart';

class FriendAddByCodePage extends StatelessWidget {
  const FriendAddByCodePage({
    super.key,
    this.initialFriendIds = const [],
  });

  final List<String> initialFriendIds;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          FriendAddByCodeViewModel()..load(initialFriendIds: initialFriendIds),
      child: const _FriendAddByCodeView(),
    );
  }
}

class _FriendAddByCodeView extends StatelessWidget {
  const _FriendAddByCodeView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FriendAddByCodeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '친구 추가',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
          children: [
            _SearchBar(
              controller: viewModel.codeController,
              onSearch: viewModel.isSearching
                  ? null
                  : () => context.read<FriendAddByCodeViewModel>().searchByCode(),
            ),
            const SizedBox(height: 18),
            if (viewModel.errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  viewModel.errorText!,
                  style: AppFontStyle.H8.copyWith(color: Colors.redAccent),
                ),
              ),
            if (viewModel.infoText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  viewModel.infoText!,
                  style: AppFontStyle.H8.copyWith(
                    color: const Color(0xFF8B8B91),
                  ),
                ),
              ),
            if (viewModel.isSearching)
              const Padding(
                padding: EdgeInsets.only(top: 48),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (viewModel.foundUser != null)
              _SearchResultCard(
                nickname: viewModel.foundUser!.displayName,
                avatarUrl: viewModel.foundUser!.avatarUrl,
                onAdd: viewModel.canAddFoundUser && !viewModel.isSubmitting
                    ? () async {
                        final message = await context
                            .read<FriendAddByCodeViewModel>()
                            .addFoundUser();
                        if (!context.mounted) {
                          return;
                        }
                        if (message == null) {
                          return;
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));
                        Navigator.pop(context, true);
                      }
                    : null,
                isSubmitting: viewModel.isSubmitting,
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onSearch,
  });

  final TextEditingController controller;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6E6EB)),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSearch?.call(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '친구 코드 검색',
                hintStyle: AppFontStyle.H8.copyWith(
                  color: const Color(0xFF8B8B91),
                ),
              ),
              style: AppFontStyle.H8.copyWith(color: AppColors.black),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 86,
          height: 52,
          child: FilledButton(
            onPressed: onSearch,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.b02,
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFFB7D1EF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              '검색',
              style: AppFontStyle.H7.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({
    required this.nickname,
    required this.avatarUrl,
    required this.onAdd,
    required this.isSubmitting,
  });

  final String nickname;
  final String? avatarUrl;
  final VoidCallback? onAdd;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6E6EB)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: const Color(0xFFF3F4F6),
            backgroundImage: avatarUrl?.trim().isNotEmpty == true
                ? NetworkImage(avatarUrl!.trim())
                : null,
            child: avatarUrl?.trim().isNotEmpty == true
                ? null
                : ClipOval(
                    child: Image.asset(
                      ImagePath.friendProfile,
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            nickname,
            style: AppFontStyle.F3.copyWith(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: onAdd,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.b02,
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFB7D1EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      '친구 추가하기',
                      style: AppFontStyle.H7.copyWith(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
