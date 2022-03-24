part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  final RequestStatus status;
  final List<UserLocal> userList;

  const UserListState({
    this.status = const RequestStatusInitial(),
    this.userList = const [],
  });

  @override
  List<Object?> get props => [
        status,
        userList,
      ];

  UserListState copyWith({
    RequestStatus? status,
    List<UserLocal>? userList,
  }) {
    return UserListState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
    );
  }
}
