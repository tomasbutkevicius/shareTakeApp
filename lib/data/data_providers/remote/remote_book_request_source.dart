import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';

class RemoteBookRequestSource {
  final FirebaseFirestore fireStore;

  RemoteBookRequestSource({
    required this.fireStore,
  });

  Future<List<BookRequestRemote>> getUserRequestListAsOwner(String userId) async {
    try {
      CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
      List<QueryDocumentSnapshot> userRequestList =
      await requestCollection.where('ownerId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);

      List<BookRequestRemote> bookRequestList = [];
      for (QueryDocumentSnapshot snapshot in userRequestList) {
        try {
          bookRequestList.add(BookRequestRemote.fromSnapshot(snapshot));
        } catch (e) {}
      }
      return bookRequestList;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<List<BookRequestRemote>> getUserRequestListAsReceiver(String userId) async {
    try {
      CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
      List<QueryDocumentSnapshot> userRequestList =
          await requestCollection.where('receiverId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);

      List<BookRequestRemote> bookRequestList = [];
      for (QueryDocumentSnapshot snapshot in userRequestList) {
        try {
          bookRequestList.add(BookRequestRemote.fromSnapshot(snapshot));
        } catch (e) {}
      }
      return bookRequestList;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<BookRequestRemote> getRequest(String requestId) async {
    try {
      CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
      DocumentSnapshot request = await requestCollection.doc(requestId).get();

      return BookRequestRemote.fromSnapshot(request);
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future requestBook(BookRequestRemote request) async {
    try {
      String receiverId = request.receiverId;
      String ownerId = request.ownerId;

      if (receiverId == ownerId) {
        throw Exception("You are owner of the offer");
      }

      List<BookRequestRemote> foundRequests = await getUserRequestListAsReceiver(receiverId);

      for (BookRequestRemote foundRequest in foundRequests) {
        if (foundRequest.offerId == request.offerId) {
          throw Exception("Request is already sent");
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
