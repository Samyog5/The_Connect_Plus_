import 'package:equatable/equatable.dart';
import 'package:tcp/features/student/library/domain/entities/book.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<Book> books;
  final String activeCategory;

  const LibraryLoaded(this.books, {this.activeCategory = 'All'});

  @override
  List<Object> get props => [books, activeCategory];
}

class LibraryError extends LibraryState {
  final String message;

  const LibraryError(this.message);

  @override
  List<Object> get props => [message];
}
