import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/island_invite_detail_model.dart';
import 'package:uyoung/data/model/memory/memory_item_model.dart';
import 'package:uyoung/src/view/pages/memory/memory_detail_page.dart';
import 'package:uyoung/src/viewModel/memory/invite_island_view_model.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';
import 'dart:async';

class InviteIslandPage extends StatelessWidget {
  final String inviteCode;

  const InviteIslandPage({
    super.key,
    required this.inviteCode,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InviteIslandViewModel(inviteCode: inviteCode)..load(),
      child: const _InviteIslandView(),
    );
  }
}

class _InviteIslandView extends StatefulWidget {
  const _InviteIslandView();

  @override
  State<_InviteIslandView> createState() => _InviteIslandViewState();
}

class _InviteIslandViewState extends State<_InviteIslandView> {
  StreamSubscription<AuthState>? _authSubscription;
  bool _waitingForLogin = false;
  late InviteIslandViewModel _inviteVm;
  late MemoryViewModel _memoryVm;
  bool _didBindDependencies = false;

  @override
  void initState() {
    super.initState();
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      if (!_waitingForLogin) {
        return;
      }

      if (data.session == null) {
        return;
      }

      _waitingForLogin = false;
      _handleJoin();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didBindDependencies) {
      return;
    }

    _inviteVm = context.read<InviteIslandViewModel>();
    _memoryVm = context.read<MemoryViewModel>();
    _didBindDependencies = true;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<InviteIslandViewModel>();
    final isLoggedIn = Supabase.instance.client.auth.currentUser != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.detail == null
          ? _ErrorState(message: vm.errorMessage ?? '초대 정보를 불러오지 못했어요.')
          : _InviteContent(detail: vm.detail!),
      bottomNavigationBar: vm.detail == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(18, 0, 18, 24),
              child: SizedBox(
                height: 56,
                child: TextButton(
                  onPressed: vm.isJoining
                      ? null
                      : () {
                          if (isLoggedIn) {
                            _handleJoin();
                            return;
                          }

                          setState(() {
                            _waitingForLogin = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('로그인 후 이 화면으로 돌아오면 자동으로 입장해요.'),
                            ),
                          );
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF6EA8EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: vm.isJoining
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          isLoggedIn
                              ? '입장하기'
                              : _waitingForLogin
                              ? '로그인 대기 중'
                              : '로그인 후 입장하기',
                          style: AppFontStyle.M_18.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ),
    );
  }

  Future<void> _handleJoin() async {
    try {
      final detail = await _inviteVm.join();
      final item = detail.toMemoryItem();
      await _memoryVm.insertOrUpdateItem(item);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('기억섬에 입장했어요.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MemoryDetailPage(item: item)),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _InviteContent extends StatelessWidget {
  final IslandInviteDetail detail;

  const _InviteContent({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: detail.bgImageUrl?.isNotEmpty == true
                  ? Image.network(detail.bgImageUrl!, fit: BoxFit.cover)
                  : Container(
                      color: const Color(0xFFE8EDF3),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.landscape_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            detail.name,
            style: AppFontStyle.M_26,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (detail.members.isNotEmpty) _MemberStack(members: detail.members),
          const SizedBox(height: 12),
          Text(
            '기억섬 초대를 받았어요. 입장하면 멤버로 등록되고 바로 섬으로 이동해요.',
            style: AppFontStyle.M_14.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MemberStack extends StatelessWidget {
  final List<MemoryMemberPreview> members;

  const _MemberStack({required this.members});

  @override
  Widget build(BuildContext context) {
    final visibleMembers = members.take(5).toList();

    return SizedBox(
      height: 32,
      width: 32 + ((visibleMembers.length - 1) * 18),
      child: Stack(
        children: [
          for (int index = 0; index < visibleMembers.length; index++)
            Positioned(
              left: index * 18,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE6E6E6),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: visibleMembers[index].avatarUrl?.isNotEmpty == true
                      ? Image.network(
                          visibleMembers[index].avatarUrl!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            visibleMembers[index].nickname.isEmpty
                                ? '?'
                                : visibleMembers[index].nickname[0],
                            style: AppFontStyle.M_14.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;

  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          message,
          style: AppFontStyle.M_16.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
