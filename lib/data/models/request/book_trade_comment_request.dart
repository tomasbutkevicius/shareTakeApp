import 'package:equatable/equatable.dart';

class BookTradeCommentRequest extends Equatable {
  final String tradeId;
  final DateTime date;
  final String authorName;
  final String authorId;
  final String text;

  const BookTradeCommentRequest({
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

  @override
  List<Object?> get props => [
    tradeId,
    date,
    authorName,
    authorId,
  ];
}
