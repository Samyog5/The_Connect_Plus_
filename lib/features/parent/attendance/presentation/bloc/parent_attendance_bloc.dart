import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/parent/attendance/domain/usecases/get_parent_attendance.dart';
import 'package:tcp/features/parent/attendance/presentation/bloc/parent_attendance_event.dart';
import 'package:tcp/features/parent/attendance/presentation/bloc/parent_attendance_state.dart';

class ParentAttendanceBloc
    extends Bloc<ParentAttendanceEvent, ParentAttendanceState> {
  final GetParentAttendance getParentAttendance;

  ParentAttendanceBloc(this.getParentAttendance)
      : super(const ParentAttendanceInitial()) {
    on<LoadParentAttendance>(_onLoad);
  }

  Future<void> _onLoad(
    LoadParentAttendance event,
    Emitter<ParentAttendanceState> emit,
  ) async {
    emit(const ParentAttendanceLoading());

    try {
      final records = await getParentAttendance();
      emit(ParentAttendanceLoaded(records));
    } catch (_) {
      emit(const ParentAttendanceError('Failed to load attendance'));
    }
  }
}
