import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';

class AssignmentModel extends Assignment {
  const AssignmentModel({
    required super.id,
    required super.subject,
    required super.title,
    required super.remarks,
    required super.dueDate,
    super.isCompleted,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      subject: json['subject'] as String,
      title: json['title'] as String,
      remarks: json['remarks'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'remarks': remarks,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
