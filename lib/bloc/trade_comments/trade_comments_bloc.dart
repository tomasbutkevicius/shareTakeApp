import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/comment/book_trade_comment_remote.dart';
import 'package:share_take/data/models/request/book_trade_comment_request.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/comment_repository.dart';

part 'trade_comments_event.dart';

part 'trade_comments_state.dart';

class TradeCommentsBloc extends Bloc<TradeCommentsEvent, TradeCommentsState> {
  final AuthenticationBloc authenticationBloc;
  final CommentRepository commentRepository;

  TradeCommentsBloc({
    required this.authenticationBloc,
    required this.commentRepository,
  }) : super(const TradeCommentsState()) {
    on<TradeCommentsResetEvent>(_handleTradeCommentsResetEvent);
    on<TradeCommentsGetEvent>(_handleTradeCommentsGetEvent);
    on<TradeCommentsCreateEvent>(_handleTradeCommentsCreateEvent);
    on<TradeCommentsDeleteEvent>(_handleTradeCommentsDeleteEvent);
  }

  void _handleTradeCommentsResetEvent(TradeCommentsResetEvent event, Emitter<TradeCommentsState> emit) {
    emit(const TradeCommentsState());
  }

  Future _handleTradeCommentsGetEvent(TradeCommentsGetEvent event, Emitter<TradeCommentsState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading(), commentList: []));
    try {
      List<BookTradeCommentModel> comments = await commentRepository.getTradeComments(event.tradeId);

      emit(state.copyWith(commentList: comments, status: RequestStatusInitial()));
    } catch (e) {
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future _handleTradeCommentsCreateEvent(TradeCommentsCreateEvent event, Emitter<TradeCommentsState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? user = authenticationBloc.state.user;

      if (user == null) {
        throw Exception("User not found, try logging back in");
      }

      BookTradeCommentRequest request = BookTradeCommentRequest(
        tradeId: event.tradeId,
        date: DateTime.now(),
        authorName: user.firstName + " " + user.lastName,
        authorId: user.id,
        text: event.text,
      );

      await commentRepository.createTradeComment(commentRequest: request);

      add(TradeCommentsGetEvent(tradeId: event.tradeId));
    } catch (e) {
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }

  Future _handleTradeCommentsDeleteEvent(TradeCommentsDeleteEvent event, Emitter<TradeCommentsState> emit) async {
    emit(state.copyWith(status: RequestStatusLoading()));
    try {
      UserLocal? user = authenticationBloc.state.user;

      if (user == null) {
        throw Exception("User not found, try logging back in");
      }

      await commentRepository.deleteComment(event.comment, user.id);

      add(TradeCommentsGetEvent(tradeId: event.comment.tradeId));
    } catch (e) {
      emit(state.copyWith(status: RequestStatusError(message: e.toString())));
    }
  }
}
