import 'package:flutter/material.dart';

/// 월/일만 가지고 있는 날짜 정보
class MemoryDate {
  final int month;
  final int day;
  final int id; // 같은 날짜 내에서 여러 사진을 구분하는 key

  const MemoryDate(this.month, this.day, {this.id = 0});

  bool isSameDay(DateTime date) => date.month == month && date.day == day;

  @override
  bool operator ==(Object other) {
    return other is MemoryDate &&
        other.month == month &&
        other.day == day &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(month, day, id);
}

/// 기억섬 모델
class MemoryIsland {
  final String name;
  final Color color;
  final bool isSelected;
  final bool alertEnabled;

  /// 사진이 있는 날짜 리스트
  final List<MemoryDate> photoDates;

  /// 특정 날짜 → 썸네일 경로
  final Map<MemoryDate, String> photoThumbnails;

  const MemoryIsland(
    this.name,
    this.color,
    this.isSelected, {
    this.alertEnabled = false,
    this.photoDates = const [],
    this.photoThumbnails = const {},
  });

  MemoryIsland copyWith({
    String? name,
    Color? color,
    bool? isSelected,
    bool? alertEnabled,
    List<MemoryDate>? photoDates,
    Map<MemoryDate, String>? photoThumbnails,
  }) {
    return MemoryIsland(
      name ?? this.name,
      color ?? this.color,
      isSelected ?? this.isSelected,
      alertEnabled: alertEnabled ?? this.alertEnabled,
      photoDates: photoDates ?? this.photoDates,
      photoThumbnails: photoThumbnails ?? this.photoThumbnails,
    );
  }
}
