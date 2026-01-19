class ParentNotice {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isUnread;

  const ParentNotice({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isUnread = false,
  });
}
