import 'package:tcp/features/student/library/domain/entities/book.dart';
import 'package:tcp/features/student/library/domain/repositories/library_repository.dart';

class GetBooks {
  final LibraryRepository repository;

  GetBooks(this.repository);

  Future<List<Book>> call() async {
    return await repository.getBooks();
  }
}
