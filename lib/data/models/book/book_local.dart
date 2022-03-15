
import 'package:books_finder/books_finder.dart';
import 'package:share_take/data/models/response/book_response.dart';


class BookLocal {
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
    try{
      imageUrl = foundBook.info.imageLinks["thumbnail"]!.toString();
    } catch(e){
      try {
        imageUrl = foundBook.info.imageLinks["smallThumbnail"]!.toString();
      } catch(e){}
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

}
