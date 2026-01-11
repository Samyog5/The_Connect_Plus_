import 'package:tcp/features/student/elearning/domain/entities/elearning.dart';

abstract class ELearningState {}

class ELearningLoading extends ELearningState {}

class ELearningLoaded extends ELearningState {
  final List<ELearning> materials;
  final String activeCategory;

  ELearningLoaded(this.materials, this.activeCategory);
}

class ELearningError extends ELearningState {
  final String message;
  ELearningError(this.message);
}
