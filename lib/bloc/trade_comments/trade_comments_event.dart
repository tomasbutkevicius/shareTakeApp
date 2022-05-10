part of 'trade_comments_bloc.dart';

@immutable
abstract class TradeCommentsEvent {}

class TradeCommentsResetEvent extends TradeCommentsEvent {}

class TradeCommentsGetEvent extends TradeCommentsEvent {
  final String tradeId;

  TradeCommentsGetEvent({
    required this.tradeId,
  });
}

class TradeCommentsCreateEvent extends TradeCommentsEvent {
  final String text;
  final String tradeId;

  TradeCommentsCreateEvent({
    required this.text,
    required this.tradeId,
  });
}


class TradeCommentsDeleteEvent extends TradeCommentsEvent {
  final BookTradeCommentModel comment;

  TradeCommentsDeleteEvent({
    required this.comment,
  });
}
