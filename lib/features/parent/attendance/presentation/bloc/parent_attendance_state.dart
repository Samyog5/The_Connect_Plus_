import 'package:equatable/equatable.dart';
import 'package:tcp/features/parent/attendance/domain/entities/parent_attendance_record.dart';

abstract class ParentAttendanceState extends Equatable {
  const ParentAttendanceState();

  @override
  List<Object?> get props => [];
}

class ParentAttendanceInitial extends ParentAttendanceState {
  const ParentAttendanceInitial();
}

class ParentAttendanceLoading extends ParentAttendanceState {
  const ParentAttendanceLoading();
}

class ParentAttendanceLoaded extends ParentAttendanceState {
  final List<ParentAttendanceRecord> records;

  const ParentAttendanceLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

class ParentAttendanceError extends ParentAttendanceState {
  final String message;

  const ParentAttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
