import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/diary/assignment/domain/usecases/get_assignments.dart';
import 'package:tcp/features/student/diary/assignment/presentation/bloc/assignment_event.dart';
import 'package:tcp/features/student/diary/assignment/presentation/bloc/assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetAssignments getAssignments;

  AssignmentBloc({required this.getAssignments}) : super(AssignmentInitial()) {
    on<LoadAssignments>(_onLoadAssignments);
  }

  Future<void> _onLoadAssignments(
    LoadAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoading());
    try {
      final assignments = await getAssignments();
      emit(AssignmentLoaded(assignments: assignments));
    } catch (e) {
      emit(AssignmentError(e.toString()));
    }
  }
}
