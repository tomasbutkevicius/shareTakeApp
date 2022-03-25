part of 'book_want_bloc.dart';


class BookWantState extends Equatable {
  final List<UserLocal> wantedByUsersList;

  final RequestStatus status;
  final bool addedToWishList;

  const BookWantState({
    this.wantedByUsersList = const [],
    this.status = const RequestStatusInitial(),
    this.addedToWishList = false,
  });

  BookWantState copyWith({
    List<UserLocal>? wantedByUsersList,
    RequestStatus? status,
    bool? addedToWishList,
  }) {
    return BookWantState(
      wantedByUsersList: wantedByUsersList ?? this.wantedByUsersList,
      status: status ?? this.status,
      addedToWishList: addedToWishList ?? this.addedToWishList,
    );
  }

  @override
  List<Object?> get props => [status, wantedByUsersList, addedToWishList];
}
