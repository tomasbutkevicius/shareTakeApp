part of 'bottom_main_navigation_bloc.dart';

@immutable
class BottomMainNavigationState extends Equatable {
  final int viewIndex;

  final List<Widget> _views = const [
    BookListView(),
    UserListView(),
    SharingInfoView(),
  ];

  const BottomMainNavigationState({required this.viewIndex});

  Widget getSelectedView() {
    return _views[viewIndex];
  }

  BottomMainNavigationState copyWith({
    int? viewIndex,
  }) {
    return BottomMainNavigationState(
      viewIndex: viewIndex ?? this.viewIndex,
    );
  }

  @override
  List<Object?> get props => [viewIndex, _views];
}