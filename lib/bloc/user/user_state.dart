part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final int? id;

  const UserState({
    this.id
    });


  @override
  List<Object?> get props => [id];

  bool get isUserLoggedIn => id != null;


}
