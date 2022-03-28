part of 'requests_as_receiver_bloc.dart';

class RequestsAsReceiverState extends Equatable {
  final List<BookRequestLocal> requestList;
  final RequestStatus status;

  @override
  List<Object?> get props => [requestList, status,];

  const RequestsAsReceiverState({
    this.requestList = const [],
    this.status = const RequestStatusInitial(),
  });

  RequestsAsReceiverState copyWith({
    List<BookRequestLocal>? requestList,
    RequestStatus? status,
  }) {
    return RequestsAsReceiverState(
      requestList: requestList ?? this.requestList,
      status: status ?? this.status,
    );
  }
}