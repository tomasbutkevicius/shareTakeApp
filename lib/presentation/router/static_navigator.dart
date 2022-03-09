import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/presentation/screens/main_screen/main_menu_screen.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';


class StaticNavigator {
  static void navigateToMainScreenBookListView(BuildContext context) {
      context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(0));
      Navigator.of(context).pushNamed(
        MainScreen.routeName,
      );
  }

  static void navigateToMainScreenUserListView(BuildContext context) {
    context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(1));
    Navigator.of(context).pushNamed(
      MainScreen.routeName,
    );
  }

  static void navigateToMainScreenTradeListView(BuildContext context) {
    context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(2));
    Navigator.of(context).pushNamed(
      MainScreen.routeName,
    );
  }


  static bool authorised(BuildContext context) {
    AuthenticationState state = BlocProvider.of<AuthenticationBloc>(context).state;

    if (state.user == null) {
      return false;
    }

    return true;
  }

  static void handleUnauthorised(BuildContext context) {

    StaticWidgets.showSnackBar(context, "Login to continue");

  }

  static void popUntilFirstRoute(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
