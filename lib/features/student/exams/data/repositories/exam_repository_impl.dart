import 'package:tcp/features/student/exams/domain/entities/exam.dart';
import 'package:tcp/features/student/exams/domain/repositories/exam_repository.dart';

class ExamRepositoryImpl implements ExamRepository {
  @override
  Future<List<Exam>> getExams() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return [
      Exam(
        id: '1',
        subject: 'Mathematics',
        date: DateTime.now().add(const Duration(days: 2)),
        startTime: '09:00 AM',
        endTime: '12:00 PM',
        room: 'Hall A',
        syllabus: 'Algebra, Geometry, Calculus',
        type: 'Final',
        status: 'Upcoming',
      ),
      Exam(
        id: '2',
        subject: 'Physics',
        date: DateTime.now().add(const Duration(days: 4)),
        startTime: '02:00 PM',
        endTime: '05:00 PM',
        room: 'Hall B',
        syllabus: 'Mechanics, Thermodynamics',
        type: 'Final',
        status: 'Upcoming',
      ),
      Exam(
        id: '3',
        subject: 'Chemistry',
        date: DateTime.now().subtract(const Duration(days: 2)),
        startTime: '09:00 AM',
        endTime: '12:00 PM',
        room: 'Lab 1',
        syllabus: 'Organic Chemistry',
        type: 'Final',
        status: 'Completed',
      ),
      Exam(
        id: '4',
        subject: 'English',
        date: DateTime.now().add(const Duration(days: 6)),
        startTime: '10:00 AM',
        endTime: '01:00 PM',
        room: 'Hall C',
        syllabus: 'Literature, Grammar',
        type: 'Final',
        status: 'Upcoming',
      ),
    ];
  }
}
