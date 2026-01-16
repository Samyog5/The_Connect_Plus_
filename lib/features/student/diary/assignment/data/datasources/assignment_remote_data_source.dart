import 'package:tcp/features/student/diary/assignment/data/models/assignment_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<List<AssignmentModel>> getAssignments();
}

class AssignmentRemoteDataSourceImpl implements AssignmentRemoteDataSource {
  @override
  Future<List<AssignmentModel>> getAssignments() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      AssignmentModel(
        id: '1',
        subject: 'Mathematics',
        title: 'Advanced Algebra Worksheet',
        remarks:
            'Focus on quadratic equations and function mapping. Submit the PDF version.',
        dueDate: DateTime(2026, 1, 20),
        isCompleted: false,
      ),
      AssignmentModel(
        id: '2',
        subject: 'Science',
        title: 'Quantum Physics Report',
        remarks: 'Write a 2-page report on the double-slit experiment.',
        dueDate: DateTime(2026, 1, 22),
        isCompleted: false,
      ),
      AssignmentModel(
        id: '3',
        subject: 'English',
        title: 'Shakespeare Essay',
        remarks: 'Analyze the theme of fate in Romeo and Juliet.',
        dueDate: DateTime(2026, 1, 15),
        isCompleted: true,
      ),
    ];
  }
}
