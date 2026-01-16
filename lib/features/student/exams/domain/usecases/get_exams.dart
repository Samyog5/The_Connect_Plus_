import 'package:tcp/features/student/exams/domain/entities/exam.dart';
import 'package:tcp/features/student/exams/domain/repositories/exam_repository.dart';

class GetExams {
  final ExamRepository repository;

  GetExams(this.repository);

  Future<List<Exam>> call() async {
    return await repository.getExams();
  }
}
