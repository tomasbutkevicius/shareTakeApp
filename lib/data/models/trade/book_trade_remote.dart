import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/enums.dart';

class BookTradeRemote {
  final String id;
  final DateTime startDate;
  final String bookId;
  final String ownerId;
  final String receiverId;
  final TradeStatus status;

  const BookTradeRemote({
    required this.id,
    required this.startDate,
    required this.bookId,
    required this.ownerId,
    required this.receiverId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'startDate': this.startDate,
      'bookId': this.bookId,
      'ownerId': this.ownerId,
      'receiverId': this.receiverId,
      'status': this.status.name,
    };
  }

  factory BookTradeRemote.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    try {
      TradeStatus status = TradeStatus.negotiating;
      String statusString = "negotiating";
      try {
        statusString = map['status'] as String;
      } catch (e) {}
      if (statusString.toLowerCase() == TradeStatus.received.name) {
        status = TradeStatus.received;
      } else if (statusString.toLowerCase() == TradeStatus.returned.name) {
        status = TradeStatus.returned;
      } else if (statusString.toLowerCase() == TradeStatus.returning.name) {
        status = TradeStatus.returning;
      } else if (statusString.toLowerCase() == TradeStatus.sending.name) {
        status = TradeStatus.sending;
      }

      return BookTradeRemote(
        id: snapshot.id,
        startDate: DateTime.fromMillisecondsSinceEpoch((snapshot["startDate"] as Timestamp).millisecondsSinceEpoch),
        bookId: map["bookId"] as String,
        ownerId: map["ownerId"] as String,
        receiverId: map["receiverId"] as String,
        status: status,);
    } catch (e) {
      throw Exception("Error parsing book trade, make sure app is updated");
    }
  }
}