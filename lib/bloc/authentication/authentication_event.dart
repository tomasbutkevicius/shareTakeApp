part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  final BuildContext context;

  const AppStarted(this.context);
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignInButtonPressedEvent { email: $email }';
}

class RemindPasswordEvent extends AuthenticationEvent {
  final String email;

  const RemindPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email,];

  @override
  String toString() => 'RemindPasswordPressedEvent { email: $email }';
}

class LoggedOutEvent extends AuthenticationEvent {}

class AuthenticationUpdateEvent extends AuthenticationEvent {
  final User user;

  const AuthenticationUpdateEvent({
    required this.user,
  });
}

class UserDisableFirstTimeLogin extends AuthenticationEvent {
  final User user;

  const UserDisableFirstTimeLogin({
    required this.user,
  });
}

class ResetStateEvent extends AuthenticationEvent {}