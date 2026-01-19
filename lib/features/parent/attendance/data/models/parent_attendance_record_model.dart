import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';

class ParentAttendanceRecordModel extends ParentAttendanceRecord {
  const ParentAttendanceRecordModel({
    required super.date,
    required super.day,
    required super.status,
    super.subject,
    super.time,
  });
}
