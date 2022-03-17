part of 'book_add_bloc.dart';

class BookAddState extends Equatable {
  final RequestStatus status;
  final BookLocal bookToAdd;
  final BookAddStage stage;

  const BookAddState({
    this.status = const RequestStatusInitial(),
    this.bookToAdd = const BookLocal(
      id: "0",
      title: "",
      authors: [],
      description: "",
      pages: 0,
    ),
    this.stage = const BookAddEditStage(),
  });

  BookAddState copyWith({
    RequestStatus? status,
    BookLocal? bookToAdd,
    BookAddStage? stage,
  }) {
    return BookAddState(
      status: status ?? this.status,
      bookToAdd: bookToAdd ?? this.bookToAdd,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        bookToAdd,
        stage,
      ];
}

abstract class BookAddStage {
  const BookAddStage();
}

class BookAddEditStage extends BookAddStage {
  const BookAddEditStage();
}

class BookAddReviewStage extends BookAddStage {
  const BookAddReviewStage();
}
