import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final String author;
  final String category;
  final String coverUrl;
  final String status;
  final String description;
  final String uniqueBookNumber;
  final String edition;
  final String publisher;
  final String publicationYear;
  final String subject;
  final String studentClass;
  final String vol;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.coverUrl,
    required this.status,
    required this.description,
    this.uniqueBookNumber = '',
    this.edition = '',
    this.publisher = '',
    this.publicationYear = '',
    this.subject = '',
    this.studentClass = '',
    this.vol = '',
  });

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    category,
    coverUrl,
    status,
    description,
    uniqueBookNumber,
    edition,
    publisher,
    publicationYear,
    subject,
    studentClass,
    vol,
  ];
}
