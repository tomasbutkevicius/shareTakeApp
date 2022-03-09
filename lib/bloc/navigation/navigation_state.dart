part of 'navigation_bloc.dart';


@immutable
class NavigationState extends Equatable {
  final List<NavigationStateItem> items;

  const NavigationState({
    this.items = const [NavigationStateItem.home],
  });

  NavigationState copyWith({
    List<NavigationStateItem>? items,
  }) {
    return NavigationState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}

@immutable
class NavigationStateItem extends Equatable {
  final String path;
  final NavigationParams? params;

  const NavigationStateItem({
    required this.path,
    this.params,
  });

  @override
  List<Object?> get props => [path, params];

  static const home = NavigationStateItem(
    path: Routes.home,
  );
}
