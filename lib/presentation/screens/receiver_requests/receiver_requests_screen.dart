import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/custom_app_bar.dart';

class ReceiverRequestsScreen extends StatelessWidget {
  const ReceiverRequestsScreen({Key? key}) : super(key: key);
  static const String routeName = "/requests/receiver";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        backgroundColor: ThemeColors.darker_grey,
        titleText: "Trade",
      ),
      body: Center(
        child: Text("Requests receiver"),
      ),
    );
  }
}
