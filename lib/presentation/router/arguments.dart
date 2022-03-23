import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/user/user_local.dart';

class ScreenArguments {
  final BookLocal? bookLocal;
  final UserLocal? userLocal;

  const ScreenArguments({
    this.bookLocal,
    this.userLocal,
  });
}