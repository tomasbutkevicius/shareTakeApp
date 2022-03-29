import 'package:equatable/equatable.dart';
import 'package:share_take/data/models/user/user_local.dart';

class BookOfferLocal extends Equatable {
  final String offerId;
  final String bookId;
  final UserLocal owner;

  const BookOfferLocal({
    required this.offerId,
    required this.bookId,
    required this.owner,
  });

  @override
  List<Object?> get props => [offerId, bookId, owner,];
}
