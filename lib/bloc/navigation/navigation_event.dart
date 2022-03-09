part of 'navigation_bloc.dart';


@immutable
abstract class NavigationEvent {
  const NavigationEvent();
}

@immutable
class NavigationEventPush extends NavigationEvent {
  final String path;
  final NavigationParams? params;

  const NavigationEventPush(this.path, {this.params});
}

@immutable
class NavigationEventReplace extends NavigationEvent {
  final String path;
  final NavigationParams? params;

  const NavigationEventReplace(this.path, {this.params});
}

@immutable
class NavigationEventGoBackTo extends NavigationEvent {
  final String path;

  const NavigationEventGoBackTo(this.path);
}

@immutable
class NavigationEventGoBack extends NavigationEvent {}

@immutable
class NavigationEventReset extends NavigationEvent {}



