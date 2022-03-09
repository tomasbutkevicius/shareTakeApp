part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final RequestStatus status;
  final User? user;

  const AuthenticationState({
    this.status = const RequestStatusInitial(),
    this.user,
  });

  AuthenticationState copyWith({
    required User? user,
    int? wrongInputCount,
    RequestStatus? status,
  }) {
    return AuthenticationState(
      user: user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    user,
    status
  ];

}
