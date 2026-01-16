import 'package:tcp/features/student/exams/domain/entities/exam.dart';

class ExamModel extends Exam {
  const ExamModel({
    required super.id,
    required super.subject,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.room,
    required super.syllabus,
    required super.type,
    required super.status,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      subject: json['subject'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      room: json['room'],
      syllabus: json['syllabus'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'syllabus': syllabus,
      'type': type,
      'status': status,
    };
  }
}
