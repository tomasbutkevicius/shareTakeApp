import 'package:flutter/material.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProxyTextWidget(
        text: "User list view",
      ),
    );
  }
}
