part of 'language_selection_bloc.dart';

@immutable
abstract class LanguageSelectionEvent {
  const LanguageSelectionEvent();
}

class LanguageSwitchEvent extends LanguageSelectionEvent {
  final String languageCode;
  final BuildContext context;

  const LanguageSwitchEvent(this.languageCode, this.context);
}
