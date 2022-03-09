import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/localization/translations.dart';
import 'package:share_take/presentation/routing/navigation_utilities.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_widget.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class InvalidRouteScreen extends StatelessWidget {
  final String path;

  const InvalidRouteScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ProxyTextWidget(
              fontSize: ProxyFontSize.huge,
              fontWeight: ProxyFontWeight.semiBold,
              text: Translations.invalidRoute + ': ' + path,
            ),
            ProxySpacingVerticalWidget(),
            ProxyButtonWidget(
              color: ThemeColors.blue,
              text: Translations.goBack,
              onPressed: () => NavigationUtilities.reset(context),
            ),
          ],
        ),
      ),
    );
  }
}
