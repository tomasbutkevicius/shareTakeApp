import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/language_selection/language_selection_bloc.dart';
import 'package:share_take/constants/static_localization.dart';
import 'package:share_take/data/models/request/register_request.dart';
import 'package:share_take/data/models/user/user_local.dart';
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
      try {
        final UserLocal? storedUser = await userRepository.getActiveUser();
        final String? token = await userRepository.getToken();

        if (storedUser != null && token != null) {
          UserLocal user = await userRepository.authenticate(email: storedUser.email, password: token);

          emit(
            state.copyWith(
              user: user,
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
      } catch (e) {
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
        UserLocal user = await userRepository.authenticate(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        emit(state.copyWith(
          status: const RequestStatusSuccess(message: ""),
          user: user,
        ));
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

    on<AuthRegisterEvent>((event, emit) async {
      emit(state.copyWith(user: null, status: RequestStatusLoading()));

      try {
        RegisterRequest registerRequest = RegisterRequest(
          email: event.email.trim(),
          password: event.password.trim(),
          firstName: event.firstName.trim(),
          lastName: event.lastName.trim(),
        );

        String? errorMessage = validateRegisterRequest(registerRequest);
        if (errorMessage != null) {
          emit(state.copyWith(
            status: RequestStatusError(message: errorMessage),
            user: null,
          ));
          return;
        }

        await userRepository.register(
          RegisterRequest(
            email: event.email,
            password: event.password,
            firstName: event.firstName,
            lastName: event.lastName,
          ),
        );

        emit(
          state.copyWith(
            user: null,
            status: const RequestStatusSuccess(message: ""),
          ),
        );
      } catch (e) {
        emit(state.copyWith(
          status: RequestStatusError(message: e.toString()),
          user: null,
        ));
      }
    });

    on<AuthLoggedOutEvent>((event, emit) async {
      emit(
        state.copyWith(
          user: state.user,
          status: RequestStatusLoading(),
        ),
      );
      await userRepository.logout();
      emit(
        state.copyWith(
          user: null,
          status: const RequestStatusInitial(),
        ),
      );
    });

    on<AuthenticationUpdateEvent>((event, emit) async {
      // await userRepository.updateLocalUser(event.user);

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

  String? validateRegisterRequest(RegisterRequest registerRequest) {
    if (registerRequest.firstName.isEmpty) {
      return "First name cannot be empty";
    }
    if (registerRequest.lastName.isEmpty) {
      return "Last name cannot be empty";
    }
    if (registerRequest.password.isEmpty) {
      return "Password cannot be empty";
    }
    if (registerRequest.password.length <= 5) {
      return "Password must be longer than 5 symbols";
    }
    return null;
  }
}
