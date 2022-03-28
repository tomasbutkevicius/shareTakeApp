import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book_add/book_add_bloc.dart';
import 'package:share_take/bloc/book_list/book_list_bloc.dart';
import 'package:share_take/bloc/book_offer/book_offer_bloc.dart';
import 'package:share_take/bloc/book_want/book_want_bloc.dart';
import 'package:share_take/bloc/user_list/user_list_bloc.dart';
import 'package:share_take/bloc/user_offer/user_offer_bloc.dart';
import 'package:share_take/bloc/user_want/user_want_bloc.dart';

class BlocGetter {
  static BookListBloc getBookListBloc(BuildContext context) {
    return BlocProvider.of<BookListBloc>(context);
  }

  static BookWantBloc getBookWantBloc(BuildContext context) {
    return BlocProvider.of<BookWantBloc>(context);
  }

  static BookOfferBloc getBookOfferBloc(BuildContext context) {
    return BlocProvider.of<BookOfferBloc>(context);
  }

  static BookAddBloc getAddBookBloc(BuildContext context) {
    return BlocProvider.of<BookAddBloc>(context);
  }

  static AuthenticationBloc getAuthBloc(BuildContext context) {
    return BlocProvider.of<AuthenticationBloc>(context);
  }

  static UserListBloc getUserListBloc(BuildContext context) {
    return BlocProvider.of<UserListBloc>(context);
  }

  static UserWantBloc getUserWantBloc(BuildContext context) {
    return BlocProvider.of<UserWantBloc>(context);
  }

  static UserOfferBloc getUserOfferBloc(BuildContext context) {
    return BlocProvider.of<UserOfferBloc>(context);
  }
}