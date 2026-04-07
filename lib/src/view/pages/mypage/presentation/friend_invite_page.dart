import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/friend_add_by_code_page.dart';
import 'package:uyoung/src/viewModel/mypage/friend_invite_view_model.dart';

class FriendInvitePage extends StatelessWidget {
  const FriendInvitePage({super.key, this.initialFriendIds = const []});

  final List<String> initialFriendIds;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          FriendInviteViewModel()..load(initialFriendIds: initialFriendIds),
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
                child: Image.asset(ImagePath.inviteBg, fit: BoxFit.cover),
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
                    style: AppFontStyle.H7.copyWith(
                      color: const Color(0xFF7A7A80),
                    ),
                  ),
                  const SizedBox(height: 400),
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
                          style: AppFontStyle.H6.copyWith(
                            color: const Color(0xFF7A7A80),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          viewModel.myCode,
                          style: AppFontStyle.F2.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      Expanded(
                        child: _InviteActionButton(
                          label: '초대코드 복사하기',
                          onTap: () =>
                              _copyInviteCode(context, viewModel.myCode),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _InviteActionButton(
                          label: '코드로 친구 추가',
                          onTap: () => _openAddByCodePage(context),
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

  static Future<void> _openAddByCodePage(BuildContext context) async {
    final viewModel = context.read<FriendInviteViewModel>();
    final didUpdate = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => FriendAddByCodePage(
          initialFriendIds: viewModel.friendIds.toList(),
        ),
      ),
    );

    if (didUpdate == true && context.mounted) {
      Navigator.pop(context, true);
    }
  }

  static Future<void> _copyInviteCode(
    BuildContext context,
    String inviteCode,
  ) async {
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
  const _InviteActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
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
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
