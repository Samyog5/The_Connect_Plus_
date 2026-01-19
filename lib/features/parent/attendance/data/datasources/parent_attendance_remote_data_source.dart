import 'package:tcp/features/parent/attendance/data/models/parent_attendance_record_model.dart';

abstract class ParentAttendanceRemoteDataSource {
  Future<List<ParentAttendanceRecordModel>> getAttendanceRecords();
}
