import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/presentation/screens/login/login_screen.dart';
import 'package:share_take/presentation/screens/main/main_menu_screen.dart';
import 'package:share_take/presentation/screens/register/register_screen.dart';
import 'package:share_take/presentation/screens/user/user_screen.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';


class StaticNavigator {
  static void pushMainScreenBookListView(BuildContext context) {
      context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(0));
      Navigator.of(context).pushNamed(
        MainScreen.routeName,
      );
  }

  static void pushMainScreenUserListView(BuildContext context) {
    context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(1));
    Navigator.of(context).pushNamed(
      MainScreen.routeName,
    );
  }

  static void pushMainScreenTradeListView(BuildContext context) {
    context.read<BottomMainNavigationBloc>().add(BottomMainNavigationClickEvent(2));
    Navigator.of(context).pushNamed(
      MainScreen.routeName,
    );
  }

  static void pushLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      LoginScreen.routeName,
    );
  }

  static void pushRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      RegisterScreen.routeName,
    );
  }

  static void pushUserScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      UserScreen.routeName,
    );
  }
  
  static void popContext(BuildContext context) {
    Navigator.of(context).pop();
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
}
