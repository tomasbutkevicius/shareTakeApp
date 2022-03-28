import 'package:flutter/material.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';

class SharingInfoView extends StatelessWidget {
  const SharingInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: StaticStyles.listViewPadding,
        child: Column(
          children: [
            ProxyButtonWidget(text: "Book Requests (as owner)"),
            ProxyButtonWidget(text: "Book Requests (as receiver)"),
          ],
        ),
      ),
    );
  }
}
