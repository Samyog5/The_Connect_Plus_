abstract class ELearningEvent {}

class LoadELearning extends ELearningEvent {}

class SearchELearning extends ELearningEvent {
  final String query;
  SearchELearning(this.query);
}

class FilterByCategory extends ELearningEvent {
  final String category;
  FilterByCategory(this.category);
}
