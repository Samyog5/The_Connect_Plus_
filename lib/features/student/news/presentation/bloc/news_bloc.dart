import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/news/domain/usecases/get_news.dart';
import 'package:tcp/features/student/news/domain/entities/news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;

  List<News> _allNews = [];
  String _currentCategory = 'All';
  String _currentQuery = '';

  NewsBloc(this.getNews) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<SearchNews>(_onSearchNews);
    on<FilterNews>(_onFilterNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      _allNews = await getNews();
      _applyFilters(emit);
    } catch (e) {
      emit(NewsError("Failed to load news"));
    }
  }

  void _onSearchNews(SearchNews event, Emitter<NewsState> emit) {
    _currentQuery = event.query;
    _applyFilters(emit);
  }

  void _onFilterNews(FilterNews event, Emitter<NewsState> emit) {
    _currentCategory = event.category;
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<NewsState> emit) {
    List<News> filtered = _allNews.where((news) {
      final matchesSearch =
          news.title.toLowerCase().contains(_currentQuery.toLowerCase()) ||
          news.description.toLowerCase().contains(_currentQuery.toLowerCase());
      final matchesCategory =
          _currentCategory == 'All' || news.category == _currentCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    emit(
      NewsLoaded(
        filtered,
        activeCategory: _currentCategory,
        searchQuery: _currentQuery,
      ),
    );
  }
}
