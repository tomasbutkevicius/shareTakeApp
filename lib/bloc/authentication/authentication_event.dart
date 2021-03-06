part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthenticationEvent {
  final BuildContext context;

  const AuthAppStarted(this.context);
}

class AuthLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  const AuthLoginEvent({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class AuthRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String repeatPassword;
  final String firstName;
  final String lastName;
  final BuildContext context;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.repeatPassword,
    required this.firstName,
    required this.lastName,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, repeatPassword, firstName, lastName, context];
}

class AuthRemindPasswordEvent extends AuthenticationEvent {
  final String email;

  const AuthRemindPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email,];

  @override
  String toString() => 'RemindPasswordPressedEvent { email: $email }';
}

class AuthLoggedOutEvent extends AuthenticationEvent {}

class AuthenticationUpdateEvent extends AuthenticationEvent {
  final UserLocal user;

  const AuthenticationUpdateEvent({
    required this.user,
  });
}

class AuthUserDisableFirstTimeLogin extends AuthenticationEvent {
  final UserLocal user;

  const AuthUserDisableFirstTimeLogin({
    required this.user,
  });
}

class AuthResetStateEvent extends AuthenticationEvent {}

class AuthResetStatusEvent extends AuthenticationEvent {}