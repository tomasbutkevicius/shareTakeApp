
import 'package:flutter/material.dart';
import 'package:share_take/presentation/screens/login/login_screen.dart';
import 'package:share_take/presentation/screens/main/main_menu_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return _handleMainScreen();
      case LoginScreen.routeName:
        return _handleLoginScreen();
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

}
