
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/request/add_book_request.dart';
import 'package:share_take/data/models/response/book_response.dart';

class RemoteBookSource {
  final FirebaseFirestore _fireStore;

  RemoteBookSource({
    FirebaseFirestore? fireStore,
  }) : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<List<BookResponse>> getAllBooks() async {
    QuerySnapshot snapshot = await _fireStore.collection(StaticApi.booksCollection).get();

    return snapshot.docs.map((doc) => BookResponse.fromSnapshot(doc)).toList();
  }

  Future addBook(AddBookRequest bookRequest) async {
    // final ByteData imageData = await NetworkAssetBundle(Uri.parse("YOUR_URL")).load("");
    // final Uint8List bytes = imageData.buffer.asUint8List();
    try {
      CollectionReference bookCollection = _fireStore.collection(StaticApi.booksCollection);
      List<QueryDocumentSnapshot> foundByIsbn =
          await bookCollection.where('isbn', isEqualTo: bookRequest.isbn).get().then((snapshot) => snapshot.docs);
      if (foundByIsbn.isNotEmpty) {
        throw Exception("Book with this ISBN is already added ");
      }
      await bookCollection.doc().set(
        bookRequest.toMap(),
          );
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

}
