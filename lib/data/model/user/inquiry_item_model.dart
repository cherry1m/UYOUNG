class InquiryItem {
  const InquiryItem({
    required this.title,
    required this.status,
    required this.answer,
    required this.createdAt,
  });

  final String title;
  final String status;
  final String? answer;
  final DateTime? createdAt;

  bool get isAnswered => answer != null && answer!.trim().isNotEmpty;

  factory InquiryItem.fromMap(Map<String, dynamic> map) {
    return InquiryItem(
      title: (map['title'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      answer: map['answer'] as String?,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'] as String),
    );
  }
}
