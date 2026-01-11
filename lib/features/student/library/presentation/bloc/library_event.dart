import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LoadBooks extends LibraryEvent {}

class SearchBooks extends LibraryEvent {
  final String query;

  const SearchBooks(this.query);

  @override
  List<Object> get props => [query];
}
