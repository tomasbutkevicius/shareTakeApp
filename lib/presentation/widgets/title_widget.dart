import 'package:flutter/cupertino.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/localization/translations.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class AppTitleTextWidget extends StatelessWidget {
  const AppTitleTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProxyTextWidget(
          text: text,
          textAlign: TextAlign.center,
          fontSize: ProxyFontSize.extraLarge,
          color: ThemeColors.white,
          fontWeight: ProxyFontWeight.extraBold,
        ),
      ],
    );
  }
}
