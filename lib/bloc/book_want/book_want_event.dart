part of 'book_want_bloc.dart';

@immutable
abstract class BookWantEvent {}

class BookWantResetEvent extends BookWantEvent {}

class BookWantGetEvent extends BookWantEvent {
  final String bookId;

  BookWantGetEvent({
    required this.bookId,
  });
}

class BookWantAddToWantedEvent extends BookWantEvent {
  final String bookId;
  final BuildContext context;

  BookWantAddToWantedEvent({
    required this.bookId,
    required this.context,
  });
}

class BookWantRemoveFromWantedEvent extends BookWantEvent {
  final String bookId;
  final BuildContext context;

  BookWantRemoveFromWantedEvent({
    required this.bookId,
    required this.context,
  });
}