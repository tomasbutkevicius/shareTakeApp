import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/api.dart';
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
}
