import 'package:flutter/material.dart';
import '../calendar/memory_model.dart';

/// 기본 메모리 섬 리스트 (사진 날짜 + 썸네일 포함)
final List<MemoryIsland> defaultMemoryIslands = [
  // ==========================================
  // 1️⃣ 일본팸 ✈️  (MemoryId: "1")
  // - 12/5, 12/6, 12/7 (MemoryPostDummy 반영)
  // - 9/1, 9/2 (기존 assets/images/1.png 유지)
  // ==========================================
  MemoryIsland(
    '일본팸 ✈️',
    Colors.pink,
    false,
    photoDates: [
      // ✅ 12월 이후 (더미 반영)
      MemoryDate(12, 7),
      MemoryDate(12, 7, id: 1),
      MemoryDate(12, 7, id: 2),
      MemoryDate(12, 7, id: 3),
      MemoryDate(12, 7, id: 4),
      MemoryDate(12, 7, id: 5),

      MemoryDate(12, 6),
      MemoryDate(12, 6, id: 1),
      MemoryDate(12, 6, id: 2),
      MemoryDate(12, 6, id: 3),

      MemoryDate(12, 5),
      MemoryDate(12, 5, id: 1),
      MemoryDate(12, 5, id: 2),

      // ✅ 12월 이전(기존 placeholder 유지)
      MemoryDate(9, 1),
      MemoryDate(9, 2),
    ],
    photoThumbnails: {
      // 12/7 (tokyo posts 중 일부 이미지들)
      MemoryDate(12, 7): 'assets/images/memory/japan/tokyo7.png',
      MemoryDate(12, 7, id: 1): 'assets/images/memory/japan/tokyo11.png',
      MemoryDate(12, 7, id: 2): 'assets/images/memory/japan/tokyo27.png',
      MemoryDate(12, 7, id: 3): 'assets/images/memory/japan/tokyo3.png',
      MemoryDate(12, 7, id: 4): 'assets/images/memory/japan/tokyo12.png',
      MemoryDate(12, 7, id: 5): 'assets/images/memory/japan/tokyo22.png',

      // 12/6 (Sapporo + tokyo + hukuoka)
      MemoryDate(12, 6): 'assets/images/memory/japan/Sapporo5.png',
      MemoryDate(12, 6, id: 1): 'assets/images/memory/japan/tokyo9.png',
      MemoryDate(12, 6, id: 2): 'assets/images/memory/japan/hukuoka4.png',
      MemoryDate(12, 6, id: 3): 'assets/images/memory/japan/hukuoka18.png',

      // 12/5
      MemoryDate(12, 5): 'assets/images/memory/japan/tokyo1.png',
      MemoryDate(12, 5, id: 1): 'assets/images/memory/japan/hukuoka2.png',
      MemoryDate(12, 5, id: 2): 'assets/images/memory/japan/hukuoka19.png',

      // 9월 기존 placeholder 유지
      MemoryDate(9, 1): 'assets/images/1.png',
      MemoryDate(9, 2): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 2️⃣ 상콩즈 🐼  (MemoryId: "2")
  // - 12/10 ~ 12/13 (MemoryPostDummy 반영)
  // ==========================================
  MemoryIsland(
    '상콩즈 🐼',
    Colors.orange,
    true,
    photoDates: [
      MemoryDate(12, 13),
      MemoryDate(12, 13, id: 1),
      MemoryDate(12, 13, id: 2),

      MemoryDate(12, 12),
      MemoryDate(12, 12, id: 1),
      MemoryDate(12, 12, id: 2),

      MemoryDate(12, 11),
      MemoryDate(12, 11, id: 1),
      MemoryDate(12, 11, id: 2),

      MemoryDate(12, 10),
      MemoryDate(12, 10, id: 1),
      MemoryDate(12, 10, id: 2),
    ],
    photoThumbnails: {
      // 12/13
      MemoryDate(12, 13): 'assets/images/memory/shangkong/hongkong16.jpeg',
      MemoryDate(12, 13, id: 1):
          'assets/images/memory/shangkong/hongkong21.jpeg',
      MemoryDate(12, 13, id: 2):
          'assets/images/memory/shangkong/hongkong24.jpeg',

      // 12/12
      MemoryDate(12, 12): 'assets/images/memory/shangkong/hongkong27.jpeg',
      MemoryDate(12, 12, id: 1):
          'assets/images/memory/shangkong/hongkong30.jpeg',
      MemoryDate(12, 12, id: 2): 'assets/images/memory/shangkong/shanghi1.jpeg',

      // 12/11
      MemoryDate(12, 11): 'assets/images/memory/shangkong/shanghi7.jpeg',
      MemoryDate(12, 11, id: 1):
          'assets/images/memory/shangkong/hongkong1.jpeg',
      MemoryDate(12, 11, id: 2):
          'assets/images/memory/shangkong/hongkong7.jpeg',

      // 12/10
      MemoryDate(12, 10): 'assets/images/memory/shangkong/hongkong13.jpeg',
      MemoryDate(12, 10, id: 1):
          'assets/images/memory/shangkong/hongkong35.jpeg',
      MemoryDate(12, 10, id: 2):
          'assets/images/memory/shangkong/hongkong40.jpeg',
    },
  ),

  // ==========================================
  // 3️⃣ 물개 달란트 🐬 (MemoryId: "3")
  // - 12/17, 12/19 (MemoryPostDummy 반영)
  // ==========================================
  MemoryIsland(
    '물개 달란트 🐬',
    Colors.blue,
    false,
    photoDates: [
      MemoryDate(12, 19),
      MemoryDate(12, 19, id: 1),
      MemoryDate(12, 19, id: 2),

      MemoryDate(12, 17),
      MemoryDate(12, 17, id: 1),
      MemoryDate(12, 17, id: 2),
    ],
    photoThumbnails: {
      // 12/19
      MemoryDate(12, 19): 'assets/images/memory/dolphin/guam1.jpeg',
      MemoryDate(12, 19, id: 1): 'assets/images/memory/dolphin/guam4.jpeg',
      MemoryDate(12, 19, id: 2): 'assets/images/memory/dolphin/guam7.jpeg',

      // 12/17
      MemoryDate(12, 17): 'assets/images/memory/dolphin/guam11.jpeg',
      MemoryDate(12, 17, id: 1): 'assets/images/memory/dolphin/vietnam1.jpeg',
      MemoryDate(12, 17, id: 2): 'assets/images/memory/dolphin/vietnam4.jpeg',
    },
  ),

  // ==========================================
  // 4️⃣ 칼챔 (MemoryId: "4"는 postsByMemoryId에 없음)
  // - 기존 placeholder(assets/images/1.png) 데이터 유지
  // ==========================================
  MemoryIsland(
    '칼챔',
    Colors.amber,
    false,
    photoDates: [
      MemoryDate(9, 6),
      MemoryDate(9, 11),
      MemoryDate(9, 19),
      MemoryDate(9, 21),
      MemoryDate(10, 11),
      MemoryDate(10, 19),
      MemoryDate(10, 23),
      MemoryDate(11, 2),

      // 12/1 여러장 테스트용(기존 유지)
      MemoryDate(12, 1),
      MemoryDate(12, 1, id: 1),
      MemoryDate(12, 1, id: 2),
      MemoryDate(12, 1, id: 3),
      MemoryDate(12, 1, id: 4),
      MemoryDate(12, 1, id: 5),
      MemoryDate(12, 1, id: 6),
      MemoryDate(12, 1, id: 7),
      MemoryDate(12, 1, id: 8),
    ],
    photoThumbnails: {
      MemoryDate(9, 6): 'assets/images/1.png',
      MemoryDate(9, 11): 'assets/images/1.png',
      MemoryDate(9, 19): 'assets/images/1.png',
      MemoryDate(9, 21): 'assets/images/1.png',
      MemoryDate(10, 11): 'assets/images/1.png',
      MemoryDate(10, 19): 'assets/images/1.png',
      MemoryDate(10, 23): 'assets/images/1.png',
      MemoryDate(11, 2): 'assets/images/1.png',

      MemoryDate(12, 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 2): 'assets/images/1.png',
      MemoryDate(12, 1, id: 3): 'assets/images/1.png',
      MemoryDate(12, 1, id: 4): 'assets/images/1.png',
      MemoryDate(12, 1, id: 5): 'assets/images/1.png',
      MemoryDate(12, 1, id: 6): 'assets/images/1.png',
      MemoryDate(12, 1, id: 7): 'assets/images/1.png',
      MemoryDate(12, 1, id: 8): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 5️⃣ 울 애깅 (MemoryId: "5")
  // - 12/20, 12/22, 12/24 (MemoryPostDummy 반영)
  // - 기존 우정포에버 placeholder 데이터(11/2, 12/1, 12/7) 유지해서 여기로 이관
  // ==========================================
  MemoryIsland(
    '울 애깅',
    Colors.pinkAccent,
    false,
    photoDates: [
      // ✅ 12월 이후 (더미 반영)
      MemoryDate(12, 24),
      MemoryDate(12, 24, id: 1),
      MemoryDate(12, 24, id: 2),

      MemoryDate(12, 22),
      MemoryDate(12, 22, id: 1),
      MemoryDate(12, 22, id: 2),

      MemoryDate(12, 20),
      MemoryDate(12, 20, id: 1),
      MemoryDate(12, 20, id: 2),

      // ✅ 12월 이전(기존 placeholder 유지: 구 우정포에버 데이터 이관)
      MemoryDate(11, 2),

      MemoryDate(12, 1),
      MemoryDate(12, 1, id: 1),
      MemoryDate(12, 1, id: 2),
      MemoryDate(12, 1, id: 3),
      MemoryDate(12, 1, id: 4),

      MemoryDate(12, 7),
      MemoryDate(12, 7, id: 1),
      MemoryDate(12, 7, id: 2),
      MemoryDate(12, 7, id: 3),
      MemoryDate(12, 7, id: 4),
    ],
    photoThumbnails: {
      // 12/24
      MemoryDate(12, 24): 'assets/images/memory/couple/couple1.jpeg',
      MemoryDate(12, 24, id: 1): 'assets/images/memory/couple/couple4.jpeg',
      MemoryDate(12, 24, id: 2): 'assets/images/memory/couple/couple6.jpeg',

      // 12/22
      MemoryDate(12, 22): 'assets/images/memory/couple/couple8.jpeg',
      MemoryDate(12, 22, id: 1): 'assets/images/memory/couple/couple10.jpeg',
      MemoryDate(12, 22, id: 2): 'assets/images/memory/couple/couple12.png',

      // 12/20
      MemoryDate(12, 20): 'assets/images/memory/couple/couple13.jpg',
      MemoryDate(12, 20, id: 1): 'assets/images/memory/couple/couple15.jpeg',
      MemoryDate(12, 20, id: 2): 'assets/images/memory/couple/couple17.jpeg',

      // 구 우정포에버 placeholder 유지
      MemoryDate(11, 2): 'assets/images/1.png',

      MemoryDate(12, 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 2): 'assets/images/1.png',
      MemoryDate(12, 1, id: 3): 'assets/images/1.png',
      MemoryDate(12, 1, id: 4): 'assets/images/1.png',

      MemoryDate(12, 7): 'assets/images/1.png',
      MemoryDate(12, 7, id: 1): 'assets/images/1.png',
      MemoryDate(12, 7, id: 2): 'assets/images/1.png',
      MemoryDate(12, 7, id: 3): 'assets/images/1.png',
      MemoryDate(12, 7, id: 4): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 6️⃣ 술독 🍻 (MemoryId: "6")
  // - 12/24, 12/26, 12/27 (MemoryPostDummy 반영)
  // - 기존 인덕대 술모임 placeholder 데이터(9/19,10/10,11/3,11/29,12/3) 유지해서 여기로 이관
  // ==========================================
  MemoryIsland(
    '술독 🍻',
    Colors.green,
    false,
    photoDates: [
      // ✅ 12월 이후 (더미 반영)
      MemoryDate(12, 27),
      MemoryDate(12, 27, id: 1),
      MemoryDate(12, 27, id: 2),

      MemoryDate(12, 26),
      MemoryDate(12, 26, id: 1),
      MemoryDate(12, 26, id: 2),

      MemoryDate(12, 24),
      MemoryDate(12, 24, id: 1),

      // ✅ 12월 이전(기존 placeholder 유지: 구 인덕대 술모임 이관)
      MemoryDate(9, 19),
      MemoryDate(10, 10),
      MemoryDate(11, 3),
      MemoryDate(11, 29),
      MemoryDate(12, 3),
    ],
    photoThumbnails: {
      // 12/27
      MemoryDate(12, 27): 'assets/images/memory/alcohol/alcohol2.jpeg',
      MemoryDate(12, 27, id: 1): 'assets/images/memory/alcohol/alcohol5.jpeg',
      MemoryDate(12, 27, id: 2): 'assets/images/memory/alcohol/alcohol8.jpeg',

      // 12/26
      MemoryDate(12, 26): 'assets/images/memory/alcohol/alcohol10.jpeg',
      MemoryDate(12, 26, id: 1): 'assets/images/memory/alcohol/alcohol11.png',
      MemoryDate(12, 26, id: 2): 'assets/images/memory/alcohol/alcohol15.jpeg',

      // 12/24
      MemoryDate(12, 24): 'assets/images/memory/alcohol/alcohol16.jpeg',
      MemoryDate(12, 24, id: 1): 'assets/images/memory/alcohol/alcohol17.jpeg',

      // 구 인덕대 술모임 placeholder 유지
      MemoryDate(9, 19): 'assets/images/1.png',
      MemoryDate(10, 10): 'assets/images/1.png',
      MemoryDate(11, 3): 'assets/images/1.png',
      MemoryDate(11, 29): 'assets/images/1.png',
      MemoryDate(12, 3): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 7️⃣ 유러피안 (MemoryId: "7")
  // - 12/29, 12/30, 12/31 (MemoryPostDummy 반영)
  // (더미에 경로 앞 공백/createdAt 오타가 있으니, 여기선 정상 경로로만 사용)
  // ==========================================
  MemoryIsland(
    '유러피안',
    Colors.indigo,
    false,
    photoDates: [
      MemoryDate(12, 31),
      MemoryDate(12, 31, id: 1),
      MemoryDate(12, 31, id: 2),

      MemoryDate(12, 30),
      MemoryDate(12, 30, id: 1),
      MemoryDate(12, 30, id: 2),

      MemoryDate(12, 29),
      MemoryDate(12, 29, id: 1),
    ],
    photoThumbnails: {
      // 12/31
      MemoryDate(12, 31): 'assets/images/memory/europe/h1.jpeg',
      MemoryDate(12, 31, id: 1): 'assets/images/memory/europe/h5.jpeg',
      MemoryDate(12, 31, id: 2): 'assets/images/memory/europe/c1.jpeg',

      // 12/30
      MemoryDate(12, 30): 'assets/images/memory/europe/c5.jpeg',
      MemoryDate(12, 30, id: 1): 'assets/images/memory/europe/c9.jpeg',
      MemoryDate(12, 30, id: 2): 'assets/images/memory/europe/c13.jpeg',

      // 12/29
      MemoryDate(12, 29): 'assets/images/memory/europe/ger1.jpeg',
      MemoryDate(12, 29, id: 1): 'assets/images/memory/europe/o1.jpeg',
    },
  ),
];
