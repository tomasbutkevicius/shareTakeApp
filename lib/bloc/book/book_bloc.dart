import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book.dart';
import 'package:share_take/data/models/response/book_response.dart';
import 'package:share_take/data/repositories/book_repository.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc({required this.bookRepository}) : super(const BookState()) {
    on<BookGetListEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: RequestStatusLoading(),
        ),
      );
        List<Book> books = await bookRepository.getAllBooks();
        for (Book book in books) {
          print(book.title);
          print(book.imageUrl);

        }
        emit(
          state.copyWith(
            status: const RequestStatusSuccess(message: ""),
            bookList: books,
          ),
        );


    });

    on<BookResetEvent>((event, emit) => emit(const BookState(),),);
  }
}
