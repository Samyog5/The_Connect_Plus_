import 'package:tcp/features/student/elearning/domain/entities/elearning.dart';

abstract class ELearningRepository {
  Future<List<ELearning>> getMaterials();
}
