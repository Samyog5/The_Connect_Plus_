import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';
import 'package:tcp/features/student/attendance/domain/repositories/attendance_repository.dart';

class GetAttendanceRecords {
  final AttendanceRepository repository;

  GetAttendanceRecords(this.repository);

  Future<List<AttendanceRecord>> call() async {
    return await repository.getAttendanceRecords();
  }
}
