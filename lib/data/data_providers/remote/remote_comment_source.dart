import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';
import 'package:share_take/data/models/comment/book_trade_comment_remote.dart';
import 'package:share_take/data/models/request/book_trade_comment_request.dart';
import 'package:share_take/data/models/trade/book_trade_remote.dart';

class RemoteCommentSource {
  final FirebaseFirestore fireStore;

  RemoteCommentSource({
    required this.fireStore,
  });

  Future<List<BookTradeCommentModel>> getTradeCommentList(String tradeId) async {
    try {
      CollectionReference commentCollection = fireStore.collection(StaticApi.tradeCommentsCollection);
      List<QueryDocumentSnapshot> comments =
          await commentCollection.where('tradeId', isEqualTo: tradeId).get().then((snapshot) => snapshot.docs);
      if (comments.isNotEmpty) {
        return comments.map((e) => BookTradeCommentModel.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future createTradeComment(BookTradeCommentRequest comment) async {
    try {
      await fireStore.collection(StaticApi.tradeCommentsCollection).doc().set(comment.toMap());
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future deleteTradeComment(String userId, String commentId) async {
    try {
      await fireStore.collection(StaticApi.tradeCommentsCollection).doc(commentId).delete();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }
}
