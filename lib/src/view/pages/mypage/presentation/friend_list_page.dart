import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/mypage/presentation/fake/friend_profile_fake_page.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  final TextEditingController _searchController = TextEditingController();

  static final List<_FriendItem> _friends = [
    _FriendItem(name: '조성은', imagePath: ImagePath.choProfile),
    _FriendItem(name: '윤채림', imagePath: ImagePath.yoonProfile),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim();
    final filteredFriends =
        _friends.where((friend) => friend.name.contains(query)).toList();

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
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
              child: _FriendSearchField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  return _FriendRow(
                    friend: friend,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FriendProfileFakePage(),
                        ),
                      );
                    },
                    onDelete: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${friend.name} 친구 삭제는 아직 준비 중이에요.')),
                      );
                    },
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemCount: filteredFriends.length,
              ),
            ),
          ],
        ),
      ),
    );
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
                hintText: '이름(초성) 검색',
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
  final _FriendItem friend;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _FriendRow({
    required this.friend,
    required this.onTap,
    required this.onDelete,
  });

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
              child: Image.asset(friend.imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              friend.name,
              style: AppFontStyle.H6.copyWith(color: AppColors.black),
            ),
          ),
          OutlinedButton(
            onPressed: onDelete,
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
            child: const Text('친구 삭제'),
          ),
        ],
      ),
    );
  }
}

class _FriendItem {
  final String name;
  final String imagePath;

  const _FriendItem({
    required this.name,
    required this.imagePath,
  });
}
