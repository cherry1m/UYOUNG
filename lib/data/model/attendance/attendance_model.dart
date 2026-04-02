enum AttendanceFlowStep {
  idle,
  loading,
  reveal,
  result,
  board,
}

enum AttendanceRewardKind {
  pearl,
  trash,
}

class AttendanceLogEntry {
  const AttendanceLogEntry({
    required this.rewardItem,
  });

  final String rewardItem;

  factory AttendanceLogEntry.fromMap(Map<String, dynamic> map) {
    return AttendanceLogEntry(
      rewardItem: (map['reward_item'] ?? '').toString(),
    );
  }
}
