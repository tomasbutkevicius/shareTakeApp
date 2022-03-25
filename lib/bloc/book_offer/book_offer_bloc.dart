import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

part 'book_offer_event.dart';

part 'book_offer_state.dart';

class BookOfferBloc extends Bloc<BookOfferEvent, BookOfferState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  BookOfferBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
  }) : super(const BookOfferState()) {
    on<BookOfferResetEvent>((event, emit) async {
      emit(BookOfferState());
    });
    on<BookOfferGetEvent>((event, emit) async {
      emit(BookOfferState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookOfferRemote> bookOffers = await bookRepository.getBookOfferList(event.bookId);
        List<UserLocal> offeredByUsersList = await getOfferedByUsersList(bookOffers);
        UserLocal? userLocal = authenticationBloc.state.user;
        if (userLocal == null) {
          emit(state.copyWith(offeredByUsersList: offeredByUsersList));
          emit(state.copyWith(status: RequestStatusInitial()));
        } else {
          try {
            bookOffers.firstWhere((element) => element.userId == userLocal.id);
            emit(state.copyWith(addedToOfferList: true, offeredByUsersList: offeredByUsersList));
          } catch (e) {}
        }
      } catch (e) {
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
        await StaticWidgets.showDefaultDialog(
          context: event.context,
          text: e.toString(),
        ).then((value) {
          emit(state.copyWith(status: RequestStatusInitial()));
        });
      }
    });
    on<BookOfferRemoveFromOfferedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.removeBookFromOfferList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToOfferList: false));
        add(BookOfferGetEvent(bookId: event.bookId));
      } catch (e) {
        await StaticWidgets.showDefaultDialog(
          context: event.context,
          text: e.toString(),
        ).then((value) {
          emit(state.copyWith(status: RequestStatusInitial()));
        });
      }
    });
  }

  Future<List<UserLocal>> getOfferedByUsersList(List<BookOfferRemote> bookOffersData) async {
    List<UserLocal> offeredByUsersList = [];
    try {
      List<UserLocal> userList = await userRepository.getAllUsers();

      for (UserLocal user in userList) {
        try {
          bookOffersData.firstWhere((element) => element.userId == user.id);
          offeredByUsersList.add(user);
        } catch (e) {}
      }

      return offeredByUsersList;
    } catch (e) {
      throw Exception("Error getting user list for book offer list");
    }
  }
}
