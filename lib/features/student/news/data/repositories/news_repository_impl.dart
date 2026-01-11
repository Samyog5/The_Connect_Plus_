import 'package:tcp/features/student/news/domain/entities/news.dart';
import 'package:tcp/features/student/news/domain/repositories/news_repository.dart';
import 'package:tcp/features/student/news/data/models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<List<News>> getNews() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    return [
      NewsModel(
        id: '1',
        title: 'Science Fair 2026 Winners',
        description:
            'Congratulations to all the winners of the Annual Science Fair held last week.',
        date: 'Jan 8, 2026',
        author: 'Science Dept',
        imageUrl: 'assets/news/science_fair.png',
        category: 'Academic',
      ),
      NewsModel(
        id: '2',
        title: 'New Library Books Arrival',
        description:
            'We have added over 500 new books to our library collection. Visit and explore!',
        date: 'Jan 5, 2026',
        author: 'Librarian',
        imageUrl: 'assets/news/library.png',
        category: 'Facility',
      ),
      NewsModel(
        id: '3',
        title: 'Inter-School Football Tournament',
        description:
            'Our school team has reached the finals! Come support them this Saturday.',
        date: 'Jan 3, 2026',
        author: 'Sports Coach',
        imageUrl: 'assets/news/sports.png',
        category: 'Sports',
      ),
    ];
  }
}
