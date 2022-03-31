import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/data/models/trade/book_trade_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/trade_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'book_trade_list_event.dart';

part 'book_trade_list_state.dart';

class BookTradeListBloc extends Bloc<BookTradeListEvent, BookTradeListState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final TradeRepository tradeRepository;

  BookTradeListBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
    required this.tradeRepository,
  }) : super(const BookTradeListState()) {
    on<BookTradeListResetEvent>(_handleBookTradeListResetEvent);
    on<BookTradeListResetStatusEvent>(_handleBookTradeListResetStatusEvent);
    on<BookTradeListGetListEvent>(_handleBookTradeListGetListEvent);
  }

  void _handleBookTradeListResetEvent(BookTradeListResetEvent event, Emitter<BookTradeListState> emit) {
    emit(const BookTradeListState());
  }

  void _handleBookTradeListResetStatusEvent(BookTradeListResetStatusEvent event, Emitter<BookTradeListState> emit) {
    emit(state.copyWith(status: const RequestStatusInitial()));
  }

  Future _handleBookTradeListGetListEvent(BookTradeListGetListEvent event, Emitter<BookTradeListState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? loggedInUser = authenticationBloc.state.user;
      if (loggedInUser == null) {
        throw Exception("User not logged in");
      }
      print("GETTING BOOK TRADES");
      List<BookTradeRemote> remoteTrades = await tradeRepository.getUserTrades(loggedInUser.id);
      List<BookTradeLocal> localTrades = await convertRemoteTradesToLocal(remoteTrades);

      emit(
        state.copyWith(
          status: RequestStatusInitial(),
          tradeList: localTrades,
        ),
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future<List<BookTradeLocal>> convertRemoteTradesToLocal(List<BookTradeRemote> tradeListRemote) async {
    List<BookTradeLocal> tradeListLocal = [];
    try {
      List<UserLocal> users = await userRepository.getAllUsers();
      List<BookLocal> books = await bookRepository.getAllBooks();

      for (BookTradeRemote remoteTrade in tradeListRemote) {
        UserLocal? owner;
        UserLocal? receiver;
        BookLocal? bookOffered;

        for (UserLocal user in users) {
          if (user.id == remoteTrade.ownerId) {
            owner = user;
          }
          if (user.id == remoteTrade.receiverId) {
            receiver = user;
          }
        }

        for (BookLocal book in books) {
          if (book.id == remoteTrade.bookId) {
            bookOffered = book;
          }
        }

        if (owner != null && receiver != null && bookOffered != null) {
          tradeListLocal.add(
            BookTradeLocal(
              id: remoteTrade.id,
              book: bookOffered,
              owner: owner,
              receiver: receiver,
              status: remoteTrade.status,
              startDate: remoteTrade.startDate,
            ),
          );
        }
      }

      return tradeListLocal;
    } catch (e) {
      print(e.toString());

      throw Exception("Error converting requests for receiver");
    }
  }
}
