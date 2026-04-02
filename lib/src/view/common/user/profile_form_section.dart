import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/src/viewModel/profile/profile_view_model.dart';

class ProfileFormSection extends StatelessWidget {
  const ProfileFormSection({
    super.key,
    required this.viewModel,
    required this.onSave,
    required this.buttonLabel,
    this.description,
  });

  final ProfileViewModel viewModel;
  final Future<void> Function() onSave;
  final String buttonLabel;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: const Color(0xFFE6EEF8),
                backgroundImage: viewModel.selectedImageBytes != null
                    ? MemoryImage(viewModel.selectedImageBytes!)
                    : (viewModel.currentAvatarUrl?.trim().isNotEmpty == true
                          ? NetworkImage(viewModel.currentAvatarUrl!.trim())
                          : null) as ImageProvider<Object>?,
                child: viewModel.selectedImageBytes != null ||
                        viewModel.currentAvatarUrl?.trim().isNotEmpty == true
                    ? null
                    : const Icon(Icons.person_outline_rounded, size: 38),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: viewModel.isSaving ? null : viewModel.pickProfileImage,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD9E2EC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                icon: const Icon(Icons.photo_library_outlined, size: 18),
                label: Text('갤러리에서 사진 선택', style: AppFontStyle.M_14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (description != null) ...[
          Text(
            description!,
            textAlign: TextAlign.center,
            style: AppFontStyle.M_14.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
        ],
        Text('닉네임', style: AppFontStyle.M_14),
        const SizedBox(height: 8),
        TextField(
          controller: viewModel.nicknameController,
          onChanged: (_) => viewModel.onNicknameChanged(),
          decoration: InputDecoration(
            hintText: '닉네임을 입력해주세요',
            hintStyle: AppFontStyle.M_16.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE4E7EC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF6EA8EB), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (viewModel.errorText != null) ...[
          const SizedBox(height: 12),
          Text(
            viewModel.errorText!,
            style: AppFontStyle.M_14.copyWith(color: Colors.redAccent),
          ),
        ],
        const SizedBox(height: 28),
        SizedBox(
          height: 56,
          child: TextButton(
            onPressed: viewModel.canSave ? onSave : null,
            style: TextButton.styleFrom(
              backgroundColor: viewModel.canSave
                  ? const Color(0xFF6EA8EB)
                  : const Color(0xFFE5E7EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: viewModel.isSaving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    buttonLabel,
                    style: AppFontStyle.M_18.copyWith(
                      color: viewModel.canSave ? Colors.white : Colors.grey,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
