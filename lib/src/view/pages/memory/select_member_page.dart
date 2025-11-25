import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class SelectMemberPage extends StatefulWidget {
  const SelectMemberPage({super.key});

  @override
  State<SelectMemberPage> createState() => _SelectMemberPageState();
}

class _SelectMemberPageState extends State<SelectMemberPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allMembers = ["윤채림", "이윤서", "조성은", "최보빈", "한승하"];
  List<String> selectedMembers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  List<String> get filteredMembers {
    if (_searchController.text.isEmpty) return allMembers;
    return allMembers.where((m) => m.contains(_searchController.text)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelected = selectedMembers.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MARK: 선택된 멤버 리스트 (가로 스크롤)
          if (selectedMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedMembers
                      .map((name) => _selectedProfile(name))
                      .toList(),
                ),
              ),
            ),

          // MARK: 검색창
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: _searchField(),
          ),

          const SizedBox(height: 8),

          // MARK: 전체 멤버 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: filteredMembers.length,
              itemBuilder: (_, index) {
                final name = filteredMembers[index];
                final bool isSelected = selectedMembers.contains(name);

                return _memberRow(name, isSelected);
              },
            ),
          ),

          // MARK: 추가하기 버튼
          Container(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                onPressed: hasSelected
                    ? () {
                        Navigator.pop(context, selectedMembers);
                      }
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
                  "추가하기",
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

  // MARK: 멤버 단일 Row
  Widget _memberRow(String name, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedMembers.remove(name) : selectedMembers.add(name);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(name, style: AppFontStyle.M_16)),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6EA8EB) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : const Color(0xFFBDBDBD),
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

  // MARK: 선택된 멤버 원 + 제거
  Widget _selectedProfile(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: GestureDetector(
                  onTap: () => setState(() => selectedMembers.remove(name)),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6EA8EB),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(name, style: AppFontStyle.M_14),
        ],
      ),
    );
  }

  // MARK: 검색창
  Widget _searchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "이름 검색",
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

  // MARK: AppBar
  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text("대화 상대", style: AppFontStyle.M_20),
  );
}
