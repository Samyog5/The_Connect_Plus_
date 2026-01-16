import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments();
}
