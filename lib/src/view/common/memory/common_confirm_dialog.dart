import 'package:flutter/material.dart';
import 'package:uyoung/data/font_style.dart';

Future<void> showCommonConfirmDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String confirmLabel,
  required String cancelLabel,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),

        title: SizedBox(
          width: 330,
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/images/warning.png'),
                width: 50,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppFontStyle.M_22,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: AppFontStyle.M_20.copyWith(color: Color(0xFF707070)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F1F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    cancelLabel,
                    style: AppFontStyle.M_18.copyWith(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF6EA8EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  child: Text(
                    confirmLabel,
                    style: AppFontStyle.M_18.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
