import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/data_providers/remote/remote_book_trade_source.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_request_source.dart';
import 'package:share_take/data/models/book/book_request_local.dart';
import 'package:share_take/data/models/trade/book_trade_remote.dart';

class TradeRepository {
  final RemoteBookRequestSource remoteBookRequestSource;
  final RemoteOfferSource remoteOfferSource;
  final RemoteBookTradeSource remoteBookTradeSource;

  const TradeRepository({
    required this.remoteBookRequestSource,
    required this.remoteOfferSource,
    required this.remoteBookTradeSource,
  });

  Future createBookTrade({
    required BookRequestLocal requestLocal,
  }) async {
    if(requestLocal.status != BookRequestStatus.accepted) {
      throw Exception("Request not accepted");
    }
    BookTradeRemote bookTradeRemote = BookTradeRemote(
      id: "",
      startDate: DateTime.now(),
      bookId: requestLocal.book.id,
      ownerId: requestLocal.owner.id,
      receiverId: requestLocal.receiver.id,
      status: TradeStatus.negotiating,
    );

    await remoteBookTradeSource.createBookTrade(bookTradeRemote);
  }

  Future<List<BookTradeRemote>> getUserTrades(String userId) async {
    return await remoteBookTradeSource.getUserTradeList(userId);
  }

  Future updateTradeStatus({required String userId, required String tradeId, required TradeStatus status}) async {
    return await remoteBookTradeSource.updateTradeStatus(userId, tradeId, status);
  }
}
