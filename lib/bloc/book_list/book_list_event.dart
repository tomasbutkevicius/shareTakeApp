part of 'book_list_bloc.dart';

@immutable
abstract class BookListEvent {}

class BookListGetListEvent extends BookListEvent {}

class BookListResetEvent extends BookListEvent {}