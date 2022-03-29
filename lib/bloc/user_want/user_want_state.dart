part of 'user_want_bloc.dart';


class UserWantState extends Equatable {
  final List<BookLocal> wantedBooks;

  final RequestStatus status;

  const UserWantState({
    this.wantedBooks = const [],
    this.status = const RequestStatusInitial(),
  });

  UserWantState copyWith({
    List<BookLocal>? wantedBooks,
    RequestStatus? status,
  }) {
    return UserWantState(
      wantedBooks: wantedBooks ?? this.wantedBooks,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, wantedBooks,];
}
