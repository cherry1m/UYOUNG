import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/model/home/attend_check_model.dart';
import 'package:uyoung/data/sources/home/attend_days_dummy.dart';

class AttendCheckPage extends StatelessWidget {
  const AttendCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 배경
          Positioned.fill(
            child: Image.asset(
              "assets/images/home_check.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 출석 7칸
          _attendBoxes(context),

          /// 하단 말풍선
          _bottomStoryCard(),
        ],
      ),
    );
  }

  // MARK: - 상단 출석 7칸 (AttendDayItem 사용)
  Widget _attendBoxes(BuildContext context) {
    return Positioned(
      top: 110,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: attendDays.map((AttendDayItem item) {
            final bool isToday = item.day == 3; // 3일차 강조

            return GestureDetector(
              onTap: item.isActive && item.page != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.page!),
                      );
                    }
                  : null, // 4일차 이후 클릭 불가
              child: Opacity(
                opacity: item.isActive ? 1.0 : 0.4,
                child: Container(
                  width: 46,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isToday
                          ? const Color(0xFFFFD54F)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.iconPath,
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 4),
                      Text("${item.day}일차", style: AppFontStyle.S8),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // MARK: - 하단 말풍선 카드
  Widget _bottomStoryCard() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 19,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/home_alert_background.png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "해달이 무언가를 밑에서 가져오려 해요\n오늘은 어떤 걸 주워올까요?",
                      style: AppFontStyle.M_18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
