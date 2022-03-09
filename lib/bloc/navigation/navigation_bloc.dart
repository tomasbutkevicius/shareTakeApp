
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_take/presentation/routing/navigation_params.dart';
import 'package:share_take/presentation/routing/routes.dart';
import 'package:collection/collection.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigationEvent>((event, emit) {
      on<NavigationEventGoBackTo>(
        (event, emit) {
          final NavigationStateItem? item = state.items.lastWhereOrNull((NavigationStateItem item) => item.path == event.path);

          if (item == null) {
            return;
          }

          emit(
            state.copyWith(
              items: []
                ..addAll(state.items)
                ..removeRange(state.items.lastIndexOf(item) + 1, state.items.length),
            ),
          );
        },
      );
      on<NavigationEventPush>((event, emit) {
        emit(state.copyWith(
          items: []
            ..addAll(state.items)
            ..add(
              NavigationStateItem(
                path: event.path,
                params: event.params,
              ),
            ),
        ));
      });
    });
    on<NavigationEventReplace>((event, emit) {
      emit(state.copyWith(
        items: [...state.items]
          ..removeLast()
          ..add(
            NavigationStateItem(
              path: event.path,
              params: event.params,
            ),
          ),
      ));
    });
    on<NavigationEventGoBack>((event, emit) {
      if (state.items.length < 2) {
        return;
      }

      emit(state.copyWith(
        items: []
          ..addAll(state.items)
          ..removeLast(),
      ));

      on<NavigationEventReset>((event, emit) {
        emit(const NavigationState());
      });
    });
  }
}
