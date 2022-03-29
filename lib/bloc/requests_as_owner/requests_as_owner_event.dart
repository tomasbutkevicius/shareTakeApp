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

class RequestsOwnerStatusDeleteEvent extends RequestsAsOwnerEvent {
  final String requestId;

  RequestsOwnerStatusDeleteEvent({
    required this.requestId,
  });
}