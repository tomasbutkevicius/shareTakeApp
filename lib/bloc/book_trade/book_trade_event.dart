part of 'book_trade_bloc.dart';

@immutable
abstract class BookTradeEvent {}

class BookTradeResetStatusEvent extends BookTradeEvent {}

class BookTradeResetEvent extends BookTradeEvent {}

class BookTradeOpenEvent extends BookTradeEvent {
  final BookTradeLocal selectedTrade;

  BookTradeOpenEvent({
    required this.selectedTrade,
  });
}

class BookTradeUpdateStatusEvent extends BookTradeEvent {
  final TradeStatus status;

  BookTradeUpdateStatusEvent({
    required this.status,
  });
}