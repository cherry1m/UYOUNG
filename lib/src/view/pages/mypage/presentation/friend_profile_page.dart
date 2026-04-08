import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/user/friend_user_model.dart';
import 'package:uyoung/data/repositories/user/friend_repository.dart';

class FriendProfilePage extends StatelessWidget {
  FriendProfilePage({
    super.key,
    required this.friend,
    FriendRepository? repository,
  }) : _repository = repository ?? FriendRepository();

  final FriendUser friend;
  final FriendRepository _repository;

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
                onPressed: () => _deleteFriend(context),
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

  Future<void> _deleteFriend(BuildContext context) async {
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
      await _repository.deleteFriend(friend.id);
      if (!context.mounted) {
        return;
      }
      Navigator.pop(context, true);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = avatarUrl?.trim();
    if (_isNetworkUrl(trimmedUrl)) {
      return ClipOval(
        child: Image.network(
          trimmedUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  bool _isNetworkUrl(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final uri = Uri.tryParse(value);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _fallback() {
    return Image.asset(
      ImagePath.friendProfile,
      fit: BoxFit.cover,
    );
  }
}
