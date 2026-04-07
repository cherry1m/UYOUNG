class UserAsset {
  final int pearlCount;

  const UserAsset({
    required this.pearlCount,
  });

  factory UserAsset.fromMap(Map<String, dynamic> map) {
    final pearlRaw = map['pearl_count'];
    final pearlCount = pearlRaw is int
        ? pearlRaw
        : int.tryParse('$pearlRaw') ?? 0;

    return UserAsset(pearlCount: pearlCount);
  }
}
