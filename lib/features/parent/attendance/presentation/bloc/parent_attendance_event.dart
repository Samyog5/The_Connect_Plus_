import 'package:equatable/equatable.dart';

abstract class ParentAttendanceEvent extends Equatable {
  const ParentAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadParentAttendance extends ParentAttendanceEvent {
  const LoadParentAttendance();
}
