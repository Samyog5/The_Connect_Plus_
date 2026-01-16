import 'package:tcp/features/student/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';
import 'package:tcp/features/student/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AttendanceRecord>> getAttendanceRecords() async {
    return await remoteDataSource.getAttendanceRecords();
  }
}
