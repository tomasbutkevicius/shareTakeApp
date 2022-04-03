import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookTradeCommentRemote extends Equatable {
  final String id;
  final String tradeId;
  final DateTime date;
  final String authorName;
  final String authorId;
  final String text;

  const BookTradeCommentRemote({
    required this.id,
    required this.tradeId,
    required this.date,
    required this.authorName,
    required this.authorId,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'tradeId': this.tradeId,
      'date': this.date,
      'authorName': this.authorName,
      'authorId': this.authorId,
      'text': this.text,
    };
  }

  factory BookTradeCommentRemote.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    try {
      return BookTradeCommentRemote(
        id: snapshot.id,
        date: DateTime.fromMillisecondsSinceEpoch((snapshot["date"] as Timestamp).millisecondsSinceEpoch),
        authorId: map["authorId"] as String,
        authorName: map["authorName"] as String,
        tradeId: map["tradeId"] as String,
        text: map["text"] as String,
      );
    } catch (e) {
      throw Exception("Error parsing book trade comment, make sure app is updated");
    }
  }

  @override
  List<Object?> get props => [
        id,
        tradeId,
        date,
        authorName,
        authorId,
      ];
}
