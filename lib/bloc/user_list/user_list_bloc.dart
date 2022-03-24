
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/data/repositories/user_repository.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository userRepository;

  UserListBloc({required this.userRepository}) : super(const UserListState()) {
    on<UserListGetEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading()));
      try {
        List<UserLocal> userList = await userRepository.getAllUsers();
        emit(state.copyWith(userList: userList, status: RequestStatusSuccess(message: "Updated user list")));
      } catch (e) {
        emit(state.copyWith(status: RequestStatusError(message: e.toString())));
      }
    });
    on<UserListResetEvent>((event, emit) {
      emit(UserListState());
    });
  }
}
