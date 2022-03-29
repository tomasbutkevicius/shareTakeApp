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
}
