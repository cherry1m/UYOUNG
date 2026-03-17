import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';

class FriendInvitePage extends StatelessWidget {
  const FriendInvitePage({super.key});

  static const String _inviteCode = 'A342G463';

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  const Spacer(),
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
                          _inviteCode,
                          style: AppFontStyle.F2.copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: _InviteActionButton(
                          label: '초대코드 복사하기',
                          onTap: () => _copyInviteCode(context),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _InviteActionButton(
                          label: '카톡으로 초대하기',
                          onTap: () => _showPrepareMessage(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _copyInviteCode(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: _inviteCode));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('초대 코드가 복사되었어요.')));
  }

  static void _showPrepareMessage(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('카카오톡 초대 기능은 준비 중이에요.')));
  }
}

class _InviteActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _InviteActionButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.b02,
          foregroundColor: Colors.white,
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
