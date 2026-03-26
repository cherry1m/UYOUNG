import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';

class SelectedUserChipList extends StatelessWidget {
  const SelectedUserChipList({
    super.key,
    required this.users,
    required this.onRemove,
  });

  final List<InviteeUser> users;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: users
            .map(
              (user) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _UserAvatar(user: user, radius: 32),
                        Positioned(
                          top: -2,
                          right: -2,
                          child: GestureDetector(
                            onTap: () => onRemove(user.id),
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF6EA8EB),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(user.displayName, style: AppFontStyle.M_14),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 28,
  });

  final InviteeUser user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return _UserAvatar(user: user, radius: radius);
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.user, required this.radius});

  final InviteeUser user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFE6E6E6),
      backgroundImage: user.avatarUrl?.isNotEmpty == true
          ? NetworkImage(user.avatarUrl!)
          : null,
      child: user.avatarUrl?.isNotEmpty == true
          ? null
          : Text(
              user.displayName.isEmpty ? '?' : user.displayName[0],
              style: AppFontStyle.M_18.copyWith(color: Colors.black54),
            ),
    );
  }
}
