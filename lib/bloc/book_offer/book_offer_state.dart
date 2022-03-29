part of 'book_offer_bloc.dart';


class BookOfferState extends Equatable {
  final List<BookOfferLocal> offeredByUsersList;

  final RequestStatus status;
  final bool addedToOfferList;

  const BookOfferState({
    this.offeredByUsersList = const [],
    this.status = const RequestStatusInitial(),
    this.addedToOfferList = false,
  });

  BookOfferState copyWith({
    List<BookOfferLocal>? offeredByUsersList,
    RequestStatus? status,
    bool? addedToOfferList,
  }) {
    return BookOfferState(
      offeredByUsersList: offeredByUsersList ?? this.offeredByUsersList,
      status: status ?? this.status,
      addedToOfferList: addedToOfferList ?? this.addedToOfferList,
    );
  }

  @override
  List<Object?> get props => [status, offeredByUsersList, addedToOfferList];
}
