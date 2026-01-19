import 'package:tcp/features/parent/attendance/data/datasources/parent_attendance_remote_data_source.dart';
import 'package:tcp/features/parent/attendance/data/models/parent_attendance_record_model.dart';
import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';

class ParentAttendanceRemoteDataSourceImpl
    implements ParentAttendanceRemoteDataSource {
  @override
  Future<List<ParentAttendanceRecordModel>> getAttendanceRecords() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return const [
      ParentAttendanceRecordModel(
        date: '5 Jan',
        day: 'Friday',
        status: ParentAttendanceStatus.present,
        subject: 'Mathematics',
        time: '9:00 AM - 10:00 AM',
      ),
      ParentAttendanceRecordModel(
        date: '4 Jan',
        day: 'Thursday',
        status: ParentAttendanceStatus.present,
        subject: 'English',
        time: '9:00 AM - 10:00 AM',
      ),
      ParentAttendanceRecordModel(
        date: '3 Jan',
        day: 'Wednesday',
        status: ParentAttendanceStatus.absent,
        subject: 'Science',
        time: '10:00 AM - 11:00 AM',
      ),
      ParentAttendanceRecordModel(
        date: '2 Jan',
        day: 'Tuesday',
        status: ParentAttendanceStatus.present,
        subject: 'Social Studies',
        time: '11:00 AM - 12:00 PM',
      ),
      ParentAttendanceRecordModel(
        date: '1 Jan',
        day: 'Monday',
        status: ParentAttendanceStatus.holiday,
      ),
      ParentAttendanceRecordModel(
        date: '31 Dec',
        day: 'Sunday',
        status: ParentAttendanceStatus.present,
        subject: 'Computer Science',
        time: '2:00 PM - 3:00 PM',
      ),
      ParentAttendanceRecordModel(
        date: '30 Dec',
        day: 'Saturday',
        status: ParentAttendanceStatus.leave,
      ),
      ParentAttendanceRecordModel(
        date: '29 Dec',
        day: 'Friday',
        status: ParentAttendanceStatus.present,
        subject: 'Hindi',
        time: '10:00 AM - 11:00 AM',
      ),
    ];
  }
}
