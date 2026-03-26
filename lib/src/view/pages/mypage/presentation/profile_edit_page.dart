import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/common/user/profile_form_section.dart';
import 'package:uyoung/src/viewModel/profile/profile_view_model.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadProfile(),
      child: const _ProfileEditView(),
    );
  }
}

class _ProfileEditView extends StatelessWidget {
  const _ProfileEditView();

  Future<void> _save(BuildContext context) async {
    final vm = context.read<ProfileViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final success = await vm.saveProfile();

    if (!context.mounted) {
      return;
    }

    if (success) {
      messenger.showSnackBar(const SnackBar(content: Text('프로필을 저장했어요.')));
      Navigator.pop(context, true);
    } else if (vm.errorText != null) {
      messenger.showSnackBar(SnackBar(content: Text(vm.errorText!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('프로필 수정', style: AppFontStyle.M_20),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: ProfileFormSection(
                viewModel: vm,
                onSave: () => _save(context),
                buttonLabel: '저장하기',
              ),
            ),
    );
  }
}
