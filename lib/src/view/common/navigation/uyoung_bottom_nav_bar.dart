import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/image_data.dart';

class UyoungBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const UyoungBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.gray_03, width: 1.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final isActive = index == currentIndex;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(index),
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: ImageData(
                      path: _iconPathForIndex(index, isActive),
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _iconPathForIndex(int index, bool isActive) {
    switch (index) {
      case 0:
        return isActive ? ImagePath.homeOn : ImagePath.homeOff;
      case 1:
        return isActive ? ImagePath.roomOn : ImagePath.roomOff;
      case 2:
        return isActive ? ImagePath.calendarOn : ImagePath.calendarOff;
      case 3:
        return isActive ? ImagePath.diaryOn : ImagePath.diaryOff;
      case 4:
        return isActive ? ImagePath.myPageOn : ImagePath.myPageOff;
      default:
        return ImagePath.homeOff;
    }
  }
}
