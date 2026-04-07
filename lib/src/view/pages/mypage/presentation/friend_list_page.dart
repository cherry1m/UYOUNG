import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/friend_invite_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/friend_profile_page.dart';
import 'package:uyoung/src/viewModel/mypage/friend_list_view_model.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FriendListViewModel()..load(),
      child: const _FriendListView(),
    );
  }
}

class _FriendListView extends StatelessWidget {
  const _FriendListView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FriendListViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '친구 목록',
          style: AppFontStyle.H6.copyWith(color: AppColors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final didUpdate = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => FriendInvitePage(
                    initialFriendIds: viewModel.friendIds,
                  ),
                ),
              );
              if (didUpdate == true && context.mounted) {
                context.read<FriendListViewModel>().load();
              }
            },
            icon: const Icon(Icons.person_add_alt_1_rounded),
            color: AppColors.black,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: context.read<FriendListViewModel>().load,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
                child: _FriendSearchField(
                  controller: viewModel.searchController,
                  onChanged: viewModel.onSearchChanged,
                ),
              ),
              const SizedBox(height: 8),
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

                    if (viewModel.friends.isEmpty) {
                      return Center(
                        child: Text(
                          '친구가 아직 없어요.',
                          style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                        ),
                      );
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                      itemBuilder: (context, index) {
                        final friend = viewModel.friends[index];
                        return _FriendRow(
                          friend: friend,
                          isDeleting: viewModel.isDeleting(friend.id),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FriendProfilePage(friend: friend),
                              ),
                            );
                          },
                          onDelete: () => _confirmDelete(context, friend),
                        );
                      },
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemCount: viewModel.friends.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _confirmDelete(
    BuildContext context,
    FriendUser friend,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            '친구를 삭제할까요?',
            style: AppFontStyle.H6.copyWith(color: AppColors.black),
          ),
          content: Text(
            '삭제 후에도 다시 친구 추가할 수 있어요.',
            style: AppFontStyle.H8.copyWith(color: AppColors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(
                '취소',
                style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                '삭제',
                style: AppFontStyle.H8.copyWith(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !context.mounted) {
      return;
    }

    try {
      await context.read<FriendListViewModel>().deleteFriend(friend.id);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${friend.displayName}님을 친구 목록에서 삭제했어요.')));
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      final errorText = context.read<FriendListViewModel>().errorText;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorText ?? '친구 삭제에 실패했어요.')));
    }
  }
}

class _FriendSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _FriendSearchField({
    required this.controller,
    required this.onChanged,
  });

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
                hintText: '닉네임 또는 초대코드 검색',
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

class _FriendRow extends StatelessWidget {
  const _FriendRow({
    required this.friend,
    required this.isDeleting,
    required this.onTap,
    required this.onDelete,
  });

  final FriendUser friend;
  final bool isDeleting;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE1E1E7)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: _FriendAvatar(avatarUrl: friend.avatarUrl),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.displayName,
                  style: AppFontStyle.H6.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  friend.userCode,
                  style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: isDeleting ? null : onDelete,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFF3F3F6),
              foregroundColor: const Color(0xFF87878D),
              minimumSize: const Size(68, 34),
              side: const BorderSide(color: Color(0xFFE3E3E8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
              textStyle: AppFontStyle.H8.copyWith(color: const Color(0xFF87878D)),
            ),
            child: isDeleting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('친구 삭제'),
          ),
        ],
      ),
    );
  }
}

class _FriendAvatar extends StatelessWidget {
  const _FriendAvatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = avatarUrl?.trim();
    if (trimmedUrl != null && trimmedUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          trimmedUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Image.asset(ImagePath.friendProfile),
        ),
      );
    }

    return Image.asset(ImagePath.friendProfile, fit: BoxFit.contain);
  }
}
