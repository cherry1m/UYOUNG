import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class ChangeDayPage extends StatefulWidget {
  const ChangeDayPage({super.key});

  @override
  State<ChangeDayPage> createState() => _ChangeDayPageState();
}

class _ChangeDayPageState extends State<ChangeDayPage> {
  bool _showTimePicker = false;

  int _ampmIndex = 0; // 오전 오후
  int _hour = 4;
  int _minute = 7;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MARK: 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text("취소", style: AppFontStyle.H7),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text("저장", style: AppFontStyle.H7),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // MARK: 원본 / 조정
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _dateRow(
                      title: "원본",
                      value: "2025. 10.12 오전 4:07:23",
                      isDisabled: true,
                    ),
                    const Divider(height: 1),
                    _dateRow(
                      title: "조정",
                      value:
                          "2025. 10.12 ${_ampmIndex == 0 ? '오전' : '오후'} $_hour:${_minute.toString().padLeft(2, '0')}",
                      isDisabled: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // MARK: 달력
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("2025년 8월", style: AppFontStyle.H7),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down, size: 20),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _WeekText("일", color: Colors.red),
                        _WeekText("월"),
                        _WeekText("화"),
                        _WeekText("수"),
                        _WeekText("목"),
                        _WeekText("금"),
                        _WeekText("토", color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(31, (index) {
                        final day = index + 1;
                        final isSelected = day == 16;
                        return Container(
                          width: 36,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6EA8EB)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            "$day",
                            style: AppFontStyle.S7.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF222222),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // MARK: 시간 버튼
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showTimePicker = !_showTimePicker;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("시간", style: AppFontStyle.S8),
                      Text(
                        "${_ampmIndex == 0 ? '오전' : '오후'} $_hour:${_minute.toString().padLeft(2, '0')}",
                        style: AppFontStyle.S7.copyWith(
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // MARK: 시간 피커 팝업
          if (_showTimePicker)
            Positioned(right: 20, bottom: 110, child: _timePickerPopup()),
        ],
      ),
    );
  }

  /// 날짜 행
  Widget _dateRow({
    required String title,
    required String value,
    required bool isDisabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppFontStyle.S8),
          Text(
            value,
            style: AppFontStyle.S8.copyWith(
              color: isDisabled
                  ? const Color(0xFFB0B0B0)
                  : const Color(0xFF222222),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: 시간 피커 팝업
  Widget _timePickerPopup() {
    return Container(
      width: 260,
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _wheelPicker(
            items: const ["오전", "오후"],
            initialIndex: _ampmIndex,
            width: 60,
            onChanged: (i) => setState(() => _ampmIndex = i),
          ),
          _wheelPicker(
            items: List.generate(12, (i) => "${i + 1}"),
            initialIndex: _hour - 1,
            width: 50,
            onChanged: (i) => setState(() => _hour = i + 1),
          ),
          const Text(":", style: TextStyle(fontSize: 18)),
          _wheelPicker(
            items: List.generate(60, (i) => i.toString().padLeft(2, '0')),
            initialIndex: _minute,
            width: 60,
            onChanged: (i) => setState(() => _minute = i),
          ),
        ],
      ),
    );
  }

  /// 휠 피커
  Widget _wheelPicker({
    required List<String> items,
    required int initialIndex,
    required double width,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: width,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 36,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: initialIndex),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                return Center(
                  child: Text(
                    items[index],
                    style: AppFontStyle.H7.copyWith(
                      color: const Color(0xFF222222),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 요일 텍스트
class _WeekText extends StatelessWidget {
  final String text;
  final Color? color;

  const _WeekText(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Center(
        child: Text(
          text,
          style: AppFontStyle.S7.copyWith(
            color: color ?? const Color(0xFF444444),
          ),
        ),
      ),
    );
  }
}
