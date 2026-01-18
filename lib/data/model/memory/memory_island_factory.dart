import 'package:flutter/material.dart';
import 'package:uyoung/data/model/memory/memory_post_model.dart';
import 'package:uyoung/data/model/calendar/memory_model.dart';
import 'package:uyoung/data/sources/memory/memory_post_dummy.dart';

class MemoryIslandFactory {
  static List<MemoryIsland> buildIslands() {
    return MemoryPostDummy.postsByMemoryId.entries.map((entry) {
      final memoryId = entry.key;
      final posts = entry.value;

      final Map<MemoryDate, String> thumbnails = {};
      final List<MemoryDate> dates = [];

      int idCounter = 0;

      for (final post in posts) {
        // createdAt: "12월 7일"
        final parts = post.createdAt
            .replaceAll('월', '')
            .replaceAll('일', '')
            .split(' ');

        final month = int.parse(parts[0]);
        final day = int.parse(parts[1]);

        for (final image in post.images) {
          final date = MemoryDate(month, day, id: idCounter++);
          dates.add(date);
          thumbnails[date] = image;
        }
      }

      return MemoryIsland(
        _memoryTitle(memoryId),
        _memoryColor(memoryId),
        true,
        photoDates: dates,
        photoThumbnails: thumbnails,
      );
    }).toList();
  }

  static String _memoryTitle(String id) {
    switch (id) {
      case "1":
        return "일본팸 ✈️";
      case "2":
        return "상콩즈 🐼";
      case "3":
        return "물개 달란트 🐬";
      case "5":
        return "울 애깅 💕";
      case "6":
        return "술독 🍻";
      case "7":
        return "유러피안 🇪🇺";
      default:
        return "기억섬";
    }
  }

  static Color _memoryColor(String id) {
    switch (id) {
      case "1":
        return Colors.pink;
      case "2":
        return Colors.orange;
      case "3":
        return Colors.blue;
      case "5":
        return Colors.pinkAccent;
      case "6":
        return Colors.green;
      case "7":
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}
