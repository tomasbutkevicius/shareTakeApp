import 'package:flutter/cupertino.dart';
import 'package:share_take/presentation/routing/navigation_params.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.params}) : super(key: key);
  final NavigationParamsHome params;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ProxyTextWidget(text: params.title),
      ),
    );
  }
}
