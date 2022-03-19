import 'package:share_take/data/models/book/book_local.dart';

class AddBookRequest {
  final String? isbn;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? imageUrl;
  final String? language;
  final int pages;
  final DateTime? publishDate;
  final String description;

  const AddBookRequest({
    this.isbn,
    required this.title,
    this.subtitle,
    required this.authors,
    this.imageUrl,
    this.language,
    required this.pages,
    required this.publishDate,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'isbn': this.isbn,
      'title': this.title,
      'subtitle': this.subtitle,
      'authors': this.authors,
      'imageUrl': this.imageUrl,
      'language': this.language,
      'pages': this.pages,
      'publishDate': this.publishDate,
      'description': this.description,
    };
  }

  factory AddBookRequest.fromMap(Map<String, dynamic> map) {
    return AddBookRequest(
      isbn: map['isbn'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      authors: map['authors'] as List<String>,
      imageUrl: map['imageUrl'] as String?,
      language: map['language'] as String,
      pages: map['pages'] as int,
      publishDate: map['publishDate'] as DateTime,
      description: map['description'] as String,
    );
  }

  factory AddBookRequest.fromBookLocal(BookLocal book) {
    try {
      return AddBookRequest(
        isbn: book.isbn,
        title: book.title,
        subtitle: book.subtitle,
        authors: book.authors,
        pages: book.pages,
        imageUrl: book.imageUrl,
        language: book.language,
        publishDate: book.publishDate,
        description: book.description,
      );
    } catch (e) {
      throw Exception("Error parsing request. Make sure app is latest version");
    }
  }
}
