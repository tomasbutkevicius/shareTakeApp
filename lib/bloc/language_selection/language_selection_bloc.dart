import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:share_take/constants/static_localization.dart';

part 'language_selection_event.dart';

part 'language_selection_state.dart';

class LanguageSelectionBloc extends Bloc<LanguageSelectionEvent, LanguageSelectionState> {
  LanguageSelectionBloc() : super(const LanguageSelectionState(languageCode: StaticLocalization.languageCodeEnglish),){
    on<LanguageSwitchEvent>((event, emit) async {
      try {
        await event.context.setLocale(Locale(event.languageCode));
        emit(state.copyWith(languageCode: event.languageCode));
      } catch (e) {
        await event.context.setLocale(const Locale(StaticLocalization.languageCodeEnglish),);
      }
    });
  }
}
