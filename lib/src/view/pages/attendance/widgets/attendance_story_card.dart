import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

class AttendanceStoryCard extends StatelessWidget {
  const AttendanceStoryCard({
    super.key,
    required this.title,
    required this.body,
    required this.safeBottom,
    required this.assetPath,
    this.onTap,
  });

  final String title;
  final String body;
  final double safeBottom;
  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // Bottom story card on the entry screen.
      left: 16,
      right: 16,
      bottom: safeBottom + 2,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              assetPath,
              width: double.infinity,
              height: 130,
              fit: BoxFit.fill,
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.M_18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      body,
                      style: AppFontStyle.S8.copyWith(
                        color: const Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
