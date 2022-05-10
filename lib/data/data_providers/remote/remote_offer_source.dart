import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/request/book_offer_request.dart';

class RemoteOfferSource {
  final FirebaseFirestore _fireStore;

  RemoteOfferSource({
    FirebaseFirestore? fireStore,
  }) : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<BookOfferRemote> getOfferById(String offerId) async {
    try {
      CollectionReference offeredCollection = _fireStore.collection(StaticApi.offeredCollection);
      DocumentSnapshot bookOffers = await offeredCollection.doc(offerId).get();

      bookOffers.exists;

      return BookOfferRemote.fromSnapshot(bookOffers);
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  //OFFER LIST
  Future<List<BookOfferRemote>> getBookOfferList(String bookId) async {
    try {
      CollectionReference offeredCollection = _fireStore.collection(StaticApi.offeredCollection);
      List<QueryDocumentSnapshot> bookOffers =
          await offeredCollection.where('bookId', isEqualTo: bookId).get().then((snapshot) => snapshot.docs);
      if (bookOffers.isNotEmpty) {
        return bookOffers.map((e) => BookOfferRemote.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  //OFFER LIST
  Future<List<BookOfferRemote>> getUserOfferList(String userId) async {
    try {
      CollectionReference offeredCollection = _fireStore.collection(StaticApi.offeredCollection);
      List<QueryDocumentSnapshot> userOfferedItemList =
          await offeredCollection.where('userId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);
      if (userOfferedItemList.isNotEmpty) {
        return userOfferedItemList.map((e) => BookOfferRemote.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future addBookToOfferList(BookOfferRequest request) async {
    try {
      await _fireStore.collection(StaticApi.offeredCollection).doc(request.userId + request.bookId).set(request.toMap());
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future removeBookOffer(String id) async {
    try {
      await _fireStore.collection(StaticApi.offeredCollection).doc(id).delete();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }
}
