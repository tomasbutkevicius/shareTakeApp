part of 'requests_as_owner_bloc.dart';

@immutable
abstract class RequestsAsOwnerEvent {}

class RequestsOwnerResetStatusEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerResetEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerGetListEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerStatusUpdateEvent extends RequestsAsOwnerEvent {
  final String requestId;
  final BookRequestStatus status;

  RequestsOwnerStatusUpdateEvent({
    required this.requestId,
    required this.status,
  });
}

class RequestsOwnerDeleteEvent extends RequestsAsOwnerEvent {
  final String requestId;

  RequestsOwnerDeleteEvent({
    required this.requestId,
  });
}

class RequestsOwnerCreateBookTradeEvent extends RequestsAsOwnerEvent {
  final BookRequestLocal requestLocal;

  RequestsOwnerCreateBookTradeEvent({
    required this.requestLocal,
  });
}