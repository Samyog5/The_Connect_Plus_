import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/attendance/domain/usecases/get_attendance_records.dart';
import 'package:tcp/features/student/attendance/presentation/bloc/attendance_event.dart';
import 'package:tcp/features/student/attendance/presentation/bloc/attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendanceRecords getAttendanceRecords;

  AttendanceBloc({required this.getAttendanceRecords})
    : super(AttendanceInitial()) {
    on<LoadAttendance>(_onLoadAttendance);
  }

  Future<void> _onLoadAttendance(
    LoadAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    try {
      final records = await getAttendanceRecords();
      emit(AttendanceLoaded(records: records));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}
