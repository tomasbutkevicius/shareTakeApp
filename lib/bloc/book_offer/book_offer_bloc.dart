import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/data_senders/email_service.dart';
import 'package:share_take/data/models/book_offers/book_offer_local.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/book_request_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

part 'book_offer_event.dart';

part 'book_offer_state.dart';

class BookOfferBloc extends Bloc<BookOfferEvent, BookOfferState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final BookRequestRepository tradeRepository;
  final AuthenticationBloc authenticationBloc;

  BookOfferBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
    required this.tradeRepository,
  }) : super(const BookOfferState()) {
    on<BookOfferResetEvent>((event, emit) async {
      emit(BookOfferState());
    });
    on<BookOfferGetEvent>((event, emit) async {
      emit(BookOfferState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookOfferRemote> bookOffers = await bookRepository.getBookOfferList(event.bookId);
        List<BookOfferLocal> offeredByUsersList = await getOfferedByUsersList(bookOffers);
        UserLocal? userLocal = authenticationBloc.state.user;
        if (userLocal == null) {
          emit(state.copyWith(offeredByUsersList: offeredByUsersList, status: RequestStatusInitial()));
        } else {
          bool addedToOfferList = false;
          for (BookOfferRemote offer in bookOffers) {
            if (offer.userId == userLocal.id) {
              addedToOfferList = true;
            }
          }
          emit(state.copyWith(
            addedToOfferList: addedToOfferList,
            offeredByUsersList: offeredByUsersList,
            status: RequestStatusInitial(),
          ));
        }
      } catch (e) {
        print("error book offer get");
        print(e.toString());
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookOfferAddToOfferedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.addBookToOfferList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToOfferList: true));
        add(BookOfferGetEvent(bookId: event.bookId));
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookOfferRemoveFromOfferedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.removeBookFromOfferList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToOfferList: false));
        add(BookOfferGetEvent(bookId: event.bookId));
      } catch (e) {
        print(e.toString());

        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookOfferRequestBookEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      UserLocal? user = authenticationBloc.state.user;
      try {
        if (user == null) {
          throw Exception("Please login to continue");
        }
        await tradeRepository.requestBook(
          bookId: event.offer.bookId,
          ownerId: event.offer.owner.id,
          receiverId: user.id,
          offerId: event.offer.offerId,
        );

        try{
          await EmailService.sendEmail(
            toEmails: [event.offer.owner.email],
            ccEmails: [user.email],
            subject: "(Share Take App) Book request received",
            body: "You have received notification from ${user.email} for your book offer",
          );
        }catch(e){}
        emit(state.copyWith(status: RequestStatusSuccess(message: "Request sent")));
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookOfferStatusResetEvent>((event, emit) {
      emit(state.copyWith(status: RequestStatusInitial()));
    });
  }

  Future<List<BookOfferLocal>> getOfferedByUsersList(List<BookOfferRemote> bookOffersData) async {
    List<BookOfferLocal> offeredByUsersList = [];
    try {
      List<UserLocal> userList = await userRepository.getAllUsers();

      for (UserLocal user in userList) {
        try {
          BookOfferRemote bookOfferRemote = bookOffersData.firstWhere((element) => element.userId == user.id);
          offeredByUsersList.add(BookOfferLocal(
            offerId: bookOfferRemote.id,
            owner: user,
            bookId: bookOfferRemote.bookId,
          ));
        } catch (e) {
          print(e.toString());
        }
      }

      return offeredByUsersList;
    } catch (e) {
      print(e.toString());

      throw Exception("Error getting user list for book offer list");
    }
  }
}
