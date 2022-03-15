
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:share_take/presentation/screens/main/views/book_list/book_list_view.dart';
import 'package:share_take/presentation/screens/main/views/sharing_info/sharing_info_view.dart';
import 'package:share_take/presentation/screens/main/views/user_list/user_list_view.dart';


part 'bottom_main_navigation_event.dart';
part 'bottom_main_navigation_state.dart';

class BottomMainNavigationBloc extends Bloc<BottomMainNavigationEvent, BottomMainNavigationState> {
  BottomMainNavigationBloc() : super(const BottomMainNavigationState(viewIndex: 0)){
    on<BottomMainNavigationClickEvent>((event, emit) => emit(state.copyWith(viewIndex: event.index)));
  }
}
