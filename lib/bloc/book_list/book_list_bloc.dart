import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';

part 'book_list_event.dart';

part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final BookRepository bookRepository;
  final AuthenticationBloc authenticationBloc;

  BookListBloc({
    required this.bookRepository,
    required this.authenticationBloc,
  }) : super(const BookListState()) {
    on<BookListGetListEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: RequestStatusLoading(),
        ),
      );
      List<BookLocal> books = await bookRepository.getAllBooks();
      for (BookLocal book in books) {
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

    on<BookListResetEvent>(
      (event, emit) {
        emit(
          const BookListState(),
        );
        add(BookListGetListEvent());
        print("Book reset called");
      },
    );
  }

  UserLocal? get user => authenticationBloc.state.user;
}
