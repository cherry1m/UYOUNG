import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/src/view/pages/memory/memory_creation_result.dart';
import 'package:uyoung/src/viewModel/memory/create_memory_view_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';
import 'package:uyoung/src/viewModel/memory/select_member_view_model.dart';

class SelectMemberPage extends StatelessWidget {
  const SelectMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectMemberViewModel()..search(''),
      child: const _SelectMemberStepView(),
    );
  }
}

class _SelectMemberStepView extends StatefulWidget {
  const _SelectMemberStepView();

  @override
  State<_SelectMemberStepView> createState() => _SelectMemberStepViewState();
}

class _SelectMemberStepViewState extends State<_SelectMemberStepView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final createVm = context.read<CreateMemoryViewModel>();
    final memoryVm = context.read<MemoryViewModel>();

    try {
      final createdItem = await createVm.createIsland();
      await memoryVm.insertCreatedItem(createdItem);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('기억섬이 생성됐어요. ID: ${createdItem.id}')),
      );
      Navigator.pop(context, MemoryCreationResult(item: createdItem));
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  Future<void> _copyInviteLink() async {
    await Clipboard.setData(
      const ClipboardData(text: '기억섬 초대 링크는 서버 연동 후 연결 예정입니다.'),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('임시 안내 문구를 클립보드에 복사했어요.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final createVm = context.watch<CreateMemoryViewModel>();
    final selectVm = context.watch<SelectMemberViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
            child: _inviteByLinkButton(),
          ),
          if (createVm.selectedMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: createVm.selectedMembers
                      .map((member) => _selectedProfile(createVm, member))
                      .toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: _searchField(selectVm),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildBody(createVm, selectVm)),
          _bottomButtons(createVm),
        ],
      ),
    );
  }

  Widget _inviteByLinkButton() {
    return InkWell(
      onTap: _copyInviteLink,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8FC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE3EBF5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.link_rounded, color: Color(0xFF6EA8EB)),
            const SizedBox(width: 10),
            Expanded(
              child: Text('링크로 초대하기', style: AppFontStyle.M_16),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    CreateMemoryViewModel createVm,
    SelectMemberViewModel selectVm,
  ) {
    if (selectVm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selectVm.errorText != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            selectVm.errorText!,
            style: AppFontStyle.M_14.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (selectVm.searchResults.isEmpty) {
      return Center(
        child: Text(
          '검색 결과가 없어요.',
          style: AppFontStyle.M_16.copyWith(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: selectVm.searchResults.length,
      itemBuilder: (_, index) {
        final user = selectVm.searchResults[index];
        return _memberRow(createVm, user);
      },
    );
  }

  Widget _memberRow(CreateMemoryViewModel createVm, InviteeUser user) {
    final isSelected = createVm.isSelected(user.id);

    return GestureDetector(
      onTap: () => createVm.toggleInvitee(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE6E6E6),
              backgroundImage: user.avatarUrl?.isNotEmpty == true
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl?.isNotEmpty == true
                  ? null
                  : Text(
                      user.nickname.isEmpty ? '?' : user.nickname[0],
                      style: AppFontStyle.M_18.copyWith(color: Colors.black54),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(user.nickname, style: AppFontStyle.M_16)),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6EA8EB) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.transparent : const Color(0xFFBDBDBD),
                  width: 1.3,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedProfile(CreateMemoryViewModel createVm, InviteeUser user) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                backgroundImage: user.avatarUrl?.isNotEmpty == true
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl?.isNotEmpty == true
                    ? null
                    : Text(
                        user.nickname.isEmpty ? '?' : user.nickname[0],
                        style: AppFontStyle.M_18.copyWith(color: Colors.black54),
                      ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: GestureDetector(
                  onTap: () => createVm.removeInvitee(user.id),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6EA8EB),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(user.nickname, style: AppFontStyle.M_14),
        ],
      ),
    );
  }

  Widget _searchField(SelectMemberViewModel selectVm) {
    return TextField(
      controller: _searchController,
      onChanged: selectVm.scheduleSearch,
      decoration: InputDecoration(
        hintText: '이름 또는 초성 검색',
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
    );
  }

  Widget _bottomButtons(CreateMemoryViewModel createVm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: OutlinedButton(
                onPressed: createVm.isSubmitting ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD9E2EC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  '이전',
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
                onPressed: createVm.canSubmit && !createVm.isSubmitting ? _submit : null,
                style: TextButton.styleFrom(
                  backgroundColor: createVm.canSubmit
                      ? const Color(0xFF6EA8EB)
                      : const Color(0xFFEDEDED),
                  disabledBackgroundColor: const Color(0xFFEDEDED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: createVm.isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        '확인',
                        style: AppFontStyle.M_18.copyWith(
                          color: createVm.canSubmit ? Colors.white : Colors.grey,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text('대화 상대', style: AppFontStyle.M_20),
  );
}
