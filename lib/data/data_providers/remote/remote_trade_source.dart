import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book/book_request.dart';

class RemoteTradeSource {
  final FirebaseFirestore fireStore;

  RemoteTradeSource({
    required this.fireStore,
  });

  //REQUESTS
  Future<List<BookRequest>> getUserRequestListAsReceiver(String userId) async {
    try {
      CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
      List<QueryDocumentSnapshot> userRequestList =
          await requestCollection.where('receiverId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);

      List<BookRequest> bookRequestList = [];
      for (QueryDocumentSnapshot snapshot in userRequestList) {
        try {
          bookRequestList.add(BookRequest.fromSnapshot(snapshot));
        } catch (e) {}
      }
      return bookRequestList;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<BookRequest> getRequest(String requestId) async {
    try {
      CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
      DocumentSnapshot request = await requestCollection.doc(requestId).get();

      return BookRequest.fromSnapshot(request);
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future requestBook(BookRequest request) async {
    try {
      String receiverId = request.receiverId;
      String ownerId = request.ownerId;

      if (receiverId == ownerId) {
        throw Exception("You are owner of the offer");
      }

      List<BookRequest> foundRequests = await getUserRequestListAsReceiver(receiverId);

      for (BookRequest foundRequest in foundRequests) {
        if (foundRequest.offerId == request.offerId) {
          throw Exception("Request already exists");
        }
      }

      await fireStore.collection(StaticApi.requestCollection).doc().set(request.toMap());
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }


  Future deleteBookRequest(String userId, String requestId) async {
    try {
      await fireStore.collection(StaticApi.requestCollection).doc(requestId).delete();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }
}
