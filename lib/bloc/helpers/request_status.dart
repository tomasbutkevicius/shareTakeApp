
abstract class RequestStatus {
  const RequestStatus();
}

class RequestStatusInitial extends RequestStatus {
  const RequestStatusInitial();
}

class RequestStatusLoading extends RequestStatus {}

class RequestStatusError extends RequestStatus {
  final String message;

  const RequestStatusError({
    required this.message,
  });
}

class RequestStatusSuccess extends RequestStatus {
  final String message;

  const RequestStatusSuccess({
    required this.message,
  });
}
