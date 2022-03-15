
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/request/add_book_request.dart';

part 'book_add_event.dart';
part 'book_add_state.dart';

class BookAddBloc extends Bloc<BookAddEvent, BookAddState> {
  BookAddBloc() : super(const BookAddState()) {
    on<BookAddEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
