import 'package:bloc/bloc.dart';
import 'package:books_finder/books_finder.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/request/add_book_request.dart';
import 'package:share_take/data/repositories/book_repository.dart';

part 'book_add_event.dart';

part 'book_add_state.dart';

class BookAddBloc extends Bloc<BookAddEvent, BookAddState> {
  final BookRepository bookRepository;

  BookAddBloc({required this.bookRepository}) : super(const BookAddState()) {
    on<BookAddStatusResetEvent>((event, emit) => emit(state.copyWith(status: RequestStatusInitial())));
    on<BookAddHandleIsbnEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: RequestStatusLoading(),
        ),
      );
      try {
        Book? foundBook = await bookRepository.getBookByIsbn("9781119530824");
        if (foundBook == null) {
          emit(
            state.copyWith(status: RequestStatusError(message: "Book not found")),
          );
          return;
        } else {
          BookLocal bookLocal = BookLocal.fromBookFinder(foundBook, event.isbn);

          emit(
            state.copyWith(
              bookToAdd: bookLocal,
              status: RequestStatusSuccess(message: ""),
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(
          status: RequestStatusError(
            message: e.toString(),
          ),
        ));
      }
    });
  }
}
