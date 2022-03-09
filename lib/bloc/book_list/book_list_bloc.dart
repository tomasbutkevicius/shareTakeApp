import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {


  BookListBloc() : super(BookListInitial()) {
    on<BookListGetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}