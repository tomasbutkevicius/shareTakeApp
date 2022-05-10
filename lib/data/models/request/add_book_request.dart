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
  final String userId;

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
    required this.userId,
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
      "userId": this.userId
    };
  }

  factory AddBookRequest.fromBookLocal(BookLocal book, String userId) {
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
        userId: userId,
      );
    } catch (e) {
      throw Exception("Error parsing request. Make sure app is latest version");
    }
  }
}
