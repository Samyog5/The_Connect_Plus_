import 'package:tcp/features/student/library/data/models/book_model.dart';
import 'package:tcp/features/student/library/domain/entities/book.dart';
import 'package:tcp/features/student/library/domain/repositories/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  @override
  Future<List<Book>> getBooks() async {
    // Mock Data matching React reference with Status
    await Future.delayed(const Duration(seconds: 1));
    return [
      const BookModel(
        id: '1',
        uniqueBookNumber: '1024',
        title: 'Basic Science',
        author: 'John Doe',
        edition: '7th',
        publisher: 'Read More',
        publicationYear: '2004',
        subject: 'Science',
        category: 'V',
        studentClass: '9',
        vol: '1',
        coverUrl: '',
        status: 'Available',
        description: 'Fundamental science concepts for grade 5.',
      ),
      const BookModel(
        id: '2',
        uniqueBookNumber: '1025',
        title: 'See Science',
        author: 'Dr. A. Smith',
        edition: '4th',
        publisher: 'Science Hub',
        publicationYear: '2010',
        subject: 'Science',
        category: 'V',
        studentClass: '5',
        vol: '2',
        coverUrl: '',
        status: 'Issued',
        description: 'Visual guide to scientific phenomena.',
      ),
      const BookModel(
        id: '3',
        uniqueBookNumber: '1026',
        title: 'Modern Math',
        author: 'Prof. X',
        edition: '2nd',
        publisher: 'Math World',
        publicationYear: '2018',
        subject: 'Mathematics',
        category: 'IV',
        studentClass: '4',
        vol: '1',
        coverUrl: '',
        status: 'Returned',
        description: 'Interactive mathematics learning.',
      ),
      const BookModel(
        id: '4',
        uniqueBookNumber: '1027',
        title: 'World History',
        author: 'Historian Y',
        edition: '1st',
        publisher: 'History Press',
        publicationYear: '2015',
        subject: 'History',
        category: 'VI',
        studentClass: '6',
        vol: '1',
        coverUrl: '',
        status: 'Available',
        description: 'Comprehensive world history overview.',
      ),
      const BookModel(
        id: '5',
        uniqueBookNumber: '1028',
        title: 'Computer Basics',
        author: 'Tech Guru',
        edition: '5th',
        publisher: 'Tech Books',
        publicationYear: '2020',
        subject: 'Computer',
        category: 'V',
        studentClass: '5',
        vol: '1',
        coverUrl: '',
        status: 'Issued',
        description: 'Introduction to computers and coding.',
      ),
    ];
  }

  @override
  Future<List<Book>> searchBooks(String query) async {
    final allBooks = await getBooks();
    return allBooks
        .where(
          (book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
