
import 'package:flutter/material.dart';
import 'package:share_take/presentation/screens/add_book/add_book_screen.dart';
import 'package:share_take/presentation/screens/login/login_screen.dart';
import 'package:share_take/presentation/screens/main/main_menu_screen.dart';
import 'package:share_take/presentation/screens/register/register_screen.dart';
import 'package:share_take/presentation/screens/user/user_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return _handleMainScreen();
      case LoginScreen.routeName:
        return _handleLoginScreen();
      case RegisterScreen.routeName:
        return _handleRegisterScreen();
      case UserScreen.routeName:
        return _handleUserScreen();
      case AddBookScreen.routeName:
        return _handleAddBookScreen();
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
      builder: (_) => const UserScreen(),
    );
  }

  MaterialPageRoute<dynamic> _handleAddBookScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AddBookScreen(),
    );
  }
}
