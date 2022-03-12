import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/language_selection/language_selection_bloc.dart';
import 'package:share_take/constants/static_localization.dart';
import 'package:share_take/data/models/user/user.dart';
import 'package:share_take/data/repositories/user_repository.dart';
import 'package:share_take/presentation/router/static_navigator.dart';

import '../../localization/translations.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final LanguageSelectionBloc languageSelectionBloc;

  AuthenticationBloc(this.userRepository, this.languageSelectionBloc) : super(const AuthenticationState()) {
    on<AuthAppStarted>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading(), user: null));
      //To get locale of device:
      //window.locale.languageCode

      languageSelectionBloc.add(
        LanguageSwitchEvent(
          StaticLocalization.languageCodeEnglish,
          event.context,
        ),
      );

      final User? storedUser = await userRepository.getActiveUser();

      if (storedUser != null) {
        emit(
          state.copyWith(
            user: storedUser,
            status: const RequestStatusInitial(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            user: null,
            status: const RequestStatusInitial(),
          ),
        );
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatusLoading(), user: null));

      if (event.email.trim().isEmpty || event.password.trim().isEmpty) {
        emit(state.copyWith(
          status: RequestStatusError(message: Translations.emailPasswordCannotBeEmpty),
          user: null,
        ));
        return;
      }

      try {
        User user = await userRepository.authenticate(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        emit(state.copyWith(
          status: const RequestStatusSuccess(message: ""),
          user: user,
        ));
        StaticNavigator.popUntilFirstRoute(event.context);
      } on Exception catch (exc) {
        emit(state.copyWith(
          status: RequestStatusError(message: exc.toString()),
          user: null,
        ));
        return;
      } catch (error) {
        emit(state.copyWith(
          status: RequestStatusError(message: error.toString()),
          user: null,
        ));
        return;
      }
    });

    on<AuthLoggedOutEvent>((event, emit) async {
      await userRepository.logout();
      emit(
        state.copyWith(
          user: null,
        ),
      );
    });

    on<AuthenticationUpdateEvent>((event, emit) async {
      await userRepository.updateLocalUser(event.user);

      emit(state.copyWith(user: event.user));
    });

    on<AuthResetStatusEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: RequestStatusInitial(),
          user: state.user,
        ),
      );
    });
  }
}
