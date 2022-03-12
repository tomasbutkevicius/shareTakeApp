import 'package:share_take/data/models/response/book_response.dart';


class Book {
  final String id;
  final int? isbn;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? imageUrl;
  final String? language;
  final int pages;
  final DateTime publishDate;
  final String description;

  const Book({
    required this.id,
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

  factory Book.fromResponse(BookResponse response, String imageUrl) {

    return Book(
      id: response.id,
      isbn: response.isbn,
      title: response.title,
      subtitle: response.subtitle,
      authors: response.authors,
      imageUrl: imageUrl,
      language: response.language,
      pages: response.pages,
      publishDate: response.publishDate,
      description: response.description,
    );
  }

}
