part of 'book_details_bloc.dart';


class BookDetailsState extends Equatable {
  final List<UserLocal> wantedByUsersList;
  final List<UserLocal> offeredByList;

  final RequestStatus status;
  final bool addedToWishList;

  const BookDetailsState({
    this.wantedByUsersList = const [],
    this.offeredByList = const [],
    this.status = const RequestStatusInitial(),
    this.addedToWishList = false,
  });

  BookDetailsState copyWith({
    List<UserLocal>? wantedByUsersList,
    RequestStatus? status,
    bool? addedToWishList,
  }) {
    return BookDetailsState(
      wantedByUsersList: wantedByUsersList ?? this.wantedByUsersList,
      status: status ?? this.status,
      addedToWishList: addedToWishList ?? this.addedToWishList,
    );
  }

  @override
  List<Object?> get props => [status, wantedByUsersList, addedToWishList];
}
