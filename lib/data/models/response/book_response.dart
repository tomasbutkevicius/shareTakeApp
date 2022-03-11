import 'package:cloud_firestore/cloud_firestore.dart';


class BookResponse {
  final String id;
  final int? isbn;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? imagePath;
  final String? language;
  final int pages;
  final DateTime publishDate;
  final String description;

  const BookResponse({
    required this.id,
    this.isbn,
    required this.title,
    this.subtitle,
    required this.authors,
    this.imagePath,
    this.language,
    required this.pages,
    required this.publishDate,
    required this.description,
  });

  factory BookResponse.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

    return BookResponse(
      id: snapshot.id,
      isbn: json['isbn'] as int?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      authors:
      (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      imagePath: json['imagePath'] as String?,
      language: json['language'] as String?,
      pages: json['pages'] as int,
      publishDate: DateTime.fromMillisecondsSinceEpoch((snapshot["publishDate"] as Timestamp).millisecondsSinceEpoch),
      description: json['description'] as String,
    );
  }


}
