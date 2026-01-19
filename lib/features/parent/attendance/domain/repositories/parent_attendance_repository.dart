import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';

abstract class ParentAttendanceRepository {
  Future<List<ParentAttendanceRecord>> getAttendanceRecords();
}
