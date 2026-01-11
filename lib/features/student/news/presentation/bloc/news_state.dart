import 'package:tcp/features/student/news/domain/entities/news.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;
  final String activeCategory;
  final String searchQuery;

  NewsLoaded(this.news, {this.activeCategory = 'All', this.searchQuery = ''});
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
