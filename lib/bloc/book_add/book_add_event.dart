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