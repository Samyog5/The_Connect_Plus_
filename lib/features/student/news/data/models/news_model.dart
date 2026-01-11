import 'package:tcp/features/student/news/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.author,
    required super.imageUrl,
    required super.category,
  });
}
