
import 'package:flutter/cupertino.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/localization/translations.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class AppTitleTextWidget extends StatelessWidget {
  const AppTitleTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> words = Translations.appTitle.split(" ");
    String textWithoutLastWord = words[0];

    for(int i = 1; i < words.length - 1; i++){
      textWithoutLastWord += " " + words[i];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProxyTextWidget(
          text: textWithoutLastWord,
          textAlign: TextAlign.center,
          fontSize: ProxyFontSize.extraLarge,
          color: ThemeColors.white,
          fontWeight: ProxyFontWeight.extraBold,
        ),
        ProxyTextWidget(
          text: " " + words[words.length - 1],
          textAlign: TextAlign.center,
          fontSize: ProxyFontSize.extraLarge,
          color: ThemeColors.white,
          fontWeight: ProxyFontWeight.extraBold,
        ),
      ],
    );
  }
}
