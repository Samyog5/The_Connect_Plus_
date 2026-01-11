import 'package:tcp/features/student/library/domain/entities/book.dart';

abstract class LibraryRepository {
  Future<List<Book>> getBooks();
  Future<List<Book>> searchBooks(String query);
}
