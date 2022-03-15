part of 'book_list_bloc.dart';


class BookListState extends Equatable {
  final RequestStatus status;
  final List<Book> bookList;

  const BookListState({
    this.status = const RequestStatusInitial(),
    this.bookList = const [],
  });

  BookListState copyWith({
    RequestStatus? status,
    List<Book>? bookList,
  }) {
    return BookListState(
      status: status ?? this.status,
      bookList: bookList ?? this.bookList,
    );
  }

  @override
  List<Object?> get props => [status, bookList];


}