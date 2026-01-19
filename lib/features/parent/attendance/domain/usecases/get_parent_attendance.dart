import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';
import 'package:tcp/features/parent/attendance/domain/repositories/parent_attendance_repository.dart';

class GetParentAttendance {
  final ParentAttendanceRepository repository;

  GetParentAttendance(this.repository);

  Future<List<ParentAttendanceRecord>> call() {
    return repository.getAttendanceRecords();
  }
}
