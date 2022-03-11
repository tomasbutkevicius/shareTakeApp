import 'package:share_take/data/data_providers/remote/remote_book_source.dart';
import 'package:share_take/data/firebase_storage.dart';
import 'package:share_take/data/models/book/book.dart';
import 'package:share_take/data/models/response/book_response.dart';

class BookRepository {
  final RemoteBookSource remoteBookSource;
  final FirebaseStorageService firebaseStorageService;

  const BookRepository({required this.remoteBookSource, required this.firebaseStorageService});

  Future<List<Book>> getAllBooks() async {
    List<BookResponse> bookResponseList = await remoteBookSource.getAllBooks();

    List<Book> books = [];

   for(BookResponse response in bookResponseList){
     String url = "";
     try {
       url = await firebaseStorageService.getFileUrl(response.imagePath!);
     } catch (e) {}

     books.add(
       Book.fromResponse(response, url),
     );
   }

    return books;
  }
}
