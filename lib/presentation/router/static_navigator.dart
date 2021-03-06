import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:share_take/bloc/authentication/authentication_bloc.dart';
import 'package:share_take/bloc/book_trade_list/book_trade_list_bloc.dart';
import 'package:share_take/bloc/bottom_main_navigation/bottom_main_navigation_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/requests_as_owner/requests_as_owner_bloc.dart';
import 'package:share_take/bloc/requests_as_receiver/requests_as_receiver_bloc.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/data/models/user/user_local.dart';
import 'package:share_take/presentation/router/arguments.dart';
import 'package:share_take/presentation/screens/add_book/add_book_screen.dart';
import 'package:share_take/presentation/screens/book_details/book_details_screen.dart';
import 'package:share_take/presentation/screens/login/login_screen.dart';
import 'package:share_take/presentation/screens/main/main_menu_screen.dart';
import 'package:share_take/presentation/screens/owner_requests/owner_requests_screen.dart';
import 'package:share_take/presentation/screens/receiver_requests/receiver_requests_screen.dart';
import 'package:share_take/presentation/screens/register/register_screen.dart';
import 'package:share_take/presentation/screens/auth_user/auth_user_screen.dart';
import 'package:share_take/presentation/screens/trade_details/trade_details_owner_screen.dart';
import 'package:share_take/presentation/screens/trade_details/trade_details_receiver_screen.dart';
import 'package:share_take/presentation/screens/trade_list/trade_list_screen.dart';
import 'package:share_take/presentation/screens/user_details/user_details_screen.dart';
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
      AuthUserScreen.routeName,
    );
  }

  static void pushAddBookScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AddBookScreen.routeName,
    );
  }

  static void pushBookDetailScreen(
    BuildContext context,
    BookLocal bookLocal,
  ) {
    Navigator.of(context).pushNamed(
      BookDetailsScreen.routeName,
      arguments: ScreenArguments(bookLocal: bookLocal),
    );
  }

  static void pushUserDetailScreen(
    BuildContext context,
    UserLocal user,
  ) {
    Navigator.of(context).pushNamed(
      UserDetailsScreen.routeName,
      arguments: ScreenArguments(userLocal: user),
    );
  }

  static void pushRequestsReceiverScreen(
    BuildContext context,
  ) {
    if (!authorised(context)) {
      handleUnauthorised(context);
      return;
    }
    BlocGetter.getRequestsReceiverBloc(context).add(RequestsReceiverGetListEvent());
    Navigator.of(context).pushNamed(
      ReceiverRequestsScreen.routeName,
    );
  }

  static void pushRequestsOwnerScreen(
    BuildContext context,
  ) {
    if (!authorised(context)) {
      handleUnauthorised(context);
      return;
    }
    BlocGetter.getRequestsOwnerBloc(context).add(RequestsOwnerGetListEvent());
    Navigator.of(context).pushNamed(
      OwnerRequestsScreen.routeName,
    );
  }

  static void pushTradeListScreen(
    BuildContext context,
  ) {
    if (!authorised(context)) {
      handleUnauthorised(context);
      return;
    }
    BlocGetter.getBookTradeListBloc(context).add(BookTradeListGetListEvent());
    Navigator.of(context).pushNamed(
      TradeListScreen.routeName,
    );
  }

  static void pushTradeDetailsScreen(
    BuildContext context,
    BookTradeLocal bookTradeLocal,
  ) {
    if (!authorised(context)) {
      handleUnauthorised(context);
      return;
    }
    AuthenticationState state = BlocProvider.of<AuthenticationBloc>(context).state;

    if (state.user!.id == bookTradeLocal.owner.id) {
      Navigator.of(context).pushNamed(
        TradeDetailsOwnerScreen.routeName,
        arguments: ScreenArguments(tradeLocal: bookTradeLocal),
      );
      return;
    }

    if (state.user!.id == bookTradeLocal.receiver.id) {
      Navigator.of(context).pushNamed(
        TradeDetailsReceiverScreen.routeName,
        arguments: ScreenArguments(tradeLocal: bookTradeLocal),
      );
      return;
    }

    StaticWidgets.showSnackBar(context, "You do not belong to trade");
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
