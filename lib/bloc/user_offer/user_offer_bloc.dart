import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';

part 'user_offer_event.dart';

part 'user_offer_state.dart';

class UserOfferBloc extends Bloc<UserOfferEvent, UserOfferState> {
  final UserRepository userRepository;
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  UserOfferBloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.bookRepository,
  }) : super(const UserOfferState()) {
    on<UserOfferResetEvent>((event, emit) async {
      emit(UserOfferState());
    });
    on<UserOfferGetEvent>((event, emit) async {
      emit(UserOfferState());
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<BookOfferRemote> offerList = await bookRepository.getUserOfferList(event.userId);
        List<BookLocal> booksOffered = await getBookListFromOffer(offerList);
        emit(state.copyWith(status: const RequestStatusInitial(), offeredBooks: booksOffered));
      } catch (e) {
        print(e.toString());
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
  }

  Future<List<BookLocal>> getBookListFromOffer(List<BookOfferRemote> bookOffersData) async {
    List<BookLocal> books = [];
    try {
      List<BookLocal> bookList = await bookRepository.getAllBooks();

      for (BookLocal book in bookList) {
        try {
          bookOffersData.firstWhere((element) => element.bookId == book.id);
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
