part of 'language_selection_bloc.dart';

@immutable
class LanguageSelectionState extends Equatable {
  final String languageCode;

  const LanguageSelectionState({required this.languageCode});

  LanguageSelectionState copyWith({
    String? languageCode,
  }) {
    return LanguageSelectionState(
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [languageCode];
}