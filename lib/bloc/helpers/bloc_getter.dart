import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book/book_bloc.dart';

class BlocGetter {
  static BookBloc getBookBloc(BuildContext context) {
    return BlocProvider.of<BookBloc>(context);
  }

  static AuthenticationBloc getAuthBloc(BuildContext context) {
    return BlocProvider.of<AuthenticationBloc>(context);
  }
}