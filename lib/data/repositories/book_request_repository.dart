import 'package:share_take/constants/enums.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_book_request_source.dart';
import 'package:share_take/data/data_senders/email_service.dart';
import 'package:share_take/data/models/book/book_request_remote.dart';

class BookRequestRepository {
  final RemoteBookRequestSource remoteBookRequestSource;
  final RemoteOfferSource remoteOfferSource;

  const BookRequestRepository({
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

  Future deleteBookRequest(String userId, String requestId) async {
    late BookRequestRemote requestRemote;
    try {
      requestRemote = await remoteBookRequestSource.getRequest(requestId);
    } catch (e) {
      throw Exception("Could not find request");
    }

    if(requestRemote.ownerId != userId) {
      throw Exception("You do not have permission for this action");
    }

    await remoteBookRequestSource.deleteBookRequest(requestId);
  }

  Future updateBookRequestStatus(
    String requestId,
    String userId,
    BookRequestStatus status,
  ) async {
    print("update caled");
    BookRequestRemote foundRequest = await remoteBookRequestSource.getRequest(requestId);
    print("found request");
    print(foundRequest.toString());
    if(!foundRequest.editable) {
      throw Exception('Request edit disabled');
    }
    if (foundRequest.ownerId != userId) {
      throw Exception("Only owner can edit status");
    }
    if (foundRequest.status == status){
      return;
    }
    if(status == BookRequestStatus.accepted) {
      await remoteBookRequestSource.updateRequestStatus(requestId, status);
      return;
    }
    if(status == BookRequestStatus.rejected) {
      await remoteBookRequestSource.updateRequestStatus(requestId, status);
      return;
    }
  }
}
