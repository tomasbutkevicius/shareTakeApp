part of 'book_offer_bloc.dart';

@immutable
abstract class BookOfferEvent {}

class BookOfferResetEvent extends BookOfferEvent {}

class BookOfferStatusResetEvent extends BookOfferEvent {}

class BookOfferGetEvent extends BookOfferEvent {
  final String bookId;

  BookOfferGetEvent({
    required this.bookId,
  });
}

class BookOfferAddToOfferedEvent extends BookOfferEvent {
  final String bookId;
  final BuildContext context;

  BookOfferAddToOfferedEvent({
    required this.bookId,
    required this.context,
  });
}

class BookOfferRequestBookEvent extends BookOfferEvent {
  final BookOfferLocal offer;
  final BuildContext context;

  BookOfferRequestBookEvent({
    required this.offer,
    required this.context,
  });
}

class BookOfferRemoveFromOfferedEvent extends BookOfferEvent {
  final String bookId;
  final BuildContext context;

  BookOfferRemoveFromOfferedEvent({
    required this.bookId,
    required this.context,
  });
}