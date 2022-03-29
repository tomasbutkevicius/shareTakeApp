import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';
import 'package:share_take/data/models/trade/book_trade_remote.dart';

class RemoteBookTradeSource {
  final FirebaseFirestore fireStore;

  RemoteBookTradeSource({
    required this.fireStore,
  });
  //
  // Future<List<BookRequestRemote>> getUserRequestListAsOwner(String userId) async {
  //   try {
  //     CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
  //     List<QueryDocumentSnapshot> userRequestList =
  //     await requestCollection.where('ownerId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);
  //
  //     List<BookRequestRemote> bookRequestList = [];
  //     for (QueryDocumentSnapshot snapshot in userRequestList) {
  //       try {
  //         bookRequestList.add(BookRequestRemote.fromSnapshot(snapshot));
  //       } catch (e) {}
  //     }
  //     return bookRequestList;
  //   } on FirebaseException catch (firebaseException) {
  //     throw Exception(firebaseException.message);
  //   }
  // }

  Future<List<BookTradeRemote>> getTradeList() async {
    try {
      CollectionReference tradeCollection = fireStore.collection(StaticApi.tradeCollection);
      List<QueryDocumentSnapshot> tradeList =
      await tradeCollection.get().then((snapshot) => snapshot.docs);

      List<BookTradeRemote> bookTradeList = [];
      for (QueryDocumentSnapshot snapshot in tradeList) {
        try {
          bookTradeList.add(BookTradeRemote.fromSnapshot(snapshot));
        } catch (e) {}
      }
      return bookTradeList;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<List<BookTradeRemote>> getUserTradeList(String userId) async {
    try {
      List<BookTradeRemote> allTrades = await getTradeList();
      List<BookTradeRemote> foundUserTrades = [];
      for(BookTradeRemote trade in allTrades) {
        if(trade.receiverId == userId || trade.ownerId == userId) {
          foundUserTrades.add(trade);
        }
      }

      return foundUserTrades;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  // Future<BookRequestRemote> getRequest(String requestId) async {
  //   try {
  //     CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
  //     DocumentSnapshot request = await requestCollection.doc(requestId).get();
  //
  //     return BookRequestRemote.fromSnapshot(request);
  //   } on FirebaseException catch (firebaseException) {
  //     throw Exception(firebaseException.message);
  //   }
  // }

  Future createBookTrade(BookTradeRemote tradeRemote) async {
    try {
      String receiverId = tradeRemote.receiverId;
      String ownerId = tradeRemote.ownerId;

      if (receiverId == ownerId) {
        throw Exception("You are found as owner and receiver");
      }

      List<BookTradeRemote> allTrades = await getTradeList();

      for (BookTradeRemote trade in allTrades) {
        if(trade.ownerId == tradeRemote.ownerId
        && trade.receiverId == tradeRemote.receiverId
        && trade.bookId == tradeRemote.bookId) {
          throw Exception("Trade already created");
        }
      }

      await fireStore.collection(StaticApi.tradeCollection).doc().set(tradeRemote.toMap());
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  // Future deleteBookRequest(String userId, String requestId) async {
  //   try {
  //     await fireStore.collection(StaticApi.requestCollection).doc(requestId).delete();
  //   } on FirebaseException catch (firebaseException) {
  //     throw Exception(firebaseException.message);
  //   }
  // }
  //
  // Future<List<BookRequestRemote>> getRequestsByOfferId(String offerId) async {
  //   try {
  //     CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
  //     List<QueryDocumentSnapshot> requestList =
  //     await requestCollection.where('offerId', isEqualTo: offerId).get().then((snapshot) => snapshot.docs);
  //
  //     List<BookRequestRemote> bookRequestList = [];
  //     for (QueryDocumentSnapshot snapshot in requestList) {
  //       try {
  //         bookRequestList.add(BookRequestRemote.fromSnapshot(snapshot));
  //       } catch (e) {}
  //     }
  //     return bookRequestList;
  //   } on FirebaseException catch (firebaseException) {
  //     throw Exception(firebaseException.message);
  //   }
  // }
  //
  // Future updateRequestStatus(String requestId, BookRequestStatus status) async {
  //   try {
  //     CollectionReference requestCollection = fireStore.collection(StaticApi.requestCollection);
  //
  //     await requestCollection.doc(requestId).update({
  //       "status": status.name,
  //       'editable': false,
  //     });
  //   } on FirebaseException catch (firebaseException) {;
  //   throw Exception(firebaseException.message);
  //   }
  // }
}
