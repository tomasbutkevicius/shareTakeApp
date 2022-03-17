part of 'book_add_bloc.dart';

@immutable
abstract class BookAddEvent {}

class BookAddStatusResetEvent extends BookAddEvent {}

class BookAddHandleIsbnEvent extends BookAddEvent {
  final String isbn;

  BookAddHandleIsbnEvent({
    required this.isbn,
  });
}

class BookAddEditStageEvent extends BookAddEvent {}

class BookAddReviewStageEvent extends BookAddEvent {
  final BookLocal bookLocal;

  BookAddReviewStageEvent({
    required this.bookLocal,
  });
}

class BookAddSubmitEvent extends BookAddEvent {
  final BookLocal bookLocal;

  BookAddSubmitEvent({
    required this.bookLocal,
  });
}