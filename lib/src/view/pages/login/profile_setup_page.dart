import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/app.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/user/profile_form_section.dart';
import 'package:uyoung/src/viewModel/profile/profile_view_model.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadProfile(),
      child: const _ProfileSetupView(),
    );
  }
}

class _ProfileSetupView extends StatelessWidget {
  const _ProfileSetupView();

  Future<void> _save(BuildContext context) async {
    final vm = context.read<ProfileViewModel>();
    final success = await vm.saveProfile();
    if (!context.mounted || !success) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const UyoungApp()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('프로필 설정', style: AppFontStyle.M_26),
                    const SizedBox(height: 10),
                    Text(
                      '처음 시작하기 전에 사용할 닉네임을 입력해주세요.',
                      style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 36),
                    ProfileFormSection(
                      viewModel: vm,
                      onSave: () => _save(context),
                      buttonLabel: '저장하고 시작하기',
                      description: '프로필 이미지는 나중에 다시 바꿀 수 있어요.',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
