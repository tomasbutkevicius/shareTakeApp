import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'book_details_event.dart';

part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  BookDetailsBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
  }) : super(const BookDetailsState()) {
    on<BookDetailsResetEvent>((event, emit) async {
      emit(BookDetailsState());
    });
    on<BookDetailsGetEvent>((event, emit) async {
      emit(BookDetailsState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookWantsRemote> bookWants = await bookRepository.getBookWantedList(event.bookId);
        List<UserLocal> wantedByUsersList = await getWantedByUsersList(bookWants);
        UserLocal? userLocal = authenticationBloc.state.user;
        if (userLocal == null) {
          emit(state.copyWith(wantedByUsersList: wantedByUsersList));
          emit(state.copyWith(status: RequestStatusInitial()));
        } else {
          try {
            bookWants.firstWhere((element) => element.userId == userLocal.id);
            emit(state.copyWith(addedToWishList: true, wantedByUsersList: wantedByUsersList));
          } catch (e) {}
        }
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookDetailsAddToWantedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.addBookToWishList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToWishList: true));
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<BookDetailsRemoveFromWantedEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        await userRepository.removeBookFromWishList(event.bookId);
        emit(state.copyWith(status: RequestStatusInitial(), addedToWishList: false));
        add(BookDetailsGetEvent(bookId: event.bookId));
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
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
