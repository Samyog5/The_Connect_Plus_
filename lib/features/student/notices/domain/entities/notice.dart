import 'package:equatable/equatable.dart';

class Notice extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String date;
  final String author;
  final String priority;
  final bool isUnread;

  const Notice({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.author,
    required this.priority,
    this.isUnread = false,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    date,
    author,
    priority,
    isUnread,
  ];
}
