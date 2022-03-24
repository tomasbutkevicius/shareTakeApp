import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/request/add_book_request.dart';
import 'package:share_take/data/models/response/book_response.dart';
import 'package:share_take/utilities/static_utilities.dart';

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
      print(response.title);
      print(response.imageUrl);

      if (response.imageUrl != null) {
          if (!StaticUtilities.isUrl(response.imageUrl!)) {
            try {
              url = await firebaseStorageService.getFileUrl(response.imageUrl!);
            }catch(e){}
          } else {
            url = response.imageUrl!;
          }
      }

      books.add(
        BookLocal.fromResponse(
          response,
          url,
        ),
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

  Future addBook(BookLocal bookLocal, String userId) async {
    AddBookRequest bookRequest = AddBookRequest.fromBookLocal(bookLocal, userId);

    await remoteBookSource.addBook(bookRequest);
  }

  Future<List<BookWantsRemote>> getBookWantedList(String bookId) async {
    return await remoteBookSource.getBookWantedList(bookId);
  }

}
