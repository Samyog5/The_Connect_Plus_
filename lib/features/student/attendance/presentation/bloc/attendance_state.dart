import 'package:equatable/equatable.dart';
import 'package:tcp/features/student/attendance/domain/entities/attendance_record.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecord> records;

  const AttendanceLoaded({required this.records});

  int get totalDays => records.length;
  int get totalPresent =>
      records.where((r) => r.status == AttendanceStatus.present).length;
  int get totalAbsent =>
      records.where((r) => r.status == AttendanceStatus.absent).length;
  int get totalLeave =>
      records.where((r) => r.status == AttendanceStatus.leave).length;
  double get attendancePercentage =>
      totalDays > 0 ? (totalPresent / totalDays) * 100 : 0;

  @override
  List<Object> get props => [records];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object> get props => [message];
}
