import '../../domain/entities/elearning.dart';
import '../../domain/repositories/elearning_repository.dart';

class ELearningRepositoryImpl implements ELearningRepository {
  @override
  Future<List<ELearning>> getMaterials() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      ELearning(
        id: '1',
        subject: 'Mathematics',
        title: 'Trigonometry Basics',
        description: 'Video lecture covering trigonometry fundamentals.',
        category: 'Video',
        source: 'YouTube',
        date: 'Dec 17, 2025',
        uploadedBy: 'Teacher',
        link: 'https://youtube.com',
      ),
      ELearning(
        id: '2',
        subject: 'Science',
        title: 'Physics Reference PDF',
        description: 'Important formulas and concepts.',
        category: 'Article',
        source: 'Google Drive',
        date: 'Dec 16, 2025',
        uploadedBy: 'Admin',
        link: 'https://drive.google.com',
      ),
    ];
  }
}
