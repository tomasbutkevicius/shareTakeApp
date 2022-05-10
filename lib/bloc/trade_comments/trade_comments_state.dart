part of 'trade_comments_bloc.dart';

class TradeCommentsState extends Equatable {
  final RequestStatus status;
  final List<BookTradeCommentModel> commentList;

  const TradeCommentsState({
    this.status = const RequestStatusInitial(),
    this.commentList = const [],
  });

  @override
  List<Object?> get props => [status, commentList];

  TradeCommentsState copyWith({
    RequestStatus? status,
    List<BookTradeCommentModel>? commentList,
  }) {
    return TradeCommentsState(
      status: status ?? this.status,
      commentList: commentList ?? this.commentList,
    );
  }
}