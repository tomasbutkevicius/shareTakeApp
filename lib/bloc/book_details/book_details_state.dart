part of 'book_details_bloc.dart';


class BookDetailsState extends Equatable {
  final List<BookWantsRemote> wantedList;
  final RequestStatus status;
  final bool addedToWishList;

  const BookDetailsState({
    this.wantedList = const [],
    this.status = const RequestStatusInitial(),
    this.addedToWishList = false,
  });

  BookDetailsState copyWith({
    List<BookWantsRemote>? wantedList,
    RequestStatus? status,
    bool? addedToWishList,
  }) {
    return BookDetailsState(
      wantedList: wantedList ?? this.wantedList,
      status: status ?? this.status,
      addedToWishList: addedToWishList ?? this.addedToWishList,
    );
  }

  @override
  List<Object?> get props => [status, wantedList, addedToWishList];
}