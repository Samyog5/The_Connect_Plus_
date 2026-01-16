import 'package:tcp/features/student/exams/domain/entities/exam.dart';

abstract class ExamRepository {
  Future<List<Exam>> getExams();
}
