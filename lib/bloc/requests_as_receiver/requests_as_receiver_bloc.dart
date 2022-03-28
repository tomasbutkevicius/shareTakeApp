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
import 'package:share_take/data/repositories/trade_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'requests_as_receiver_event.dart';

part 'requests_as_receiver_state.dart';

class RequestsAsReceiverBloc extends Bloc<RequestsAsReceiverEvent, RequestsAsReceiverState> {
  final AuthenticationBloc authenticationBloc;
  final TradeRepository tradeRepository;
  final UserRepository userRepository;
  final BookRepository bookRepository;

  RequestsAsReceiverBloc({
    required this.authenticationBloc,
    required this.tradeRepository,
    required this.userRepository,
    required this.bookRepository,
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
        List<BookRequestRemote> remoteRequests = await tradeRepository.getBookRequestsAsReceiver(loggedInUser.id);
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
  }

  Future<List<BookRequestLocal>> convertRemoteRequestsToLocal(List<BookRequestRemote> requestListRemote) async {
    List<BookRequestLocal> requestListLocal = [];
    try {
      List<UserLocal> users = await userRepository.getAllUsers();
      List<BookLocal> books = await bookRepository.getAllBooks();

      for (BookRequestRemote requestRemote in requestListRemote) {
        UserLocal? owner;
        UserLocal? receiver;
        BookLocal? book;

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
            book = book;
          }
        }

        if (owner != null && receiver != null && book != null) {
          requestListLocal.add(
            BookRequestLocal(
              requestId: requestRemote.id,
              book: book,
              owner: owner,
              receiver: receiver,
              offerId: requestRemote.offerId,
              status: requestRemote.status,
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
