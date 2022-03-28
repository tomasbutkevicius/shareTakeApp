part of 'user_offer_bloc.dart';

@immutable
abstract class UserOfferEvent {}

class UserOfferResetEvent extends UserOfferEvent {}

class UserOfferGetEvent extends UserOfferEvent {
  final String userId;

  UserOfferGetEvent({
    required this.userId,
  });
}