part of 'user_offer_bloc.dart';


class UserOfferState extends Equatable {
  final List<BookLocal> offeredBooks;

  final RequestStatus status;

  const UserOfferState({
    this.offeredBooks = const [],
    this.status = const RequestStatusInitial(),
  });

  UserOfferState copyWith({
    List<BookLocal>? offeredBooks,
    RequestStatus? status,
  }) {
    return UserOfferState(
      offeredBooks: offeredBooks ?? this.offeredBooks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, offeredBooks,];
}
