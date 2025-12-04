import 'package:flutter/material.dart';
import '../calendar/memory_model.dart';

/// 기본 메모리 섬 리스트 (사진 날짜 + 썸네일 포함)
final List<MemoryIsland> defaultMemoryIslands = [
  // ==========================================
  // 1️⃣ 칼챎 - 9/6, 9/11, 9/19, 9/21, 10/11, 10/19, 10/23, 11/2, 12/1
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
    ],
    photoThumbnails: {
      MemoryDate(9, 6): 'assets/images/memory/calcham_0906.png',
      MemoryDate(9, 11): 'assets/images/memory/calcham_0911.png',
      MemoryDate(9, 19): 'assets/images/memory/calcham_0919.png',
      MemoryDate(9, 21): 'assets/images/memory/calcham_0921.png',
      MemoryDate(10, 11): 'assets/images/memory/calcham_1011.png',
      MemoryDate(10, 19): 'assets/images/memory/calcham_1019.png',
      MemoryDate(10, 23): 'assets/images/memory/calcham_1023.png',
      MemoryDate(11, 2): 'assets/images/memory/calcham_1102.png',
      MemoryDate(12, 1): 'assets/images/memory/calcham_1201.png',
    },
  ),

  // ==========================================
  // 2️⃣ 도쿄팸 - 9/1, 9/2
  // ==========================================
  MemoryIsland(
    '도쿄팸 ✈️',
    Colors.pink,
    false,
    photoDates: const [MemoryDate(9, 1), MemoryDate(9, 2)],
    photoThumbnails: {
      MemoryDate(9, 1): 'assets/images/memory/tokyo_0901.png',
      MemoryDate(9, 2): 'assets/images/memory/tokyo_0902.png',
    },
  ),

  // ==========================================
  // 3️⃣ 우.정.포.에.버 - 11/2, 12/1, 12/7
  // ==========================================
  MemoryIsland(
    '우.정.포.에.버',
    Colors.purple,
    false,
    photoDates: const [MemoryDate(11, 2), MemoryDate(12, 1), MemoryDate(12, 7)],
    photoThumbnails: {
      MemoryDate(11, 2): 'assets/images/memory/friend_1102.png',
      MemoryDate(12, 1): 'assets/images/memory/friend_1201.png',
      MemoryDate(12, 7): 'assets/images/memory/friend_1207.png',
    },
  ),

  // ==========================================
  // 4️⃣ 인덕대 술모임 - 9/19, 10/10, 11/3, 11/29, 12/3
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
      MemoryDate(9, 19): 'assets/images/memory/drink_0919.png',
      MemoryDate(10, 10): 'assets/images/memory/drink_1010.png',
      MemoryDate(11, 3): 'assets/images/memory/drink_1103.png',
      MemoryDate(11, 29): 'assets/images/memory/drink_1129.png',
      MemoryDate(12, 3): 'assets/images/memory/drink_1203.png',
    },
  ),

  // ==========================================
  // 5️⃣ 아직 날짜 없는 기억섬들
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
