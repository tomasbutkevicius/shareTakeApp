part of 'book_add_bloc.dart';

class BookAddState extends Equatable {
  final RequestStatus status;
  final AddBookRequest? addBookRequest;

  const BookAddState({
    this.status = const RequestStatusInitial(),
    this.addBookRequest,
  });

  BookAddState copyWith({
    RequestStatus? status,
    AddBookRequest? addBookRequest,
  }) {
    return BookAddState(
      status: status ?? this.status,
      addBookRequest: addBookRequest ?? this.addBookRequest,
    );
  }

  @override
  List<Object?> get props => [status, addBookRequest];
}