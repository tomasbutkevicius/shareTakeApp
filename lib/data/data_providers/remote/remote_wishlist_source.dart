import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/request/book_want_request.dart';

class RemoteWishListSource {
  final FirebaseFirestore _fireStore;

  RemoteWishListSource({
    FirebaseFirestore? fireStore,
  }) : _fireStore = fireStore ?? FirebaseFirestore.instance;


  Future<List<BookWantsRemote>> getBookWantedList(String bookId) async {
    try {
      CollectionReference wantedCollection = _fireStore.collection(StaticApi.wantedCollection);
      List<QueryDocumentSnapshot> bookWantList =
      await wantedCollection.where('bookId', isEqualTo: bookId).get().then((snapshot) => snapshot.docs);
      if (bookWantList.isNotEmpty) {
        return bookWantList.map((e) => BookWantsRemote.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<List<BookWantsRemote>> getUserWishList(String userId) async {
    try {
      CollectionReference wantedCollection = _fireStore.collection(StaticApi.wantedCollection);
      List<QueryDocumentSnapshot> userWantedItemList =
      await wantedCollection.where('userId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);
      if (userWantedItemList.isNotEmpty) {
        return userWantedItemList.map((e) => BookWantsRemote.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }


  Future addBookToWishList(
      BookWantRequest request
      ) async {
    try {
      await _fireStore
          .collection(StaticApi.wantedCollection)
          .doc(request.userId + request.bookId)
          .set(request.toMap());
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }


  Future removeBookWant(String bookId, String userId) async {
    try {
      await _fireStore.collection(StaticApi.wantedCollection).doc(userId + bookId).delete();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }


}