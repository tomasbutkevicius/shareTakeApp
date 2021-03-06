import 'package:books_finder/books_finder.dart';
import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_wishlist_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/request/add_book_request.dart';
import 'package:share_take/data/models/response/book_response.dart';
import 'package:share_take/utilities/static_utilities.dart';

class BookRepository {
  final RemoteBookSource remoteBookSource;
  final RemoteOfferSource remoteOfferSource;
  final RemoteWishListSource remoteWishListSource;
  final FirebaseStorageService firebaseStorageService;
  static const bookSearchBaseUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:0735619670";

  const BookRepository({
    required this.remoteBookSource,
    required this.remoteOfferSource,
    required this.remoteWishListSource,
    required this.firebaseStorageService,
  });

  Future<List<BookLocal>> getAllBooks() async {
    List<BookResponse> bookResponseList = await remoteBookSource.getAllBooks();

    List<BookLocal> books = [];

    for (BookResponse response in bookResponseList) {
      String url = "";

      if (response.imageUrl != null) {
        if (!StaticUtilities.isUrl(response.imageUrl!)) {
          try {
            url = await firebaseStorageService.getFileUrl(response.imageUrl!);
          } catch (e) {}
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
    return await remoteWishListSource.getBookWantedList(bookId);
  }

  Future<List<BookWantsRemote>> getUserWishList(String userId) async {
    return await remoteWishListSource.getUserWishList(userId);
  }

  Future<List<BookOfferRemote>> getBookOfferList(String bookId) async {
    return await remoteOfferSource.getBookOfferList(bookId);
  }

  Future<List<BookOfferRemote>> getUserOfferList(String userId) async {
    return await remoteOfferSource.getUserOfferList(userId);
  }
}
