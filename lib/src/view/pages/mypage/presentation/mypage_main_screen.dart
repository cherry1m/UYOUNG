import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/home/shell_story_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/friend_list_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/invite_fake_page.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/pear_fake_page.dart';

class MyPageMainScreen extends StatelessWidget {
  const MyPageMainScreen({super.key});

  static const String _otterImageUrl =
      'https://www.figma.com/api/mcp/asset/65376b85-8c81-49ff-9b00-4e0471d89b25';
  static const String _pearlImageUrl =
      'https://www.figma.com/api/mcp/asset/6162ef10-0ac9-460f-81e2-f54b4d916365';
  static const String _noticeImageUrl =
      'https://www.figma.com/api/mcp/asset/94669f03-cad5-4bd3-b99f-0489566bdf18';

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
                      child: const _FriendDoodle(),
                      onTap: () => _push(context, const FriendListFakePage()),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _noticeImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.campaign_outlined,
                            color: Color(0xFFDEC870),
                            size: 34,
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
                onTap: () {},
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
              Text(
                '로그아웃',
                style: AppFontStyle.H7.copyWith(color: AppColors.black),
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
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 6,
                child: Container(
                  width: 180,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE3FB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Positioned(
                top: 68,
                left: 28,
                child: _sparkle(const Color(0xFFD9DFF8), 10),
              ),
              Positioned(
                top: 148,
                left: 16,
                child: _sparkle(const Color(0xFFD9DFF8), 12),
              ),
              Positioned(
                top: 116,
                right: 22,
                child: _sparkle(const Color(0xFFD9DFF8), 8),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Image.network(
                    MyPageMainScreen._otterImageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Positioned(top: 18, left: 88, child: _BowDecoration()),
              const Positioned(top: 12, right: 96, child: _BowDecoration()),
            ],
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

  Widget _sparkle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
                child: Image.network(
                  MyPageMainScreen._pearlImageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0E7FF),
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
                style: AppFontStyle.H6.copyWith(color: AppColors.black),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE7E7EC)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 38, child: Center(child: child)),
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

class _FriendDoodle extends StatelessWidget {
  const _FriendDoodle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 34,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 4,
            top: 6,
            child: Transform.rotate(
              angle: -0.35,
              child: Icon(
                Icons.favorite,
                color: const Color(0xFFF58CB0),
                size: 22,
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 8,
            child: Transform.rotate(
              angle: 0.25,
              child: Icon(
                Icons.favorite,
                color: const Color(0xFF7FB6FF),
                size: 22,
              ),
            ),
          ),
          const Positioned(
            right: 4,
            top: 0,
            child: Icon(Icons.water_drop, color: Color(0xFF7FB6FF), size: 12),
          ),
        ],
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

class _BowDecoration extends StatelessWidget {
  const _BowDecoration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 22,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Transform.rotate(
              angle: -0.45,
              child: Container(
                width: 14,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8DB2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Transform.rotate(
              angle: 0.45,
              child: Container(
                width: 14,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8DB2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFFFF82AA),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
