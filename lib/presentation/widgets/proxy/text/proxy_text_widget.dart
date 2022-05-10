import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/proxy.dart';
import 'package:share_take/constants/theme/theme_colors.dart';


class ProxyTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final int? maxLines;
  final bool isOverflow;
  final bool isUnderline;
  final bool isUppercase;
  final bool isLineThrough;
  final TextAlign textAlign;
  final ProxyFontSize fontSize;
  final ProxyFontWeight fontWeight;
  final FontStyle fontStyle;

  const ProxyTextWidget({
    Key? key,
    required this.text,
    this.color = ThemeColors.black,
    this.maxLines,
    this.isOverflow = false,
    this.isUnderline = false,
    this.isUppercase = false,
    this.isLineThrough = false,
    this.textAlign = TextAlign.left,
    this.fontSize = ProxyFontSize.medium,
    this.fontWeight = ProxyFontWeight.regular,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isUppercase ? text.toUpperCase() : text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        height: 1.1,
        color: color,
        fontSize: StaticProxy.getFontSize(fontSize),
        fontWeight: StaticProxy.getFontWeight(fontWeight),
        fontStyle: fontStyle,
        decoration: isLineThrough ? TextDecoration.lineThrough : isUnderline ? TextDecoration.underline : null,
      ),
    );
  }
}