import 'package:tcp/features/parent/attendance/data/datasources/parent_attendance_remote_data_source.dart';
import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';
import 'package:tcp/features/parent/attendance/domain/repositories/parent_attendance_repository.dart';

class ParentAttendanceRepositoryImpl implements ParentAttendanceRepository {
  final ParentAttendanceRemoteDataSource remoteDataSource;

  ParentAttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ParentAttendanceRecord>> getAttendanceRecords() {
    return remoteDataSource.getAttendanceRecords();
  }
}
