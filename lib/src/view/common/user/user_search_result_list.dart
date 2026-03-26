import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/src/view/common/user/selected_user_chip_list.dart';

class UserSearchResultList extends StatelessWidget {
  const UserSearchResultList({
    super.key,
    required this.users,
    required this.selectedUserIds,
    required this.isLoading,
    required this.errorText,
    required this.query,
    required this.onTapUser,
  });

  final List<InviteeUser> users;
  final Set<String> selectedUserIds;
  final bool isLoading;
  final String? errorText;
  final String query;
  final ValueChanged<InviteeUser> onTapUser;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorText != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            errorText!,
            style: AppFontStyle.M_14.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (users.isEmpty) {
      return Center(
        child: Text(
          query.trim().isEmpty ? '닉네임 또는 유저 코드를 검색해보세요.' : '검색 결과가 없어요.',
          style: AppFontStyle.M_16.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: users.length,
      itemBuilder: (_, index) {
        final user = users[index];
        final isSelected = selectedUserIds.contains(user.id);
        return GestureDetector(
          onTap: () => onTapUser(user),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                UserAvatar(user: user),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.displayName, style: AppFontStyle.M_16),
                      const SizedBox(height: 4),
                      Text(
                        user.userCode,
                        style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6EA8EB) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : const Color(0xFFBDBDBD),
                      width: 1.3,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
