import 'package:books_finder/books_finder.dart';
import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/response/book_response.dart';

class BookRepository {
  final RemoteBookSource remoteBookSource;
  final FirebaseStorageService firebaseStorageService;
  static const bookSearchBaseUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:0735619670";

  const BookRepository({required this.remoteBookSource, required this.firebaseStorageService});

  Future<List<BookLocal>> getAllBooks() async {
    List<BookResponse> bookResponseList = await remoteBookSource.getAllBooks();

    List<BookLocal> books = [];

    for (BookResponse response in bookResponseList) {
      String url = "";

      if(response.imagePath != null){
        try {
          if(!url.contains("http")) {
            url = await firebaseStorageService.getFileUrl(response.imagePath!);
          } else {
            url = response.imagePath!;
          }
        } catch (e) {}
      }


      books.add(
        BookLocal.fromResponse(response, url),
      );
    }

    return books;
  }

  Future<Book?> getBookByIsbn(String isbn) async {
    List<Book> queriedBooks = await queryBooks(
      'isbn:$isbn',
      maxResults: 3,
      printType: PrintType.all,
      orderBy: OrderBy.relevance,
    );

    if (queriedBooks.isEmpty) {
      return null;
    }

    return queriedBooks.first;
  }

  Future addBook(BookLocal bookLocal) async {

    await remoteBookSource.addBook(bookLocal);
  }

}
