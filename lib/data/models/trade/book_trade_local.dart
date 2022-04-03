import 'package:equatable/equatable.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';

class BookTradeLocal extends Equatable {
  final String id;
  final DateTime startDate;
  final BookLocal book;
  final UserLocal owner;
  final UserLocal receiver;
  final TradeStatus status;

  const BookTradeLocal({
    required this.id,
    required this.startDate,
    required this.book,
    required this.owner,
    required this.receiver,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        startDate,
        book,
        owner,
        receiver,
        status,
      ];

  BookTradeLocal copyWith({
    String? id,
    DateTime? startDate,
    BookLocal? book,
    UserLocal? owner,
    UserLocal? receiver,
    TradeStatus? status,
  }) {
    return BookTradeLocal(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      book: book ?? this.book,
      owner: owner ?? this.owner,
      receiver: receiver ?? this.receiver,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '-------------\n'
        'Date of trade start: $startDate\n\n'
        'Book isbn: ${book.isbn}\n'
        'Book title: ${book.title}\n\n'
        'Owner: ${owner.firstName} ${owner.lastName} ${owner.email}\n '
        'Receiver: ${receiver.firstName} ${receiver.lastName} ${receiver.email}\n\n'
        'Status: ${status.name.toUpperCase()} \n'
        '-------------\n';
  }
}
