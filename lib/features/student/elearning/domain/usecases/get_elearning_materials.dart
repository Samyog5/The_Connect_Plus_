import 'package:tcp/features/student/elearning/domain/entities/elearning.dart';
import 'package:tcp/features/student/elearning/domain/repositories/elearning_repository.dart';

class GetELearningMaterials {
  final ELearningRepository repository;

  GetELearningMaterials(this.repository);

  Future<List<ELearning>> call() {
    return repository.getMaterials();
  }
}
