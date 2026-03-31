import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/user/selected_user_chip_list.dart';
import 'package:uyoung/src/view/common/user/user_search_result_list.dart';
import 'package:uyoung/src/viewModel/memory/island_invite_view_model.dart';
import 'package:uyoung/src/viewModel/memory/select_member_view_model.dart';

class IslandInvitePage extends StatelessWidget {
  const IslandInvitePage({
    super.key,
    required this.islandId,
    required this.existingMemberIds,
  });

  final String islandId;
  final Set<String> existingMemberIds;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SelectMemberViewModel()..search(''),
        ),
        ChangeNotifierProvider(
          create: (_) => IslandInviteViewModel(
            islandId: islandId,
            existingMemberIds: existingMemberIds,
          ),
        ),
      ],
      child: const _IslandInviteView(),
    );
  }
}

class _IslandInviteView extends StatefulWidget {
  const _IslandInviteView();

  @override
  State<_IslandInviteView> createState() => _IslandInviteViewState();
}

class _IslandInviteViewState extends State<_IslandInviteView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final inviteVm = context.read<IslandInviteViewModel>();

    try {
      await inviteVm.inviteMembers();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('멤버를 초대했어요.')));
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectVm = context.watch<SelectMemberViewModel>();
    final inviteVm = context.watch<IslandInviteViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('버블 메이트 초대', style: AppFontStyle.M_20),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (inviteVm.selectedMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: SelectedUserChipList(
                users: inviteVm.selectedMembers,
                onRemove: inviteVm.removeInvitee,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              controller: _searchController,
              onChanged: selectVm.scheduleSearch,
              decoration: InputDecoration(
                hintText: '닉네임 또는 유저 코드 검색',
                hintStyle: AppFontStyle.M_16.copyWith(color: Colors.grey),
                suffixIcon: const Icon(Icons.search, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6EA8EB), width: 2),
                ),
              ),
              style: AppFontStyle.M_16,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: UserSearchResultList(
              users: selectVm.searchResults,
              selectedUserIds: inviteVm.selectedMembers.map((user) => user.id).toSet(),
              disabledUserIds: inviteVm.existingMemberIds,
              isLoading: selectVm.isLoading,
              errorText: selectVm.errorText,
              query: selectVm.query,
              onTapUser: inviteVm.toggleInvitee,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: inviteVm.isSubmitting
                          ? null
                          : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFD9E2EC)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        '취소',
                        style: AppFontStyle.M_18.copyWith(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: TextButton(
                      onPressed: inviteVm.canSubmit && !inviteVm.isSubmitting
                          ? _submit
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor: inviteVm.canSubmit
                            ? const Color(0xFF6EA8EB)
                            : const Color(0xFFEDEDED),
                        disabledBackgroundColor: const Color(0xFFEDEDED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: inviteVm.isSubmitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              '초대하기',
                              style: AppFontStyle.M_18.copyWith(
                                color: inviteVm.canSubmit ? Colors.white : Colors.grey,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
