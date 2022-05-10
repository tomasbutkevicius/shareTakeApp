import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookOfferRemote extends Equatable {
  final String id;
  final String bookId;
  final String userId;

  const BookOfferRemote({
    required this.id,
    required this.bookId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'bookId': this.bookId,
      'userId': this.userId,
    };
  }

  factory BookOfferRemote.fromMap(Map<String, dynamic> map) {
    return BookOfferRemote(
      id: map['id'] as String,
      bookId: map['bookId'] as String,
      userId: map['userId'] as String,
    );
  }

  factory BookOfferRemote.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

    try {
      return BookOfferRemote(
        id: snapshot.id,
        bookId: json["bookId"] as String,
        userId: json["userId"] as String,
      );
    } catch (e) {
      throw Exception("Error parsing book offer, make sure app is updated");
    }
  }

  @override
  List<Object?> get props => [id, bookId, userId,];
}
