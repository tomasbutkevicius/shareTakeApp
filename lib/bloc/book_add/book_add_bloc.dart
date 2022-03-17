import 'package:bloc/bloc.dart';
import 'package:books_finder/books_finder.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/repositories/book_repository.dart';
import 'package:share_take/utilities/static_utilities.dart';

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
        Book? foundBook = await bookRepository.getBookByIsbn(event.isbn);
        if (foundBook == null) {
          emit(
            state.copyWith(status: RequestStatusError(message: "Book not found")),
          );
          return;
        } else {
          print("FOUND BOOK");
          print(foundBook.toString());
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
    on<BookAddSubmitEvent>((event, emit) async {});

    on<BookAddEditStageEvent>(
      (event, emit) {
        emit(state.copyWith(stage: const BookAddEditStage()));
      },
    );
    on<BookAddReviewStageEvent>(
      (event, emit) {
        String? validationMessage = validateBookRequest(event.bookLocal);
        if (validationMessage != null) {
          emit(
            state.copyWith(
              status: RequestStatusError(
                message: validationMessage,
              ),
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            stage: const BookAddReviewStage(),
            bookToAdd: event.bookLocal,
          ),
        );
      },
    );
  }

  String? validateBookRequest(BookLocal? bookLocal) {
    // final String id;
    // final String? isbn;
    // final String title;
    // final String? subtitle;
    // final List<String> authors;
    // final String? imageUrl;
    // final String? language;
    // final int pages;
    // final DateTime? publishDate;
    // final String description;

    if (bookLocal == null) {
      return "Missing book information";
    }

    if (bookLocal.title.trim().isEmpty) {
      return "Title cannot be empty";
    }
    if (bookLocal.authors.isEmpty) {
      return "Book needs to have author";
    }
    if (bookLocal.pages <= 0) {
      return "Page number is not valid";
    }
    if (bookLocal.description.trim().isEmpty) {
      return "Description cannot be empty";
    }

    if (bookLocal.isbn != null) {
      if (!StaticUtilities.validISBN(bookLocal.isbn!)) {
        return "ISBN not valid";
      }
    }

    return null;
  }
}
