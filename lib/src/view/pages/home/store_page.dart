import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';
import 'package:uyoung/data/image_data.dart';
import 'package:uyoung/src/view/pages/home/attend_check_page.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  static const String _defaultPearlCountLabel = '128개';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Image.asset(
                ImagePath.storePage,
                width: screenWidth,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          _pearlBox(context),
          _saveButton(context),
        ],
      ),
    );
  }

  Widget _pearlBox(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AttendCheckPage()),
          );
        },
        child: SizedBox(
          width: 82,
          height: 36,
          child: Stack(
            children: [
              const Image(
                image: AssetImage("assets/images/pearl_box.png"),
                width: 82,
                height: 36,
              ),
              Positioned(
                top: 12,
                left: 39,
                child: Text(
                  // TODO(seongeunii): Replace with the user's live pearl count.
                  _defaultPearlCountLabel,
                  style: AppFontStyle.H8.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Positioned(
      top: 68,
      right: 20,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('저장 기능은 준비 중이에요.')),
            );
        },
        child: Text(
          '저장하기',
          style: AppFontStyle.S8.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
