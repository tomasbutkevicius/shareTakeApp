
import 'package:flutter/material.dart';
import 'package:share_take/presentation/screens/main_screen/main_menu_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return _handleMainScreen();
      default:
        return null;
    }
  }

  MaterialPageRoute<dynamic> _handleMainScreen() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MainScreen(),
    );
  }

}
