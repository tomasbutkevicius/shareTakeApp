import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

part 'user_want_event.dart';

part 'user_want_state.dart';

class UserWantBloc extends Bloc<UserWantEvent, UserWantState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  UserWantBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
  }) : super(const UserWantState()) {
    on<UserWantResetEvent>((event, emit) async {
      emit(UserWantState());
    });
    on<UserWantGetEvent>((event, emit) async {
      emit(UserWantState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookWantsRemote> wishList = await bookRepository.getUserWishList(event.userId);
        List<BookLocal> booksWanted = await getBookListFromWish(wishList);
        emit(state.copyWith(status: const RequestStatusInitial(), wantedBooks: booksWanted));
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
  }

  Future<List<BookLocal>> getBookListFromWish(List<BookWantsRemote> bookWantsData) async {
    List<BookLocal> books = [];
    try {
      List<BookLocal> bookList = await bookRepository.getAllBooks();

      for (BookLocal book in bookList) {
        try {
          bookWantsData.firstWhere((element) => element.bookId == book.id);
          books.add(book);
        } catch (e) {}
      }

      return books;
    } catch (e) {
      print(e.toString());

      throw Exception("Error getting book list for user wish list");
    }
  }
}
