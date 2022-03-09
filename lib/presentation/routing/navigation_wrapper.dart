import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/navigation/navigation_bloc.dart';
import 'package:share_take/bloc/user/user_bloc.dart';
import 'package:share_take/presentation/routing/navigation_utilities.dart';
import 'package:share_take/presentation/routing/navigation_widget.dart';
import 'package:share_take/presentation/routing/routes.dart';

class NavigationWrapperWidget extends StatelessWidget {
  const NavigationWrapperWidget({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context, NavigationState state) async {
    if (state.items.length < 2) {
      return true;
    }

    NavigationUtilities.goBack(context);
    return false;
  }

  bool _buildWhenNavigation(NavigationState previousState, NavigationState state) => previousState != state;

  bool _buildWhenUser(UserState previousState, UserState state) => previousState.id != state.id;

  Widget _builderNavigation(BuildContext context, NavigationState state) {
    final NavigationStateItem item = state.items.last;
    return WillPopScope(
      onWillPop: () => _onWillPop(context, state),
      child: NavigationWidget(
        path: item.path,
        params: item.params,
        item: Routes.mapping[item.path],
      ),
    );
  }

  Widget _builderUser(BuildContext context, UserState state) {
    // if (state.isUserLoggedIn == false) {
    //   return NavigationWidget(
    //     path: Routes.employeeLogin,
    //     item: Routes.mapping[Routes.employeeLogin],
    //   );
    // }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: _builderNavigation,
      buildWhen: _buildWhenNavigation,
    );
  }

  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: _builderUser,
      buildWhen: _buildWhenUser,
    );
  }
}
