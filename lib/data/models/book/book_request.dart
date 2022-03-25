import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_take/constants/enums.dart';

class BookRequest {
  final String id;
  final String bookId;
  final String ownerId;
  final String receiverId;
  final String offerId;
  final String bookTitle;
  final BookRequestStatus status;

  const BookRequest({
    required this.id,
    required this.bookId,
    required this.ownerId,
    required this.receiverId,
    required this.offerId,
    required this.bookTitle,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'bookId': this.bookId,
      'ownerId': this.ownerId,
      'receiverId': this.receiverId,
      'offerId': this.offerId,
      'bookTitle': this.bookTitle,
      'status': this.status.name
    };
  }

  factory BookRequest.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    try {
      BookRequestStatus status = BookRequestStatus.waiting;
      String statusString = map['status'] as String;
      if(statusString.toLowerCase() == BookRequestStatus.accepted.name) {
        status = BookRequestStatus.accepted;
      } else if(statusString.toLowerCase() == BookRequestStatus.rejected.name){
        status = BookRequestStatus.rejected;
      }

      return BookRequest(
        id: map['id'] as String,
        bookId: map['bookId'] as String,
        ownerId: map['ownerId'] as String,
        receiverId: map['receiverId'] as String,
        offerId: map['offerId'] as String,
        bookTitle: map['bookTitle'] as String,
        status: status,
      );
    } catch (e) {
      throw Exception("Error parsing book request, make sure app is updated");
    }

  }
}