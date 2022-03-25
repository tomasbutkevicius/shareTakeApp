import 'package:equatable/equatable.dart';
import 'package:share_take/data/models/user/user_local.dart';

class BookOfferLocal extends Equatable {
  final String offerId;
  final UserLocal user;

  const BookOfferLocal({
    required this.offerId,
    required this.user,
  });

  @override
  List<Object?> get props => [offerId, user,];
}
