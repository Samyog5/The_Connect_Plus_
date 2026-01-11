import '../../domain/entities/elearning.dart';

class ELearningModel extends ELearning {
  ELearningModel({
    required super.id,
    required super.subject,
    required super.title,
    required super.description,
    required super.category,
    required super.source,
    required super.date,
    required super.uploadedBy,
    required super.link,
  });
}
