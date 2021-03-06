import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book_trade_list/book_trade_list_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/trade_repository.dart';

part 'book_trade_event.dart';

part 'book_trade_state.dart';

class BookTradeBloc extends Bloc<BookTradeEvent, BookTradeState> {
  final AuthenticationBloc authenticationBloc;
  final TradeRepository tradeRepository;
  final BookTradeListBloc bookTradeListBloc;

  BookTradeBloc({
    required this.authenticationBloc,
    required this.tradeRepository,
    required this.bookTradeListBloc,
  }) : super(const BookTradeState()) {
    on<BookTradeResetEvent>(_handleBookTradeResetEvent);
    on<BookTradeResetStatusEvent>(_handleBookTradeResetStatusEvent);
    on<BookTradeOpenEvent>(_handleBookTradeOpenEvent);
    on<BookTradeUpdateStatusEvent>(_handleBookTradeUpdateStatusEvent);
  }

  void _handleBookTradeResetEvent(BookTradeResetEvent event, Emitter<BookTradeState> emit) {
    emit(const BookTradeState());
  }

  void _handleBookTradeResetStatusEvent(BookTradeResetStatusEvent event, Emitter<BookTradeState> emit) {
    emit(state.copyWith(status: const RequestStatusInitial()));
  }

  void _handleBookTradeOpenEvent(BookTradeOpenEvent event, Emitter<BookTradeState> emit) {
    emit(state.copyWith(trade: event.selectedTrade, status: const RequestStatusInitial()));
  }

  Future _handleBookTradeUpdateStatusEvent(BookTradeUpdateStatusEvent event, Emitter<BookTradeState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? loggedInUser = authenticationBloc.state.user;
      if (loggedInUser == null) {
        throw Exception("User not logged in");
      }

      BookTradeLocal? trade = state.trade;

      if (trade == null) {
        throw Exception("Trade not selected");
      }
      if (trade.status == event.status) {
        throw Exception("Wanted status already selected");
      }

      await tradeRepository.updateTradeStatus(
        userId: loggedInUser.id,
        tradeId: trade.id,
        status: event.status,
      );
      
      emit(
        state.copyWith(
          status: const RequestStatusInitial(),
          trade: trade.copyWith(status: event.status),
        ),
      );
      bookTradeListBloc.add(BookTradeListGetListEvent());
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }
}
