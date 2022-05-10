import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/data/models/user/user_local.dart';

class ScreenArguments {
  final BookLocal? bookLocal;
  final UserLocal? userLocal;
  final BookTradeLocal? tradeLocal;

  const ScreenArguments({
    this.bookLocal,
    this.userLocal,
    this.tradeLocal,
  });
}