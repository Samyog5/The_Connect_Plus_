import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceRecord>> getAttendanceRecords();
}
