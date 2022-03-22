part of 'book_details_bloc.dart';

@immutable
abstract class BookDetailsEvent {}

class BookDetailsGetEvent extends BookDetailsEvent {
  final String bookId;

  BookDetailsGetEvent({
    required this.bookId,
  });
}

class BookDetailsAddToWantedEvent extends BookDetailsEvent {
  final String bookId;

  BookDetailsAddToWantedEvent({
    required this.bookId,
  });
}

class BookDetailsRemoveFromWantedEvent extends BookDetailsEvent {
  final String bookId;

  BookDetailsRemoveFromWantedEvent({
    required this.bookId,
  });
}