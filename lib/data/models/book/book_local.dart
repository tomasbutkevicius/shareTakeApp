import 'package:books_finder/books_finder.dart';
import 'package:equatable/equatable.dart';
import 'package:share_take/data/models/response/book_response.dart';

class BookLocal extends Equatable {
  final String id;
  final String? isbn;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? imageUrl;
  final String? language;
  final int pages;
  final DateTime? publishDate;
  final String description;

  const BookLocal({
    required this.id,
    this.isbn,
    required this.title,
    this.subtitle,
    required this.authors,
    this.imageUrl,
    this.language,
    required this.pages,
    this.publishDate,
    required this.description,
  });

  factory BookLocal.fromResponse(BookResponse response, String imageUrl) {
    return BookLocal(
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

  factory BookLocal.fromBookFinder(Book foundBook, String isbn) {
    String? imageUrl;
    try {
      imageUrl = foundBook.info.imageLinks["thumbnail"]!.toString();
    } catch (e) {
      try {
        imageUrl = foundBook.info.imageLinks["smallThumbnail"]!.toString();
      } catch (e) {}
    }

    print("IMAGE:");
    print(imageUrl);

    return BookLocal(
      id: foundBook.id,
      isbn: isbn,
      title: foundBook.info.title,
      subtitle: "",
      authors: foundBook.info.authors,
      imageUrl: imageUrl,
      language: foundBook.info.language,
      pages: foundBook.info.pageCount,
      publishDate: foundBook.info.publishedDate,
      description: foundBook.info.description,
    );
  }

  @override
  String toString() {
    return 'BookLocal{id: $id, isbn: $isbn, title: $title, subtitle: $subtitle, authors: $authors, imageUrl: $imageUrl, language: $language, pages: $pages, publishDate: $publishDate, description: $description}';
  }

  BookLocal copyWith({
    String? id,
    String? isbn,
    String? title,
    String? subtitle,
    List<String>? authors,
    String? imageUrl,
    String? language,
    int? pages,
    DateTime? publishDate,
    String? description,
  }) {
    return BookLocal(
      id: id ?? this.id,
      isbn: isbn ?? this.isbn,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      authors: authors ?? this.authors,
      imageUrl: imageUrl ?? this.imageUrl,
      language: language ?? this.language,
      pages: pages ?? this.pages,
      publishDate: publishDate ?? this.publishDate,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        isbn,
        title,
        subtitle,
        authors,
        imageUrl,
        language,
        pages,
        publishDate,
        description,
      ];

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

  factory BookLocal.fromMap(Map<String, dynamic> map) {
    return BookLocal(
      id: map['id'] as String,
      isbn: map['isbn'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      authors: map['authors'] as List<String>,
      imageUrl: map['imageUrl'] as String,
      language: map['language'] as String,
      pages: map['pages'] as int,
      publishDate: map['publishDate'] as DateTime,
      description: map['description'] as String,
    );
  }
}
