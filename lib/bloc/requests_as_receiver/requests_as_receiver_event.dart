part of 'requests_as_receiver_bloc.dart';

@immutable
abstract class RequestsAsReceiverEvent {}

class RequestsReceiverResetStatusEvent extends RequestsAsReceiverEvent {}

class RequestsReceiverResetEvent extends RequestsAsReceiverEvent {}

class RequestsReceiverGetListEvent extends RequestsAsReceiverEvent {}


class RequestsReceiverCreateBookTradeEvent extends RequestsAsReceiverEvent {
  final BookRequestLocal requestLocal;

  RequestsReceiverCreateBookTradeEvent({
    required this.requestLocal,
  });
}