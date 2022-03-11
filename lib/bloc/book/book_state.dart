part of 'book_bloc.dart';


class BookState extends Equatable {
  final RequestStatus status;
  final List<Book> bookList;

  const BookState({
    this.status = const RequestStatusInitial(),
    this.bookList = const [],
  });

  BookState copyWith({
    RequestStatus? status,
    List<Book>? bookList,
  }) {
    return BookState(
      status: status ?? this.status,
      bookList: bookList ?? this.bookList,
    );
  }

  @override
  List<Object?> get props => [status, bookList];


}