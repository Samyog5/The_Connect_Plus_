import 'package:tcp/features/student/news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
}
