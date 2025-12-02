import 'package:flutter/material.dart';

class YearMonthPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onSelected;

  const YearMonthPicker({
    Key? key,
    required this.initialDate,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  late int year;

  @override
  void initState() {
    super.initState();
    year = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 연도 변경
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () => setState(() => year--),
            ),
            Text(
              "$year년",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () => setState(() => year++),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // 월 선택
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: List.generate(12, (index) {
              final month = index + 1;

              return GestureDetector(
                onTap: () {
                  widget.onSelected(DateTime(year, month, 1));
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text("$month월", style: const TextStyle(fontSize: 16)),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
