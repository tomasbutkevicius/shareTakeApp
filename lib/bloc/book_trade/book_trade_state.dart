part of 'book_trade_bloc.dart';

class BookTradeState extends Equatable {
  final BookTradeLocal? trade;
  final RequestStatus status;

  @override
  List<Object?> get props => [
        trade,
        status,
      ];

  const BookTradeState({
    this.trade,
    this.status = const RequestStatusInitial(),
  });

  BookTradeState copyWith({
    BookTradeLocal? trade,
    RequestStatus? status,
  }) {
    return BookTradeState(
      trade: trade ?? this.trade,
      status: status ?? this.status,
    );
  }
}
