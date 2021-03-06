import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book/book_request_local.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/book_request_repository.dart';
import 'package:share_take/data/repositories/trade_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'requests_as_receiver_event.dart';

part 'requests_as_receiver_state.dart';

class RequestsAsReceiverBloc extends Bloc<RequestsAsReceiverEvent, RequestsAsReceiverState> {
  final AuthenticationBloc authenticationBloc;
  final BookRequestRepository requestRepository;
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final TradeRepository tradeRepository;

  RequestsAsReceiverBloc({
    required this.authenticationBloc,
    required this.requestRepository,
    required this.userRepository,
    required this.bookRepository,
    required this.tradeRepository,
  }) : super(const RequestsAsReceiverState()) {
    on<RequestsReceiverResetEvent>((event, emit) {
      emit(RequestsAsReceiverState());
    });
    on<RequestsReceiverResetStatusEvent>((event, emit) {
      emit(state.copyWith(status: const RequestStatusInitial()));
    });
    on<RequestsReceiverGetListEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        UserLocal? loggedInUser = authenticationBloc.state.user;
        if (loggedInUser == null) {
          throw Exception("User not logged in");
        }
        List<BookRequestRemote> remoteRequests = await requestRepository.getBookRequestsAsReceiver(loggedInUser.id);
        List<BookRequestLocal> localRequests = await convertRemoteRequestsToLocal(remoteRequests);

        emit(
          state.copyWith(
            status: RequestStatusInitial(),
            requestList: localRequests,
          ),
        );
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<RequestsReceiverCreateBookTradeEvent>(_handleRequestsReceiverCreateBookTradeEvent);
  }

  Future _handleRequestsReceiverCreateBookTradeEvent(
      RequestsReceiverCreateBookTradeEvent event, Emitter<RequestsAsReceiverState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? user = authenticationBloc.state.user;
      if (user == null) {
        throw Exception("Please login");
      }
      await tradeRepository.createBookTrade(
        requestLocal: event.requestLocal,
      );
      add(RequestsReceiverGetListEvent());
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future<List<BookRequestLocal>> convertRemoteRequestsToLocal(List<BookRequestRemote> requestListRemote) async {
    List<BookRequestLocal> requestListLocal = [];
    try {
      List<UserLocal> users = await userRepository.getAllUsers();
      List<BookLocal> books = await bookRepository.getAllBooks();

      for (BookRequestRemote requestRemote in requestListRemote) {
        UserLocal? owner;
        UserLocal? receiver;
        BookLocal? bookOffered;

        for (UserLocal user in users) {
          if (user.id == requestRemote.ownerId) {
            owner = user;
          }
          if (user.id == requestRemote.receiverId) {
            receiver = user;
          }
        }

        for (BookLocal book in books) {
          if (book.id == requestRemote.bookId) {
            bookOffered = book;
          }
        }

        if (owner != null && receiver != null && bookOffered != null) {
          requestListLocal.add(
            BookRequestLocal(
              requestId: requestRemote.id,
              book: bookOffered,
              owner: owner,
              receiver: receiver,
              offerId: requestRemote.offerId,
              status: requestRemote.status,
              editable: requestRemote.editable,
            ),
          );
        }
      }

      return requestListLocal;
    } catch (e) {
      print(e.toString());

      throw Exception("Error converting requests for receiver");
    }
  }
}
