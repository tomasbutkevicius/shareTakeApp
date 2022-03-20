import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/book_list/book_list_bloc.dart';

class BlocGetter {
  static BookListBloc getBookListBloc(BuildContext context) {
    return BlocProvider.of<BookListBloc>(context);
  }

  static BookAddBloc getAddBookBloc(BuildContext context) {
    return BlocProvider.of<BookAddBloc>(context);
  }

  static AuthenticationBloc getAuthBloc(BuildContext context) {
    return BlocProvider.of<AuthenticationBloc>(context);
  }
}