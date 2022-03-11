part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class BookGetListEvent extends BookEvent {}

class BookResetEvent extends BookEvent {}