import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/library/domain/usecases/get_books.dart';
import 'package:tcp/features/student/library/presentation/bloc/library_event.dart';
import 'package:tcp/features/student/library/presentation/bloc/library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetBooks getBooks;

  LibraryBloc(this.getBooks) : super(LibraryInitial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    try {
      final books = await getBooks();
      emit(LibraryLoaded(books));
    } catch (e) {
      emit(LibraryError(e.toString()));
    }
  }

  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<LibraryState> emit,
  ) async {
    // For simplicity, we'll reload all and filter in memory or rely on repository search
    // Using repository.searchBooks functionality ideally
    // But since GetBooks is the only usecase injected currently, I'll update GetBooks or add SearchBooks usecase.
    // For now, I'll re-use getBooks and client-side filter for simplicity sake,
    // OR ideally injection of SearchBooks usecase.
    // Given the task size, let's assume filtering on loaded state or simple reload for now.
    // Let's implement search properly in repository.

    // Actually, I provided `searchBooks` in Repo but not a UseCase for it.
    // I will mock "Search" by loading and filtering locally here or creating a new UseCase.
    // Let's update this to just load standard for now and filtered via State logic if needed,
    // or assume we add UseCase later.
    // I'll stick to LoadBooks call for now as basic implementation.

    emit(LibraryLoading());
    try {
      final allBooks = await getBooks();
      if (event.query.isEmpty) {
        emit(LibraryLoaded(allBooks));
      } else {
        final filtered = allBooks.where((book) {
          return book.title.toLowerCase().contains(event.query.toLowerCase()) ||
              book.author.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
        emit(LibraryLoaded(filtered));
      }
    } catch (e) {
      emit(LibraryError(e.toString()));
    }
  }
}
