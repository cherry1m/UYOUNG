// lib/data/sources/memory/memory_location_dummy.dart
import 'package:flutter/foundation.dart';

@immutable
class MemoryLocationInfo {
  /// 해외: "일본 도쿄", "중국 홍콩", "프랑스 파리" ...
  /// 국내: "서울특별시 중랑구 묵동" (시-구-동)
  final String groupKey;

  /// 실제 타임라인에 찍을 라벨(디테일 포함)
  final String label;

  const MemoryLocationInfo({required this.groupKey, required this.label});
}

class MemoryLocationDummy {
  /// 이미지 경로 -> 위치 정보
  /// (지도 마커용이 아니라, 타임라인 텍스트 정리/그룹핑용)
  static final Map<String, MemoryLocationInfo> infoByKey = {
    // =========================================================
    // 1) 일본팸 ✈️  (일본 도쿄 / 일본 삿포로 / 일본 후쿠오카)
    // =========================================================

    // --- 12/7 도쿄 (3곳: 시부야 / 아사쿠사 / 긴자)
    "assets/images/memory/japan/tokyo7.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo3.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo2.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo5.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo11.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo12.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo14.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo13.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),
    "assets/images/memory/japan/tokyo6.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 시부야구",
    ),

    "assets/images/memory/japan/tokyo20.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 아사쿠사",
    ),
    "assets/images/memory/japan/tokyo21.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 아사쿠사",
    ),
    "assets/images/memory/japan/tokyo17.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 아사쿠사",
    ),
    "assets/images/memory/japan/tokyo16.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 아사쿠사",
    ),
    "assets/images/memory/japan/tokyo10.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 아사쿠사",
    ),

    "assets/images/memory/japan/tokyo27.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo28.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo22.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo18.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo4.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo8.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),
    "assets/images/memory/japan/tokyo9.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 긴자",
    ),

    // --- 12/6 삿포로 (1곳: 오도리공원) / 후쿠오카 (2곳: 하카타 / 텐진)
    "assets/images/memory/japan/Sapporo5.png": MemoryLocationInfo(
      groupKey: "일본 삿포로",
      label: "일본 삿포로 오도리공원",
    ),
    "assets/images/memory/japan/Sapporo3.png": MemoryLocationInfo(
      groupKey: "일본 삿포로",
      label: "일본 삿포로 오도리공원",
    ),
    "assets/images/memory/japan/Sapporo9.png": MemoryLocationInfo(
      groupKey: "일본 삿포로",
      label: "일본 삿포로 오도리공원",
    ),
    "assets/images/memory/japan/Sapporo13.jpeg": MemoryLocationInfo(
      groupKey: "일본 삿포로",
      label: "일본 삿포로 오도리공원",
    ),
    "assets/images/memory/japan/Sapporo8.png": MemoryLocationInfo(
      groupKey: "일본 삿포로",
      label: "일본 삿포로 오도리공원",
    ),

    "assets/images/memory/japan/hukuoka4.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 하카타",
    ),
    "assets/images/memory/japan/hukuoka5.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 하카타",
    ),
    "assets/images/memory/japan/hukuoka6.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 하카타",
    ),
    "assets/images/memory/japan/hukuoka2.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 하카타",
    ),
    "assets/images/memory/japan/hukuoka3.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 하카타",
    ),

    "assets/images/memory/japan/hukuoka7.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 텐진",
    ),
    "assets/images/memory/japan/hukuoka9.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 텐진",
    ),
    "assets/images/memory/japan/hukuoka10.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 텐진",
    ),
    "assets/images/memory/japan/hukuoka14.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 텐진",
    ),
    "assets/images/memory/japan/hukuoka18.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 텐진",
    ),

    // --- 12/5 도쿄(1곳) + 후쿠오카(1곳: 모모치해변)
    "assets/images/memory/japan/tokyo1.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 신주쿠",
    ),
    "assets/images/memory/japan/tokyo10.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 신주쿠",
    ),
    "assets/images/memory/japan/tokyo16.png": MemoryLocationInfo(
      groupKey: "일본 도쿄",
      label: "일본 도쿄 신주쿠",
    ),

    "assets/images/memory/japan/hukuoka19.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 모모치해변",
    ),
    "assets/images/memory/japan/hukuoka20.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 모모치해변",
    ),
    "assets/images/memory/japan/hukuoka21.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 모모치해변",
    ),
    "assets/images/memory/japan/hukuoka22.png": MemoryLocationInfo(
      groupKey: "일본 후쿠오카",
      label: "일본 후쿠오카 모모치해변",
    ),

    // =========================================================
    // 2) 상콩즈 🐼 (중국 홍콩 / 중국 상하이)
    // =========================================================

    // --- 홍콩: 센트럴
    "assets/images/memory/shangkong/hongkong1.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong2.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong3.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong4.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong5.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong6.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong13.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong14.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),
    "assets/images/memory/shangkong/hongkong15.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 센트럴",
    ),

    // --- 홍콩: 침사추이
    "assets/images/memory/shangkong/hongkong16.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong17.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong18.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong19.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong20.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong21.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong22.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong23.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong24.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong25.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),
    "assets/images/memory/shangkong/hongkong26.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 침사추이",
    ),

    // --- 홍콩: 몽콕 (묶어서 최소 3장 이상 유지)
    "assets/images/memory/shangkong/hongkong7.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong8.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong9.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong10.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong11.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong12.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong27.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong28.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong29.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong30.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong31.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong32.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong33.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong34.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong35.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong36.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong37.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong38.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong39.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong40.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong41.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong42.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),
    "assets/images/memory/shangkong/hongkong43.jpeg": MemoryLocationInfo(
      groupKey: "중국 홍콩",
      label: "중국 홍콩 몽콕",
    ),

    // --- 상하이: 와이탄 / 신천지
    "assets/images/memory/shangkong/shanghi1.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),
    "assets/images/memory/shangkong/shanghi2.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),
    "assets/images/memory/shangkong/shanghi3.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),
    "assets/images/memory/shangkong/shanghi4.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),
    "assets/images/memory/shangkong/shanghi5.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),
    "assets/images/memory/shangkong/shanghi6.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 와이탄",
    ),

    "assets/images/memory/shangkong/shanghi7.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi8.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi9.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi10.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi11.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi12.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),
    "assets/images/memory/shangkong/shanghi13.jpeg": MemoryLocationInfo(
      groupKey: "중국 상하이",
      label: "중국 상하이 신천지",
    ),

    // =========================================================
    // 3) 물개 달란트 🐬 (미국령 괌 / 베트남 다낭)
    // =========================================================
    "assets/images/memory/dolphin/guam1.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),
    "assets/images/memory/dolphin/guam2.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),
    "assets/images/memory/dolphin/guam3.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),
    "assets/images/memory/dolphin/guam4.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),
    "assets/images/memory/dolphin/guam5.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),
    "assets/images/memory/dolphin/guam6.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 투몬비치",
    ),

    "assets/images/memory/dolphin/guam7.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 사랑의절벽",
    ),
    "assets/images/memory/dolphin/guam8.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 사랑의절벽",
    ),
    "assets/images/memory/dolphin/guam9.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 사랑의절벽",
    ),
    "assets/images/memory/dolphin/guam10.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 사랑의절벽",
    ),

    "assets/images/memory/dolphin/guam11.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 차모로빌리지",
    ),
    "assets/images/memory/dolphin/guam12.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 차모로빌리지",
    ),
    "assets/images/memory/dolphin/guam13.jpeg": MemoryLocationInfo(
      groupKey: "미국령 괌",
      label: "미국령 괌 차모로빌리지",
    ),

    // 베트남은 이미지 수가 적어서 1곳으로 묶어 3장 이상 유지
    "assets/images/memory/dolphin/vietnam1.jpeg": MemoryLocationInfo(
      groupKey: "베트남 다낭",
      label: "베트남 다낭 미케비치",
    ),
    "assets/images/memory/dolphin/vietnam2.jpeg": MemoryLocationInfo(
      groupKey: "베트남 다낭",
      label: "베트남 다낭 미케비치",
    ),
    "assets/images/memory/dolphin/vietnam3.jpeg": MemoryLocationInfo(
      groupKey: "베트남 다낭",
      label: "베트남 다낭 미케비치",
    ),
    "assets/images/memory/dolphin/vietnam4.jpeg": MemoryLocationInfo(
      groupKey: "베트남 다낭",
      label: "베트남 다낭 미케비치",
    ),
    "assets/images/memory/dolphin/vietnam5.jpeg": MemoryLocationInfo(
      groupKey: "베트남 다낭",
      label: "베트남 다낭 미케비치",
    ),

    // =========================================================
    // 5) 울 애깅 (국내: 시-구-동)
    // =========================================================
    "assets/images/memory/couple/couple1.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple2.JPG": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple3.JPG": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple8.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple9.png": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple13.jpg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),
    "assets/images/memory/couple/couple14.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 묵동",
      label: "서울특별시 중랑구 묵동",
    ),

    "assets/images/memory/couple/couple4.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/couple/couple5.JPG": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/couple/couple10.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/couple/couple11.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/couple/couple15.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/couple/couple16.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),

    "assets/images/memory/couple/couple6.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),
    "assets/images/memory/couple/couple7.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),
    "assets/images/memory/couple/couple12.png": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),
    "assets/images/memory/couple/couple17.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),
    "assets/images/memory/couple/couple18.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),
    "assets/images/memory/couple/couple19.png": MemoryLocationInfo(
      groupKey: "서울특별시 종로구 삼청동",
      label: "서울특별시 종로구 삼청동",
    ),

    // =========================================================
    // 6) 술독 🍻 (국내: 시-구-동)
    // =========================================================
    "assets/images/memory/alcohol/alcohol2.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol3.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol4.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol10.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol11.png": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol12.png": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol13.png": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),
    "assets/images/memory/alcohol/alcohol14.png": MemoryLocationInfo(
      groupKey: "서울특별시 노원구 공릉동",
      label: "서울특별시 노원구 공릉동",
    ),

    "assets/images/memory/alcohol/alcohol5.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 면목동",
      label: "서울특별시 중랑구 면목동",
    ),
    "assets/images/memory/alcohol/alcohol6.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 면목동",
      label: "서울특별시 중랑구 면목동",
    ),
    "assets/images/memory/alcohol/alcohol7.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 면목동",
      label: "서울특별시 중랑구 면목동",
    ),
    "assets/images/memory/alcohol/alcohol15.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 중랑구 면목동",
      label: "서울특별시 중랑구 면목동",
    ),

    "assets/images/memory/alcohol/alcohol8.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 마포구 합정동",
      label: "서울특별시 마포구 합정동",
    ),
    "assets/images/memory/alcohol/alcohol9.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 마포구 합정동",
      label: "서울특별시 마포구 합정동",
    ),
    "assets/images/memory/alcohol/alcohol16.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 마포구 합정동",
      label: "서울특별시 마포구 합정동",
    ),
    "assets/images/memory/alcohol/alcohol17.jpeg": MemoryLocationInfo(
      groupKey: "서울특별시 마포구 합정동",
      label: "서울특별시 마포구 합정동",
    ),

    // =========================================================
    // 7) 유러피안 (프랑스 파리 / 헝가리 부다페스트 / 독일 뮌헨 / 오스트리아 비엔나)
    // =========================================================

    // 12/31 - 헝가리(부다페스트) 2곳
    "assets/images/memory/europe/h1.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 어부의요새",
    ),
    "assets/images/memory/europe/h2.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 어부의요새",
    ),
    "assets/images/memory/europe/h3.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 어부의요새",
    ),
    "assets/images/memory/europe/h4.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 어부의요새",
    ),

    "assets/images/memory/europe/h5.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 세체니다리",
    ),
    "assets/images/memory/europe/h6.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 세체니다리",
    ),
    "assets/images/memory/europe/h7.jpeg": MemoryLocationInfo(
      groupKey: "헝가리 부다페스트",
      label: "헝가리 부다페스트 세체니다리",
    ),

    // 12/31 - 프랑스 파리(에펠탑)
    "assets/images/memory/europe/c1.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 에펠탑",
    ),
    "assets/images/memory/europe/c2.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 에펠탑",
    ),
    "assets/images/memory/europe/c3.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 에펠탑",
    ),
    "assets/images/memory/europe/c4.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 에펠탑",
    ),

    // 12/30 - 파리(몽마르트르 / 루브르) 2곳
    "assets/images/memory/europe/c5.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),
    "assets/images/memory/europe/c6.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),
    "assets/images/memory/europe/c7.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),
    "assets/images/memory/europe/c8.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),
    "assets/images/memory/europe/c13.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),
    "assets/images/memory/europe/c14.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 몽마르트르",
    ),

    "assets/images/memory/europe/c9.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 루브르",
    ),
    "assets/images/memory/europe/c10.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 루브르",
    ),
    "assets/images/memory/europe/c11.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 루브르",
    ),
    "assets/images/memory/europe/c12.jpeg": MemoryLocationInfo(
      groupKey: "프랑스 파리",
      label: "프랑스 파리 루브르",
    ),

    // 12/29 - 독일(뮌헨) / 오스트리아(비엔나)
    "assets/images/memory/europe/ger1.jpeg": MemoryLocationInfo(
      groupKey: "독일 뮌헨",
      label: "독일 뮌헨 마리엔광장",
    ),
    "assets/images/memory/europe/ger2.jpeg": MemoryLocationInfo(
      groupKey: "독일 뮌헨",
      label: "독일 뮌헨 마리엔광장",
    ),
    "assets/images/memory/europe/ger3.jpeg": MemoryLocationInfo(
      groupKey: "독일 뮌헨",
      label: "독일 뮌헨 마리엔광장",
    ),
    "assets/images/memory/europe/ger4.jpeg": MemoryLocationInfo(
      groupKey: "독일 뮌헨",
      label: "독일 뮌헨 마리엔광장",
    ),
    "assets/images/memory/europe/ger5.jpeg": MemoryLocationInfo(
      groupKey: "독일 뮌헨",
      label: "독일 뮌헨 마리엔광장",
    ),

    "assets/images/memory/europe/o1.jpeg": MemoryLocationInfo(
      groupKey: "오스트리아 비엔나",
      label: "오스트리아 비엔나 슈테판광장",
    ),
    "assets/images/memory/europe/o2.jpeg": MemoryLocationInfo(
      groupKey: "오스트리아 비엔나",
      label: "오스트리아 비엔나 슈테판광장",
    ),
    "assets/images/memory/europe/o3.jpeg": MemoryLocationInfo(
      groupKey: "오스트리아 비엔나",
      label: "오스트리아 비엔나 슈테판광장",
    ),
  };
  static MemoryLocationInfo? get(String key) => infoByKey[key];

  /// 위치 더미가 없으면 타임라인에서 "위치정보 없음" 처리용
  static MemoryLocationInfo unknown() =>
      const MemoryLocationInfo(groupKey: "위치정보 없음", label: "위치정보 없음");
}
