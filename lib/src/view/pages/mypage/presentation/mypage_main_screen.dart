import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/sources/supabase/supabase_config.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/friend_list_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/invite_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/pear_fake_page.dart';
import 'package:uyoung/src/viewModel/auth/auth_view_model.dart';

class MyPageMainScreen extends StatelessWidget {
  const MyPageMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              const _ProfileHero(),
              const SizedBox(height: 18),
              _PearlCard(onTap: () => _push(context, const PearFakePage())),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      label: '친구 목록',
                      child: SizedBox(
                        width: 58,
                        child: Image.asset(
                          ImagePath.friendListButton,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () => _push(context, const FriendListPage()),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _QuickActionCard(
                      label: '친구와 한 컷',
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.g04,
                        size: 34,
                      ),
                      onTap: () => _push(context, const ShellStoryPage()),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _QuickActionCard(
                      label: '공지',
                      child: SizedBox(
                        width: 58,
                        child: Image.asset(
                          ImagePath.notice,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.campaign_outlined,
                            color: Color(0xFFDEC870),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const _SectionTitle('초대 및 공유'),
              const SizedBox(height: 10),
              _MenuRow(
                icon: Icons.lock_outline_rounded,
                title: '프로필 URL 복사',
                onTap: () => _copyProfileUrl(context),
              ),
              _MenuRow(
                icon: Icons.person_add_alt_1_outlined,
                title: '친구 초대 및 등록',
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.black,
                ),
                onTap: () => _push(context, const InviteFakePage()),
              ),
              const SizedBox(height: 18),
              const Divider(height: 1, color: Color(0xFFE8E8ED)),
              const SizedBox(height: 18),
              const _SectionTitle('고객지원'),
              const SizedBox(height: 10),
              const _MenuRow(
                icon: Icons.info_outline_rounded,
                title: '버전정보',
                trailingText: '0.00.00',
              ),
              const _MenuRow(
                icon: Icons.help_outline_rounded,
                title: '공지사항',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.black,
                ),
              ),
              const _MenuRow(
                icon: Icons.help_outline_rounded,
                title: '고객센터/도움말',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 18),
              const Divider(height: 1, color: Color(0xFFE8E8ED)),
              const SizedBox(height: 18),
              _FooterActionText(
                title: '로그아웃',
                onTap: () async {
                  await context.read<AuthViewModel>().signOut();
                },
              ),
              const SizedBox(height: 20),
              Text(
                '계정탈퇴',
                style: AppFontStyle.H7.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> _copyProfileUrl(BuildContext context) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인 정보가 없어요.')));
      return;
    }

    final profileBaseUrl = SupabaseConfig.inviteBaseUrl.replaceFirst(
      RegExp(r'/invite$'),
      '/profile',
    );
    final profileUrl = '$profileBaseUrl?userId=${user.id}';

    await Clipboard.setData(ClipboardData(text: profileUrl));

    if (!context.mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        Future.delayed(const Duration(milliseconds: 1100), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              '초대 문구 복사됨',
              textAlign: TextAlign.center,
              style: AppFontStyle.H8.copyWith(color: AppColors.black),
            ),
          ),
        );
      },
    );
  }
}

class _FooterActionText extends StatelessWidget {
  final String title;
  final Future<void> Function()? onTap;

  const _FooterActionText({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null ? null : () => onTap!.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          title,
          style: AppFontStyle.H7.copyWith(color: AppColors.black),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 228,
          child: Center(
            child: SizedBox(
              width: 210,
              height: 210,
              child: Image.asset(
                ImagePath.myProfile,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) =>
                    Image.asset(ImagePath.friendProfile, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE6E6EB)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '이윤서',
                style: AppFontStyle.H5.copyWith(color: AppColors.black),
              ),
            ),
            Positioned(
              right: -10,
              top: -6,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.b02,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PearlCard extends StatelessWidget {
  final VoidCallback onTap;

  const _PearlCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE7E7EC)),
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  ImagePath.mypagePearl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF1E8F7),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '진주',
                style: AppFontStyle.H7.copyWith(color: const Color(0xFF666666)),
              ),
              const Spacer(),
              Text(
                '128개',
                style: AppFontStyle.H7.copyWith(color: AppColors.black),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.black,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.label,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 84,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE7E7EC)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 38,
                child: Center(
                  child: FittedBox(fit: BoxFit.scaleDown, child: child),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppFontStyle.H8.copyWith(color: const Color(0xFF666666)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFontStyle.H8.copyWith(color: const Color(0xFF666666)),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final String? trailingText;
  final VoidCallback? onTap;

  const _MenuRow({
    required this.icon,
    required this.title,
    this.trailing,
    this.trailingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trailingWidget =
        trailing ??
        (trailingText == null
            ? null
            : Text(
                trailingText!,
                style: AppFontStyle.F4.copyWith(color: AppColors.black),
              ));

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Icon(icon, color: AppColors.black, size: 22),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: AppFontStyle.H7.copyWith(color: AppColors.black),
              ),
            ),
            if (trailingWidget != null) trailingWidget,
          ],
        ),
      ),
    );
  }
}
