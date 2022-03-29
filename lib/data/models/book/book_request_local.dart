import 'package:equatable/equatable.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';

class BookRequestLocal extends Equatable {
  final String requestId;
  final BookLocal book;
  final UserLocal owner;
  final UserLocal receiver;
  final String offerId;
  final BookRequestStatus status;
  final bool editable;

  const BookRequestLocal({
    required this.requestId,
    required this.book,
    required this.owner,
    required this.receiver,
    required this.offerId,
    required this.status,
    required this.editable,
  });

  @override
  List<Object?> get props => [
        requestId,
        book,
        owner,
        receiver,
        offerId,
        status,
        editable,
      ];
}
