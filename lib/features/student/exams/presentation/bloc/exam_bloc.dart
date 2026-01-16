import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/exams/domain/usecases/get_exams.dart';
import 'package:tcp/features/student/exams/presentation/bloc/exam_event.dart';
import 'package:tcp/features/student/exams/presentation/bloc/exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final GetExams getExams;

  ExamBloc({required this.getExams}) : super(ExamInitial()) {
    on<LoadExams>(_onLoadExams);
  }

  Future<void> _onLoadExams(LoadExams event, Emitter<ExamState> emit) async {
    emit(ExamLoading());
    try {
      final exams = await getExams();
      emit(ExamLoaded(exams));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }
}
