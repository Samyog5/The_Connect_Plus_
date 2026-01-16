import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';
import 'package:tcp/features/student/diary/assignment/domain/repositories/assignment_repository.dart';

class GetAssignments {
  final AssignmentRepository repository;

  GetAssignments(this.repository);

  Future<List<Assignment>> call() async {
    return await repository.getAssignments();
  }
}
