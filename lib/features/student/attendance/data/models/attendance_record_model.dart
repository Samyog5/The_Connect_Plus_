import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel({
    required super.id,
    required super.date,
    required super.day,
    required super.status,
    super.subject,
    super.time,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id'] as String,
      date: json['date'] as String,
      day: json['day'] as String,
      status: _statusFromString(json['status'] as String),
      subject: json['subject'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'day': day,
      'status': status.name,
      'subject': subject,
      'time': time,
    };
  }

  static AttendanceStatus _statusFromString(String status) {
    return AttendanceStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => AttendanceStatus.absent,
    );
  }
}
