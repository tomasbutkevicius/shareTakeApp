import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_request_source.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';

class TradeRepository {
  final RemoteBookRequestSource remoteBookRequestSource;
  final RemoteOfferSource remoteOfferSource;

  const TradeRepository({
    required this.remoteBookRequestSource,
    required this.remoteOfferSource,
  });

  Future requestBook({
    required String bookId,
    required String ownerId,
    required String receiverId,
    required String offerId,
  }) async {
    try {
      await remoteOfferSource.getOfferById(offerId);
    } catch (e) {
      throw Exception("Could not find offer");
    }

    BookRequestRemote request = BookRequestRemote(
      id: "",
      bookId: bookId,
      ownerId: ownerId,
      receiverId: receiverId,
      offerId: offerId,
      status: BookRequestStatus.waiting,
    );

    await remoteBookRequestSource.requestBook(request);
  }

  Future<List<BookRequestRemote>> getBookRequestsAsReceiver(String userId) async {
    return remoteBookRequestSource.getUserRequestListAsReceiver(userId);
  }

  Future<List<BookRequestRemote>> getBookRequestsAsOwner(String userId) async {
    return remoteBookRequestSource.getUserRequestListAsOwner(userId);
  }

  Future updateBookRequestStatus(
    String requestId,
    String userId,
    BookRequestStatus status,
  ) async {
    BookRequestRemote foundRequest = await remoteBookRequestSource.getRequest(requestId);
    if (foundRequest.ownerId != userId) {
      throw Exception("Only owner can edit status");
    }
    await remoteBookRequestSource.updateRequestStatus(requestId, status);
  }
}
