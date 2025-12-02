import 'package:flutter/material.dart';

class MemoryIsland {
  final String name;
  final Color color;
  final bool isSelected;

  MemoryIsland(this.name, this.color, this.isSelected);

  MemoryIsland copyWith({bool? isSelected}) {
    return MemoryIsland(name, color, isSelected ?? this.isSelected);
  }
}
