import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({
    super.key,
    required this.friend,
  });

  final FriendUser friend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 28),
            SizedBox(
              height: 250,
              child: Center(
                child: SizedBox(
                  width: 210,
                  height: 210,
                  child: _Avatar(avatarUrl: friend.avatarUrl),
                ),
              ),
            ),
            Text(
              friend.displayName,
              style: AppFontStyle.F2.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 8),
            Text(
              friend.userCode,
              style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: 134,
              height: 48,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.b02,
                  foregroundColor: Colors.white,
                  textStyle: AppFontStyle.H7.copyWith(color: Colors.white),
                ),
                child: const Text('놀러가기'),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '친구 삭제하기',
                  style: AppFontStyle.H8.copyWith(color: const Color(0xFF8B8B91)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = avatarUrl?.trim();
    if (trimmedUrl != null && trimmedUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          trimmedUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    return Image.asset(
      ImagePath.friendProfile,
      fit: BoxFit.contain,
    );
  }
}
