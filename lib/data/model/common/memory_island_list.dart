import 'package:flutter/material.dart';
import '../calendar/memory_model.dart';

/// 기본 메모리 섬 리스트 (사진 날짜 + 썸네일 포함)
final List<MemoryIsland> defaultMemoryIslands = [
  // ==========================================
  // 1️⃣ 칼챎
  // ==========================================
  MemoryIsland(
    '칼챔',
    Colors.amber,
    true,
    photoDates: const [
      MemoryDate(9, 6),
      MemoryDate(9, 11),
      MemoryDate(9, 19),
      MemoryDate(9, 21),
      MemoryDate(10, 11),
      MemoryDate(10, 19),
      MemoryDate(10, 23),
      MemoryDate(11, 2),

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
  // 2️⃣ 도쿄팸
  // ==========================================
  MemoryIsland(
    '일본팸 ✈️',
    Colors.pink,
    false,
    photoDates: const [MemoryDate(9, 1), MemoryDate(9, 2)],
    photoThumbnails: {
      MemoryDate(9, 1): 'assets/images/1.png',
      MemoryDate(9, 2): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 3️⃣ 우.정.포.에.버
  // ==========================================
  MemoryIsland(
    '우.정.포.에.버',
    Colors.purple,
    false,
    photoDates: const [
      MemoryDate(11, 2),

      MemoryDate(12, 1),
      MemoryDate(12, 1, id: 1),
      MemoryDate(12, 1, id: 2),
      MemoryDate(12, 1, id: 3),
      MemoryDate(12, 1, id: 4),

      // 12/7 날짜 (총 5개)
      MemoryDate(12, 7),
      MemoryDate(12, 7, id: 1),
      MemoryDate(12, 7, id: 2),
      MemoryDate(12, 7, id: 3),
      MemoryDate(12, 7, id: 4),
    ],
    photoThumbnails: {
      MemoryDate(11, 2): 'assets/images/1.png',

      MemoryDate(12, 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 1): 'assets/images/1.png',
      MemoryDate(12, 1, id: 2): 'assets/images/1.png',
      MemoryDate(12, 1, id: 3): 'assets/images/1.png',
      MemoryDate(12, 1, id: 4): 'assets/images/1.png',

      // 12/7 — 동일 날짜, id로 구분된 5장
      MemoryDate(12, 7): 'assets/images/1.png',
      MemoryDate(12, 7, id: 1): 'assets/images/1.png',
      MemoryDate(12, 7, id: 2): 'assets/images/1.png',
      MemoryDate(12, 7, id: 3): 'assets/images/1.png',
      MemoryDate(12, 7, id: 4): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 4️⃣ 인덕대 술모임
  // ==========================================
  MemoryIsland(
    '인덕대 술모임🍺',
    Colors.green,
    true,
    photoDates: const [
      MemoryDate(9, 19),
      MemoryDate(10, 10),
      MemoryDate(11, 3),
      MemoryDate(11, 29),
      MemoryDate(12, 3),
    ],
    photoThumbnails: {
      MemoryDate(9, 19): 'assets/images/1.png',
      MemoryDate(10, 10): 'assets/images/1.png',
      MemoryDate(11, 3): 'assets/images/1.png',
      MemoryDate(11, 29): 'assets/images/1.png',
      MemoryDate(12, 3): 'assets/images/1.png',
    },
  ),

  // ==========================================
  // 5️⃣ 기타 섬
  // ==========================================
  MemoryIsland(
    '한승하',
    Colors.lightBlue,
    false,
    photoDates: const [],
    photoThumbnails: const {},
  ),

  MemoryIsland(
    '최보빈',
    Colors.blueGrey,
    false,
    photoDates: const [],
    photoThumbnails: const {},
  ),
];
