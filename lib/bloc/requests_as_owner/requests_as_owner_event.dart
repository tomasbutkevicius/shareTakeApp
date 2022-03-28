part of 'requests_as_owner_bloc.dart';

@immutable
abstract class RequestsAsOwnerEvent {}

class RequestsOwnerResetStatusEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerResetEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerGetListEvent extends RequestsAsOwnerEvent {}

class RequestsOwnerStatusChangeEvent extends RequestsAsOwnerEvent {

}