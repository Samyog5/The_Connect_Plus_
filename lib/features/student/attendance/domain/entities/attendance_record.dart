import 'package:equatable/equatable.dart';

enum AttendanceStatus { present, absent, leave, holiday }

class AttendanceRecord extends Equatable {
  final String id;
  final String date;
  final String day;
  final AttendanceStatus status;
  final String? subject;
  final String? time;

  const AttendanceRecord({
    required this.id,
    required this.date,
    required this.day,
    required this.status,
    this.subject,
    this.time,
  });

  @override
  List<Object?> get props => [id, date, day, status, subject, time];
}
