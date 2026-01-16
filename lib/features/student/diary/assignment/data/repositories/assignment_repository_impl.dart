import 'package:tcp/features/student/diary/assignment/data/datasources/assignment_remote_data_source.dart';
import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';
import 'package:tcp/features/student/diary/assignment/domain/repositories/assignment_repository.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource remoteDataSource;

  AssignmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Assignment>> getAssignments() async {
    return await remoteDataSource.getAssignments();
  }
}
