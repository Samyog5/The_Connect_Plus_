import '../../domain/entities/notice.dart';

class NoticeModel extends Notice {
  const NoticeModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.date,
    required super.author,
    required super.priority,
    super.isUnread,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      author: json['author'] as String,
      priority: json['priority'] as String,
      isUnread: json['isUnread'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'date': date,
      'author': author,
      'priority': priority,
      'isUnread': isUnread,
    };
  }
}
