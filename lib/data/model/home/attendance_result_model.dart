class AttendanceResult {
  final String status;
  final bool isWin;
  final int reward;
  final int streak;

  const AttendanceResult({
    required this.status,
    required this.isWin,
    required this.reward,
    required this.streak,
  });

  bool get isSuccess => status == 'success';
  bool get isAlreadyChecked => status == 'already_checked';

  factory AttendanceResult.fromRpc(dynamic response) {
    final map = _normalize(response);

    return AttendanceResult(
      status: (map['status'] ?? '').toString(),
      isWin: _parseBool(map['is_win']),
      reward: _parseInt(map['reward']),
      streak: _parseInt(map['streak']),
    );
  }

  static Map<String, dynamic> _normalize(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response;
    }

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }

    if (response is List && response.isNotEmpty) {
      final first = response.first;
      if (first is Map<String, dynamic>) {
        return first;
      }
      if (first is Map) {
        return Map<String, dynamic>.from(first);
      }
    }

    throw StateError('출석 결과 형식을 해석할 수 없어요.');
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    final raw = value?.toString().toLowerCase();
    return raw == 'true' || raw == '1';
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
