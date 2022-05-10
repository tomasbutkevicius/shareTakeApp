import 'package:share_take/data/data_providers/remote/remote_comment_source.dart';
import 'package:share_take/data/models/comment/book_trade_comment_remote.dart';
import 'package:share_take/data/models/request/book_trade_comment_request.dart';

class CommentRepository {
  final RemoteCommentSource remoteCommentSource;

  const CommentRepository({
    required this.remoteCommentSource,
  });

  Future createTradeComment({
    required BookTradeCommentRequest commentRequest,
  }) async {

    await remoteCommentSource.createTradeComment(commentRequest);
  }

  Future<List<BookTradeCommentModel>> getTradeComments(String tradeId) async {
    List<BookTradeCommentModel> comments = await remoteCommentSource.getTradeCommentList(tradeId);
    comments.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return comments;
  }

  Future deleteComment(BookTradeCommentModel comment, String userId) async {
    if(comment.authorId != userId) {
      throw Exception("Action not allowed");
    }
    await remoteCommentSource.deleteTradeComment(userId, comment.id);
  }
}
