import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/memory/invitee_user_model.dart';
import 'package:uyoung/src/view/pages/memory/select_member_page.dart';
import 'package:uyoung/src/viewModel/memory/memeory_view_model.dart';

class CreateMemoryPage extends StatefulWidget {
  const CreateMemoryPage({super.key});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  static const int _maxTitleLength = 12;
  static const List<String> _palette = [
    '#FF6B6B',
    '#FF8E72',
    '#FFB26B',
    '#FFD56B',
    '#F4E76E',
    '#A4D96C',
    '#5FCD8C',
    '#54D2C6',
    '#6FD3FF',
    '#6EA8EB',
    '#7C93FF',
    '#9A7CFF',
    '#B780FF',
    '#E08EFF',
    '#FF94C2',
    '#D7B48C',
    '#B6BDC6',
    '#8B9AA9',
    '#5D6D7E',
    '#2D3A4A',
  ];

  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  List<InviteeUser> _selectedMembers = [];
  String? _selectedColor;
  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canSubmit => _selectedColor != null;

  Future<void> _pickImage() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    final bytes = await file.readAsBytes();
    setState(() {
      _selectedImage = file;
      _selectedImageBytes = bytes;
    });
  }

  Future<void> _selectMembers() async {
    final result = await Navigator.push<List<InviteeUser>>(
      context,
      MaterialPageRoute(
        builder: (_) => SelectMemberPage(initialSelectedMembers: _selectedMembers),
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {
      _selectedMembers = result;
    });
  }

  Future<void> _submit() async {
    if (!_canSubmit) {
      return;
    }

    final vm = context.read<MemoryViewModel>();

    try {
      final islandId = await vm.createIsland(
        islandName: _titleController.text,
        color: _selectedColor!,
        backgroundImage: _selectedImage,
        invitees: _selectedMembers,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('기억섬이 생성됐어요. ID: $islandId')),
      );
      Navigator.pop(context);
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
    final vm = context.watch<MemoryViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(context),
            const SizedBox(height: 28),
            _contentSection(context, vm.isSubmitting),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: _selectedImageBytes == null
              ? Container(
                  color: const Color(0xFFE6E6E6),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                )
              : Image.memory(_selectedImageBytes!, fit: BoxFit.cover),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0,
          child: _headerBar(context),
        ),
        Positioned(bottom: 16, right: 16, child: _galleryButton()),
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

  Widget _contentSection(BuildContext context, bool isSubmitting) {
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
          const SizedBox(height: 20),
          _memberProfiles(),
          const SizedBox(height: 28),
          _memoryNameField(),
          const SizedBox(height: 28),
          _colorPaletteSection(),
          const SizedBox(height: 32),
          _confirmButton(isSubmitting),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _memberProfiles() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(onTap: _selectMembers, child: _addProfileButton()),
        const SizedBox(width: 16),
        Expanded(
          child: _selectedMembers.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    '초대할 멤버를 선택하면 여기에 표시돼요.',
                    style: AppFontStyle.M_14.copyWith(color: Colors.grey),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _selectedMembers
                        .map(
                          (member) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _selectedProfile(member),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _memoryNameField() {
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
                  color: _titleController.text.isEmpty
                      ? Colors.grey
                      : const Color(0xFF6EA8EB),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    focusNode: _focusNode,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(_maxTitleLength),
                    ],
                    style: AppFontStyle.M_16.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: '비워두면 자동으로 이름이 생성돼요',
                      hintStyle: AppFontStyle.M_16.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${_titleController.text.length}/$_maxTitleLength',
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

  Widget _colorPaletteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기억섬 컬러', style: AppFontStyle.M_14),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _palette.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
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

  Widget _confirmButton(bool isSubmitting) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: !_canSubmit || isSubmitting ? null : _submit,
        style: TextButton.styleFrom(
          backgroundColor: _canSubmit
              ? const Color(0xFF6EA8EB)
              : const Color(0xFFE0E0E0),
          disabledBackgroundColor: const Color(0xFFE0E0E0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Text(
                '기억섬 만들기',
                style: AppFontStyle.M_18.copyWith(
                  color: _canSubmit ? Colors.white : Colors.grey,
                ),
              ),
      ),
    );
  }

  Widget _addProfileButton() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FA),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE4EBF2)),
      ),
      child: const Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF6EA8EB)),
    );
  }

  Widget _selectedProfile(InviteeUser member) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE6E6E6),
              backgroundImage: member.avatarUrl?.isNotEmpty == true
                  ? NetworkImage(member.avatarUrl!)
                  : null,
              child: member.avatarUrl?.isNotEmpty == true
                  ? null
                  : Text(
                      member.nickname.isEmpty ? '?' : member.nickname[0],
                      style: AppFontStyle.M_18.copyWith(color: Colors.black54),
                    ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMembers.removeWhere((user) => user.id == member.id);
                  });
                },
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
        Text(member.nickname, style: AppFontStyle.M_14),
      ],
    );
  }

  Widget _galleryButton() {
    return GestureDetector(
      onTap: _pickImage,
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
