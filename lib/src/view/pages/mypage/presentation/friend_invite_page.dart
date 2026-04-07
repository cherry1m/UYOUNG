import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/common/user/user_search_result_list.dart';
import 'package:uyoung/src/viewModel/mypage/friend_invite_view_model.dart';

class FriendInvitePage extends StatelessWidget {
  const FriendInvitePage({
    super.key,
    this.initialFriendIds = const [],
  });

  final List<String> initialFriendIds;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FriendInviteViewModel()..load(initialFriendIds: initialFriendIds),
      child: const _FriendInviteView(),
    );
  }
}

class _FriendInviteView extends StatelessWidget {
  const _FriendInviteView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FriendInviteViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '친구 초대',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Image.asset(
                  ImagePath.inviteBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () => context.read<FriendInviteViewModel>().load(
                initialFriendIds: viewModel.friendIds.toList(),
              ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
                children: [
                  Text(
                    '바다는 친구와 함께\n떠다닐 때 더 아름다워요.',
                    style: AppFontStyle.F1.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '친구 초대하면 @@개 조개 보상 지급!',
                    style: AppFontStyle.H7.copyWith(color: const Color(0xFF7A7A80)),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE6E6EB)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '나의 초대 코드',
                          style: AppFontStyle.H6.copyWith(color: const Color(0xFF7A7A80)),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          viewModel.myCode,
                          style: AppFontStyle.F2.copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _InviteActionButton(
                          label: '초대코드 복사하기',
                          onTap: () => _copyInviteCode(context, viewModel.myCode),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _InviteActionButton(
                          label: viewModel.isSubmittingCode ? '추가 중...' : '코드로 친구 추가',
                          onTap: viewModel.isSubmittingCode
                              ? null
                              : () => _submitCode(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _CodeInputField(controller: viewModel.codeController),
                  const SizedBox(height: 22),
                  Text(
                    '직접 친구 추가',
                    style: AppFontStyle.H6.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 10),
                  _SearchInputField(
                    controller: viewModel.searchController,
                    onChanged: viewModel.scheduleSearch,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 320,
                    child: UserSearchResultList(
                      users: viewModel.searchResults,
                      selectedUserIds: viewModel.justAddedIds,
                      disabledUserIds: viewModel.friendIds,
                      isLoading: viewModel.isSearching || viewModel.isLoading,
                      errorText: viewModel.errorText,
                      query: viewModel.searchController.text,
                      onTapUser: (user) async {
                        final message = await context.read<FriendInviteViewModel>().addDirect(user);
                        if (!context.mounted || message == null) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _submitCode(BuildContext context) async {
    final message = await context.read<FriendInviteViewModel>().addByCode();
    if (!context.mounted || message == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    Navigator.pop(context, true);
  }

  static Future<void> _copyInviteCode(BuildContext context, String inviteCode) async {
    await Clipboard.setData(ClipboardData(text: inviteCode));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('초대 코드가 복사되었어요.')));
  }
}

class _InviteActionButton extends StatelessWidget {
  const _InviteActionButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.b02,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFB7D1EF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: AppFontStyle.F3.copyWith(color: Colors.white),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CodeInputField extends StatelessWidget {
  const _CodeInputField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.g02,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: '친구 코드를 입력해주세요',
        hintStyle: AppFontStyle.H8.copyWith(color: const Color(0xFFB8B8BE)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE6E6EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE6E6EB)),
        ),
      ),
      style: AppFontStyle.H8.copyWith(color: AppColors.black),
    );
  }
}

class _SearchInputField extends StatelessWidget {
  const _SearchInputField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE8E8ED))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.g02,
              style: AppFontStyle.H8.copyWith(color: AppColors.black),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '닉네임 또는 유저 코드를 검색해보세요.',
                hintStyle: AppFontStyle.H8.copyWith(color: const Color(0xFFB8B8BE)),
              ),
            ),
          ),
          const Icon(Icons.search_rounded, color: AppColors.black, size: 28),
        ],
      ),
    );
  }
}
