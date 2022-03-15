import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class Header extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const Header({Key? key, required this.text, this.color = ThemeColors.black, this.textAlign = TextAlign.left}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: StaticStyles.headerPadding,
      child: ProxyTextWidget(
        text: text,
        textAlign: textAlign,
        fontSize: ProxyFontSize.huge,
        fontWeight: ProxyFontWeight.extraBold,
        color: color,
      ),
    );
  }
}
