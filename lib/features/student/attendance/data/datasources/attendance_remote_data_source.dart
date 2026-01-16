import 'package:tcp/features/student/attendance/data/models/attendance_record_model.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceRecordModel>> getAttendanceRecords();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  @override
  Future<List<AttendanceRecordModel>> getAttendanceRecords() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      const AttendanceRecordModel(
        id: '1',
        date: '5 Jan',
        day: 'Friday',
        status: AttendanceStatus.present,
        subject: 'Mathematics',
        time: '9:00 AM - 10:00 AM',
      ),
      const AttendanceRecordModel(
        id: '2',
        date: '4 Jan',
        day: 'Thursday',
        status: AttendanceStatus.present,
        subject: 'English',
        time: '9:00 AM - 10:00 AM',
      ),
      const AttendanceRecordModel(
        id: '3',
        date: '3 Jan',
        day: 'Wednesday',
        status: AttendanceStatus.absent,
        subject: 'Science',
        time: '10:00 AM - 11:00 AM',
      ),
      const AttendanceRecordModel(
        id: '4',
        date: '2 Jan',
        day: 'Tuesday',
        status: AttendanceStatus.present,
        subject: 'Social Studies',
        time: '11:00 AM - 12:00 PM',
      ),
      const AttendanceRecordModel(
        id: '5',
        date: '1 Jan',
        day: 'Monday',
        status: AttendanceStatus.holiday,
      ),
      const AttendanceRecordModel(
        id: '6',
        date: '31 Dec',
        day: 'Sunday',
        status: AttendanceStatus.present,
        subject: 'Computer Science',
        time: '2:00 PM - 3:00 PM',
      ),
      const AttendanceRecordModel(
        id: '7',
        date: '30 Dec',
        day: 'Saturday',
        status: AttendanceStatus.leave,
      ),
      const AttendanceRecordModel(
        id: '8',
        date: '29 Dec',
        day: 'Friday',
        status: AttendanceStatus.present,
        subject: 'Hindi',
        time: '10:00 AM - 11:00 AM',
      ),
    ];
  }
}
