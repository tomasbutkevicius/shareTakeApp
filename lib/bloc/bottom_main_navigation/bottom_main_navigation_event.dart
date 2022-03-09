part of 'bottom_main_navigation_bloc.dart';

@immutable
abstract class BottomMainNavigationEvent {}

class BottomMainNavigationClickEvent extends BottomMainNavigationEvent {
  final int index;

  BottomMainNavigationClickEvent(this.index);
}
