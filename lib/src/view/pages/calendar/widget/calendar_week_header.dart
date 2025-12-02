import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class CalendarWeekHeader extends StatelessWidget {
  const CalendarWeekHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(7, (index) {
              Color color;
              if (index == 0)
                color = AppColors.mainRed;
              else if (index == 6)
                color = AppColors.mainBlue;
              else
                color = const Color(0xFF333333);

              return Expanded(
                child: Center(
                  child: Text(
                    weekdays[index],
                    style: AppFontStyle.M_16.copyWith(color: color),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 7.5),
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          color: const Color(0xFFE8E8EC),
        ),
      ],
    );
  }
}
