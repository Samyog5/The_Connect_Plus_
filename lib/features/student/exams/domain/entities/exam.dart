import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final String id;
  final String subject;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String room;
  final String syllabus;
  final String type; // e.g., "Midterm", "Final", "Quiz"
  final String status; // e.g., "Upcoming", "Completed", "Cancelled"

  const Exam({
    required this.id,
    required this.subject,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.syllabus,
    required this.type,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    subject,
    date,
    startTime,
    endTime,
    room,
    syllabus,
    type,
    status,
  ];
}
