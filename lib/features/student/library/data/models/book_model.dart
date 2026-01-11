import 'package:tcp/features/student/library/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.category,
    required super.coverUrl,
    required super.status,
    required super.description,
    super.uniqueBookNumber,
    super.edition,
    super.publisher,
    super.publicationYear,
    super.subject,
    super.studentClass,
    super.vol,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      coverUrl: json['coverUrl'],
      status:
          json['status'] ??
          (json['isAvailable'] == true ? 'Available' : 'Issued'),
      description: json['description'],
      uniqueBookNumber: json['uniqueBookNumber'] ?? '',
      edition: json['edition'] ?? '',
      publisher: json['publisher'] ?? '',
      publicationYear: json['publicationYear'] ?? '',
      subject: json['subject'] ?? '',
      studentClass:
          json['class'] ?? '', // Mapping 'class' from JSON to 'studentClass'
      vol: json['vol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'coverUrl': coverUrl,
      'status': status,
      'description': description,
      'uniqueBookNumber': uniqueBookNumber,
      'edition': edition,
      'publisher': publisher,
      'publicationYear': publicationYear,
      'subject': subject,
      'class': studentClass,
      'vol': vol,
    };
  }
}
