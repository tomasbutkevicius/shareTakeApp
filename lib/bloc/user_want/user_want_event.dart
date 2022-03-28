part of 'user_want_bloc.dart';

@immutable
abstract class UserWantEvent {}

class UserWantResetEvent extends UserWantEvent {}

class UserWantGetEvent extends UserWantEvent {
  final String userId;

  UserWantGetEvent({
    required this.userId,
  });
}