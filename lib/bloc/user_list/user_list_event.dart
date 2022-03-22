part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent {}

class UserListGetEvent extends UserListEvent {}

class UserListResetEvent extends UserListEvent {}