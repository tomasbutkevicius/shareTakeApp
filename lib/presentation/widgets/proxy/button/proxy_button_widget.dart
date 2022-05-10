import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/proxy.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

class ProxyButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final ProxyFontSize fontSize;
  final ProxyFontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;
  final bool isUppercase;

  const ProxyButtonWidget({
    Key? key,
    required this.text,
    this.color = ThemeColors.blue,
    this.fontSize = ProxyFontSize.medium,
    this.fontWeight = ProxyFontWeight.semiBold,
    this.padding = const EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 40.0,
    ),
    this.onPressed,
    this.isUppercase = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        isUppercase ? text.toUpperCase() : text,
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all<Color>(color),
        foregroundColor: MaterialStateProperty.all<Color>(ThemeColors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          fontSize: StaticProxy.getFontSize(fontSize),
          fontWeight: StaticProxy.getFontWeight(fontWeight),
        )),
      ),
    );
  }
}
