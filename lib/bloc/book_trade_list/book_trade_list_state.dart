part of 'book_trade_list_bloc.dart';

class BookTradeListState extends Equatable {
  final List<BookTradeLocal> tradeList;
  final RequestStatus status;

  @override
  List<Object?> get props => [tradeList, status,];

  const BookTradeListState({
    this.tradeList = const [],
    this.status = const RequestStatusInitial(),
  });

  BookTradeListState copyWith({
    List<BookTradeLocal>? tradeList,
    RequestStatus? status,
  }) {
    return BookTradeListState(
      tradeList: tradeList ?? this.tradeList,
      status: status ?? this.status,
    );
  }
}