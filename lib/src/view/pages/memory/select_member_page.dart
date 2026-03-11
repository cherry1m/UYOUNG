import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

class SelectMemberPage extends StatefulWidget {
  final List<InviteeUser> initialSelectedMembers;

  const SelectMemberPage({
    super.key,
    this.initialSelectedMembers = const [],
  });

  @override
  State<SelectMemberPage> createState() => _SelectMemberPageState();
}

class _SelectMemberPageState extends State<SelectMemberPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<InviteeUser> _selectedMembers = [];
  final List<InviteeUser> _searchResults = [];
  Timer? _debounce;
  bool _isLoading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedMembers.addAll(widget.initialSelectedMembers);
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchMembers('');
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchMembers(_searchController.text.trim());
    });
    setState(() {});
  }

  Future<void> _searchMembers(String keyword) async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final results = await context.read<MemoryViewModel>().searchUsers(keyword);
      if (!mounted) {
        return;
      }

      setState(() {
        _searchResults
          ..clear()
          ..addAll(results);
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorText = error.toString();
        _searchResults.clear();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isSelected(InviteeUser user) {
    return _selectedMembers.any((member) => member.id == user.id);
  }

  void _toggleUser(InviteeUser user) {
    setState(() {
      if (_isSelected(user)) {
        _selectedMembers.removeWhere((member) => member.id == user.id);
      } else {
        _selectedMembers.add(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelected = _selectedMembers.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _selectedMembers
                      .map((member) => _selectedProfile(member))
                      .toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: _searchField(),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildBody()),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                onPressed: hasSelected
                    ? () => Navigator.pop(context, List<InviteeUser>.from(_selectedMembers))
                    : null,
                style: TextButton.styleFrom(
                  backgroundColor: hasSelected
                      ? const Color(0xFF6EA8EB)
                      : const Color(0xFFEDEDED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  '추가하기',
                  style: AppFontStyle.M_18.copyWith(
                    color: hasSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorText != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _errorText!,
            style: AppFontStyle.M_14.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          '검색 결과가 없어요.',
          style: AppFontStyle.M_16.copyWith(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: _searchResults.length,
      itemBuilder: (_, index) {
        final user = _searchResults[index];
        return _memberRow(user, _isSelected(user));
      },
    );
  }

  Widget _memberRow(InviteeUser user, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleUser(user),
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

  Widget _selectedProfile(InviteeUser user) {
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
                  onTap: () => setState(() {
                    _selectedMembers.removeWhere((member) => member.id == user.id);
                  }),
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

  Widget _searchField() {
    return TextField(
      controller: _searchController,
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

  AppBar _appBar() => AppBar(
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
