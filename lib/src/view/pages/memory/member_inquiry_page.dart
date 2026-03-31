import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/data/model/user/app_user_profile_model.dart';
import 'package:uyoung/src/view/pages/calendar/calendar_main_page.dart';
import 'package:uyoung/src/view/pages/memory/favorite_photos_page.dart';
import 'package:uyoung/src/view/pages/memory/island_invite_page.dart';
import 'package:uyoung/src/viewModel/memory/island_detail_view_model.dart';

class MemberInquiryPage extends StatelessWidget {
  final String islandId;

  const MemberInquiryPage({super.key, required this.islandId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IslandDetailViewModel(islandId: islandId)..load(),
      child: _MemberInquiryView(islandId: islandId),
    );
  }
}

class _MemberInquiryView extends StatelessWidget {
  const _MemberInquiryView({required this.islandId});

  final String islandId;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IslandDetailViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/alert.png", width: 25),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: IconButton(
              icon: Image.asset("assets/images/setting.png", width: 30),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Builder(
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
                  textAlign: TextAlign.center,
                  style: AppFontStyle.M_16.copyWith(color: Colors.redAccent),
                ),
              ),
            );
          }

          final island = viewModel.island;
          if (island == null) {
            return Center(
              child: Text(
                '기억섬 정보를 찾을 수 없어요.',
                style: AppFontStyle.M_16.copyWith(color: Colors.grey),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/memory_seaotter1.png",
                    width: 200,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  island.name,
                  style: AppFontStyle.M_22.copyWith(letterSpacing: 2),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE6E6E6)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: ImageData(path: ImagePath.calendarOn, width: 30),
                        title: Text("캘린더", style: AppFontStyle.S7),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CalendarMainPage()),
                          );
                        },
                      ),
                      Container(height: 1, color: const Color(0xFFE6E6E6)),
                      ListTile(
                        leading: const Icon(
                          Icons.favorite_border_rounded,
                          color: Color(0xFF6EA8EB),
                          size: 28,
                        ),
                        title: Text("즐겨찾는 사진", style: AppFontStyle.S7),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FavoritePhotosPage(islandId: islandId),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE6E6E6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "버블 메이트 ${viewModel.members.length}",
                        style: AppFontStyle.M_16,
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Icon(Icons.add, size: 22),
                        ),
                        title: Text("초대하기", style: AppFontStyle.M_16),
                        onTap: () async {
                          final invited = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => IslandInvitePage(
                                islandId: islandId,
                                existingMemberIds: viewModel.members
                                    .map((member) => member.id)
                                    .toSet(),
                              ),
                            ),
                          );

                          if (invited == true && context.mounted) {
                            await context.read<IslandDetailViewModel>().load();
                          }
                        },
                      ),
                      if (viewModel.members.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Text(
                            '멤버가 없습니다',
                            style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                          ),
                        )
                      else
                        ...viewModel.members.map(_memberTile),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "기억섬 나가기",
                            style: AppFontStyle.M_16.copyWith(
                              color: const Color(0xFFE4533A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _memberTile(AppUserProfile member) {
    final displayName = member.nickname.trim().isEmpty ? '이름 없음' : member.nickname.trim();

    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: const Color(0xFFE6E6E6),
        backgroundImage: member.avatarUrl?.isNotEmpty == true
            ? NetworkImage(member.avatarUrl!)
            : null,
        child: member.avatarUrl?.isNotEmpty == true
            ? null
            : Text(
                displayName.isEmpty ? '?' : displayName[0],
                style: AppFontStyle.M_14.copyWith(color: Colors.black54),
              ),
      ),
      title: Text(displayName, style: AppFontStyle.M_16),
      onTap: () {},
    );
  }
}
