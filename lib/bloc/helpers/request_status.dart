
import 'package:equatable/equatable.dart';

abstract class RequestStatus extends Equatable {
  const RequestStatus();
}

class RequestStatusInitial extends RequestStatus {
  const RequestStatusInitial();

  @override
  List<Object?> get props => [];
}

class RequestStatusLoading extends RequestStatus {
  @override
  List<Object?> get props => [];
}

class RequestStatusError extends RequestStatus {
  final String message;

  const RequestStatusError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class RequestStatusSuccess extends RequestStatus {
  final String message;

  const RequestStatusSuccess({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
