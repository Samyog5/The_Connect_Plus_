import 'package:tcp/features/student/news/domain/entities/news.dart';
import 'package:tcp/features/student/news/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<List<News>> call() {
    return repository.getNews();
  }
}
