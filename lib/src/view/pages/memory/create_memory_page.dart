import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/view/pages/memory/memory_creation_result.dart';
import 'package:uyoung/src/view/pages/memory/select_member_page.dart';
import 'package:uyoung/src/viewModel/memory/create_memory_view_model.dart';

class CreateMemoryPage extends StatelessWidget {
  const CreateMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateMemoryViewModel(),
      child: const _CreateMemoryStepOneView(),
    );
  }
}

class _CreateMemoryStepOneView extends StatelessWidget {
  const _CreateMemoryStepOneView();

  Future<void> _pickImage(BuildContext context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !context.mounted) {
      return;
    }

    await context.read<CreateMemoryViewModel>().setSelectedImage(file);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CreateMemoryViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(context, vm),
            const SizedBox(height: 28),
            _contentSection(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context, CreateMemoryViewModel vm) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: vm.selectedImageBytes == null
              ? Container(
                  color: const Color(0xFFE6E6E6),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                )
              : Image.memory(vm.selectedImageBytes!, fit: BoxFit.cover),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0,
          child: _headerBar(context),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: _galleryButton(() => _pickImage(context)),
        ),
      ],
    );
  }

  Widget _headerBar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 22,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '기억섬 만들기',
                  style: AppFontStyle.M_20.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  Widget _contentSection(BuildContext context, CreateMemoryViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('어떤 기억을 담을\n섬을 만들까요?', style: AppFontStyle.M_26),
          const SizedBox(height: 8),
          Text(
            '바다 위에 새로운 섬이 떠오르고 있어요.',
            style: AppFontStyle.M_14.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 28),
          _memoryNameField(vm),
          const SizedBox(height: 28),
          _colorPaletteSection(vm),
          const SizedBox(height: 32),
          _nextButton(context, vm),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _memoryNameField(CreateMemoryViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기억섬 이름', style: AppFontStyle.M_14),
        const SizedBox(height: 8),
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 1,
                  color: vm.titleController.text.isEmpty
                      ? Colors.grey
                      : const Color(0xFF6EA8EB),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: vm.titleController,
                    onChanged: (_) => vm.onTitleChanged(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        CreateMemoryViewModel.maxTitleLength,
                      ),
                    ],
                    style: AppFontStyle.M_16.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: '비워두면 친구 이름으로 자동 생성돼요',
                      hintStyle: AppFontStyle.M_16.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${vm.titleController.text.length}/${CreateMemoryViewModel.maxTitleLength}',
                    style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorPaletteSection(CreateMemoryViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기억섬 컬러', style: AppFontStyle.M_14),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: CreateMemoryViewModel.palette.map((color) {
            final isSelected = vm.selectedColor == color;
            return GestureDetector(
              onTap: () => vm.setColor(color),
              child: Container(
                width: 34,
                height: 34,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _hexToColor(color),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context, CreateMemoryViewModel vm) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: vm.canProceedToMembers
            ? () async {
                final result = await Navigator.push<MemoryCreationResult>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: vm,
                      child: const SelectMemberPage(),
                    ),
                  ),
                );

                if (!context.mounted || result == null) {
                  return;
                }

                Navigator.pop(context, result);
              }
            : null,
        style: TextButton.styleFrom(
          backgroundColor: vm.canProceedToMembers
              ? const Color(0xFF6EA8EB)
              : const Color(0xFFE0E0E0),
          disabledBackgroundColor: const Color(0xFFE0E0E0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          '다음',
          style: AppFontStyle.M_18.copyWith(
            color: vm.canProceedToMembers ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _galleryButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.photo_camera_outlined, color: Colors.white),
      ),
    );
  }

  Color _hexToColor(String hex) {
    final normalized = hex.replaceFirst('#', '');
    return Color(int.parse('FF$normalized', radix: 16));
  }
}
