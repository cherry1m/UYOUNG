import 'package:flutter/material.dart';

class AppFontStyle {
  static const String _family = 'memomentKkukkkuk';

  // 공통 베이스 스타일
  static TextStyle _base(double size) => TextStyle(
    fontFamily: _family,
    fontSize: size,
    fontWeight: FontWeight.w400,
    height: 1.0,
  );

  // ───────── Stroke + Fill 텍스트 ─────────
  /// S폰트: 기본 텍스트에 흰색 테두리를 얇게 둘러주는 용도
  /// - 텍스트 색(color)은 그대로 사용
  /// - 흰색 shadow 4방향을 줘서 stroke처럼 보이게 처리
  static TextStyle _stroke(double size) => _base(size).copyWith(
    shadows: const [
      Shadow(offset: Offset(0.2, 0), blurRadius: 0, color: Colors.white),
      Shadow(offset: Offset(-0.2, 0), blurRadius: 0, color: Colors.white),
      Shadow(offset: Offset(0, 0.2), blurRadius: 0, color: Colors.white),
      Shadow(offset: Offset(0, -0.2), blurRadius: 0, color: Colors.white),
    ],
  );

  // ───── Headline Font (H1 ~ H10) ─────
  static final TextStyle H1 = _base(28); // Regular 28px
  static final TextStyle H2 = _base(26); // Regular 26px
  static final TextStyle H3 = _base(24); // Regular 24px
  static final TextStyle H4 = _base(22); // Regular 22px
  static final TextStyle H5 = _base(20); // Regular 20px
  static final TextStyle H6 = _base(18); // Regular 18px
  static final TextStyle H7 = _base(16); // Regular 16px
  static final TextStyle H8 = _base(14); // Regular 14px
  static final TextStyle H9 = _base(12); // Regular 12px
  static final TextStyle H10 = _base(10); // Regular 10px

  // ───── Stroke Font (S1 ~ S10) ─────
  /// S폰트는 H폰트에 흰색 테두리가 추가된 버전이라고 생각하면 됨
  static final TextStyle S1 = _stroke(28);
  static final TextStyle S2 = _stroke(26);
  static final TextStyle S3 = _stroke(24);
  static final TextStyle S4 = _stroke(22);
  static final TextStyle S5 = _stroke(20);
  static final TextStyle S6 = _stroke(18);
  static final TextStyle S7 = _stroke(16);
  static final TextStyle S8 = _stroke(14);
  static final TextStyle S9 = _stroke(12);
  static final TextStyle S10 = _stroke(10);

  // ───── 기존 M_XX 스타일을 alias로 매핑 ─────
  static final TextStyle M_28 = H1;
  static final TextStyle M_26 = H2;
  static final TextStyle M_24 = H3;
  static final TextStyle M_22 = H4;
  static final TextStyle M_20 = H5;
  static final TextStyle M_18 = H6;
  static final TextStyle M_16 = H7;
  static final TextStyle M_14 = H8;
  static final TextStyle M_12 = H9;
  static final TextStyle M_10 = H10;
}
