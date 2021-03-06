import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/data_senders/email_service.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book/book_request_local.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/book_request_repository.dart';
import 'package:share_take/data/repositories/trade_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'requests_as_owner_event.dart';

part 'requests_as_owner_state.dart';

class RequestsAsOwnerBloc extends Bloc<RequestsAsOwnerEvent, RequestsAsOwnerState> {
  final AuthenticationBloc authenticationBloc;
  final BookRequestRepository requestRepository;
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final TradeRepository tradeRepository;

  RequestsAsOwnerBloc({
    required this.authenticationBloc,
    required this.requestRepository,
    required this.userRepository,
    required this.bookRepository,
    required this.tradeRepository,
  }) : super(const RequestsAsOwnerState()) {
    on<RequestsOwnerResetEvent>(_handleRequestsOwnerResetEvent);
    on<RequestsOwnerResetStatusEvent>(_handleRequestsOwnerResetStatusEvent);
    on<RequestsOwnerGetListEvent>(_handleRequestsOwnerGetListEvent);
    on<RequestsOwnerStatusUpdateEvent>(_handleRequestsOwnerStatusUpdateEvent);
    on<RequestsOwnerDeleteEvent>(_handleRequestsOwnerDeleteEvent);
    on<RequestsOwnerCreateBookTradeEvent>(_handleRequestsOwnerCreateBookTradeEvent);
  }

  void _handleRequestsOwnerResetEvent(RequestsOwnerResetEvent event, Emitter<RequestsAsOwnerState> emit) {
    emit(const RequestsAsOwnerState());
  }

  void _handleRequestsOwnerResetStatusEvent(RequestsOwnerResetStatusEvent event, Emitter<RequestsAsOwnerState> emit) {
    emit(state.copyWith(status: const RequestStatusInitial()));
  }

  Future _handleRequestsOwnerGetListEvent(RequestsOwnerGetListEvent event, Emitter<RequestsAsOwnerState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? loggedInUser = authenticationBloc.state.user;
      if (loggedInUser == null) {
        throw Exception("User not logged in");
      }
      print("GETTING BOOK REQUESTS");
      List<BookRequestRemote> remoteRequests = await requestRepository.getBookRequestsAsOwner(loggedInUser.id);
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
  }

  Future _handleRequestsOwnerStatusUpdateEvent(RequestsOwnerStatusUpdateEvent event, Emitter<RequestsAsOwnerState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? loggedInUser = authenticationBloc.state.user;
      if (loggedInUser == null) {
        throw Exception("User not logged in");
      }
      await requestRepository.updateBookRequestStatus(
        event.requestId,
        loggedInUser.id,
        event.status,
      );

      if(event.status == BookRequestStatus.accepted) {
        // try{
        // BookRequestLocal bookRequestLocal = state.requestList.firstWhere((element) => element.requestId == event.requestId);
        //
        //   await EmailService.sendEmail(
        //     toEmails: [bookRequestLocal.receiver.email],
        //     ccEmails: [bookRequestLocal.owner.email],
        //     subject: "(Share Take App) Book Request accepted!!",
        //     body: "Your request for ${bookRequestLocal.book.title} book has been accepted",
        //   );
        // }catch(e){}
      }

      add(RequestsOwnerGetListEvent());
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future _handleRequestsOwnerDeleteEvent(RequestsOwnerDeleteEvent event, Emitter<RequestsAsOwnerState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? user = authenticationBloc.state.user;
      if (user == null) {
        throw Exception("Please login");
      }
      await requestRepository.deleteBookRequest(user.id, event.requestId);
      add(RequestsOwnerGetListEvent());
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future _handleRequestsOwnerCreateBookTradeEvent(
      RequestsOwnerCreateBookTradeEvent event, Emitter<RequestsAsOwnerState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? user = authenticationBloc.state.user;
      if (user == null) {
        throw Exception("Please login");
      }
      await tradeRepository.createBookTrade(
        requestLocal: event.requestLocal,
      );
      add(RequestsOwnerGetListEvent());
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
