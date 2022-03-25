import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

part 'book_want_event.dart';

part 'book_want_state.dart';

class BookWantBloc extends Bloc<BookWantEvent, BookWantState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  BookWantBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
  }) : super(const BookWantState()) {
    on<BookWantResetEvent>((event, emit) async {
      emit(BookWantState());
    });
    on<BookWantGetEvent>((event, emit) async {
      emit(BookWantState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookWantsRemote> bookWants = await bookRepository.getBookWantedList(event.bookId);
        List<UserLocal> wantedByUsersList = await getWantedByUsersList(bookWants);
        UserLocal? userLocal = authenticationBloc.state.user;
        if (userLocal == null) {
          emit(state.copyWith(wantedByUsersList: wantedByUsersList));
          emit(state.copyWith(status: RequestStatusInitial()));
        } else {
          bool addedToWishList = false;
          for(BookWantsRemote want in bookWants){
            if(want.userId == userLocal.id){
              addedToWishList = true;
            }
          }
          emit(state.copyWith(addedToWishList: addedToWishList, wantedByUsersList: wantedByUsersList));
        }
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookWantAddToWantedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.addBookToWishList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToWishList: true));
        add(BookWantGetEvent(bookId: event.bookId));
      } catch (e) {
        await StaticWidgets.showDefaultDialog(
          context: event.context,
          text: e.toString(),
        ).then((value) {
          emit(state.copyWith(status: RequestStatusInitial()));
        });
      }
    });
    on<BookWantRemoveFromWantedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.removeBookFromWishList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToWishList: false));
        add(BookWantGetEvent(bookId: event.bookId));
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

  Future<List<UserLocal>> getWantedByUsersList(List<BookWantsRemote> bookWantsData) async {
    List<UserLocal> wantedByUsersList = [];
    try {
      List<UserLocal> userList = await userRepository.getAllUsers();

      for (UserLocal user in userList) {
        try {
          bookWantsData.firstWhere((element) => element.userId == user.id);
          wantedByUsersList.add(user);
        } catch (e) {}
      }

      return wantedByUsersList;
    } catch (e) {
      throw Exception("Error getting user list for book wanted list");
    }
  }
}
