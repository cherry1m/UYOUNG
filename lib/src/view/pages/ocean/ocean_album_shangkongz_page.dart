import 'package:flutter/material.dart';
import 'package:uyoung/data/app_colors.dart';
import 'package:uyoung/data/font_style.dart';

class OceanAlbumShangKongzPage extends StatelessWidget {
  const OceanAlbumShangKongzPage({super.key});

  @override
  Widget build(BuildContext context) {
    final images = const [
      'assets/images/temp_result_1.png',
      'assets/images/temp_result.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('상콩즈', style: AppFontStyle.H6),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
          child: Wrap(
            spacing: 14, // 가로 간격
            runSpacing: 14, // 세로 간격
            children: images.map((path) {
              return SizedBox(
                width: 114,
                height: 203,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(path, fit: BoxFit.cover),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
