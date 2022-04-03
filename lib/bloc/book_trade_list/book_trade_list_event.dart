part of 'book_trade_list_bloc.dart';

@immutable
abstract class BookTradeListEvent {}

class BookTradeListResetStatusEvent extends BookTradeListEvent {}

class BookTradeListResetEvent extends BookTradeListEvent {}

class BookTradeListGetListEvent extends BookTradeListEvent {}