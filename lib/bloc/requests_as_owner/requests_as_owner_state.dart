part of 'requests_as_owner_bloc.dart';

class RequestsAsOwnerState extends Equatable {
  final List<BookRequestLocal> requestList;
  final RequestStatus status;

  @override
  List<Object?> get props => [requestList, status,];

  const RequestsAsOwnerState({
    this.requestList = const [],
    this.status = const RequestStatusInitial(),
  });

  RequestsAsOwnerState copyWith({
    List<BookRequestLocal>? requestList,
    RequestStatus? status,
  }) {
    return RequestsAsOwnerState(
      requestList: requestList ?? this.requestList,
      status: status ?? this.status,
    );
  }
}