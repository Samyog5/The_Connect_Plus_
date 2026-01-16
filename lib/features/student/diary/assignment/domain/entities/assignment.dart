import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String id;
  final String subject;
  final String title;
  final String remarks;
  final DateTime dueDate;
  final bool isCompleted;

  const Assignment({
    required this.id,
    required this.subject,
    required this.title,
    required this.remarks,
    required this.dueDate,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
    id,
    subject,
    title,
    remarks,
    dueDate,
    isCompleted,
  ];
}
