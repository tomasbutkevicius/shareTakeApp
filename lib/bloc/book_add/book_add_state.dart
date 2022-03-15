part of 'book_add_bloc.dart';

class BookAddState extends Equatable {
  final RequestStatus status;
  final BookLocal? bookToAdd;

  const BookAddState({
    this.status = const RequestStatusInitial(),
    this.bookToAdd,
  });

  BookAddState copyWith({
    RequestStatus? status,
    BookLocal? bookToAdd,
  }) {
    return BookAddState(
      status: status ?? this.status,
      bookToAdd: bookToAdd ?? this.bookToAdd,
    );
  }

  @override
  List<Object?> get props => [status, bookToAdd];
}