import 'package:share_take/presentation/routing/navigation_item.dart';
import 'package:share_take/presentation/routing/navigation_params.dart';
import 'package:share_take/presentation/screens/home_screen/home.dart';

class Routes {
  static const String home = '/';

  static Map<String, NavigationItem> mapping = {
    Routes.home: NavigationItem(
      body: (_) => HomeScreen(
        params: NavigationParamsHome(title: "TakeShare"),
      ),
      appBar: (_) => null,
    ),
  };
}
