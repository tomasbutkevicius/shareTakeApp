
import 'package:flutter/material.dart';
import 'package:share_take/data/models/book/book_local.dart';
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

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return _handleMainScreen();
      case LoginScreen.routeName:
        return _handleLoginScreen();
      case RegisterScreen.routeName:
        return _handleRegisterScreen();
      case AuthUserScreen.routeName:
        return _handleUserScreen();
      case AddBookScreen.routeName:
        return _handleAddBookScreen();
      case BookDetailsScreen.routeName:
        return _handleBookDetailsScreen(settings);
      case UserDetailsScreen.routeName:
        return _handleUserDetailsScreen(settings);
      case ReceiverRequestsScreen.routeName:
        return _handleReceiverRequestsScreen();
      case OwnerRequestsScreen.routeName:
        return _handleOwnerRequestsScreen();
      case TradeListScreen.routeName:
        return _handleTradeListScreen();
      case TradeDetailsOwnerScreen.routeName:
        return _handleTradeDetailsOwnerScreen(settings);
      case TradeDetailsReceiverScreen.routeName:
        return _handleTradeDetailsReceiverScreen(settings);
        
      default:
        return null;
    }
  }

  MaterialPageRoute<dynamic> _handleMainScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MainScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleLoginScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LoginScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleRegisterScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const RegisterScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleUserScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AuthUserScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleAddBookScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AddBookScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleBookDetailsScreen(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return BookDetailsScreen(
          bookLocal: args.bookLocal!,
        );
      },
    );
  }

  MaterialPageRoute<dynamic> _handleUserDetailsScreen(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return UserDetailsScreen(
          user: args.userLocal!,
        );
      },
    );
  }

  MaterialPageRoute<dynamic> _handleReceiverRequestsScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ReceiverRequestsScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleOwnerRequestsScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const OwnerRequestsScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleTradeListScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const TradeListScreen(),
    );
  }


  MaterialPageRoute<dynamic> _handleTradeDetailsOwnerScreen(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return TradeDetailsOwnerScreen(
          bookTrade: args.tradeLocal!,
        );
      },
    );
  }


  MaterialPageRoute<dynamic> _handleTradeDetailsReceiverScreen(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;
    return MaterialPageRoute(
      builder: (context) {
        return TradeDetailsReceiverScreen(
          bookTrade: args.tradeLocal!,
        );
      },
    );
  }
}
