import 'package:flutter/widgets.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/presentation/widgets/proxy/button/proxy_button_text_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class LinedButtons extends StatelessWidget {
  final VoidCallback onFirstBtnPress;
  final Color firstBtnColor;
  final String firstBtnText;
  final ProxyFontWeight firstTextWeight;
  final VoidCallback onSecondBtnPress;
  final Color secondBtnColor;
  final String secondBtnText;
  final ProxyFontWeight secondTextWeight;
  final double lineHeight;

  final ProxyFontSize fontSize;

  const LinedButtons({
    Key? key,
    required this.onFirstBtnPress,
    required this.firstBtnText,
    this.firstTextWeight = ProxyFontWeight.regular,
    required this.onSecondBtnPress,
    required this.secondBtnText,
    this.secondTextWeight = ProxyFontWeight.regular,
    required this.firstBtnColor,
    required this.secondBtnColor,
    this.fontSize = ProxyFontSize.small,
    this.lineHeight = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _getButtons(context),
        _getDividers(context),
      ],
    );
  }

  Widget _getButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _getFirstBtn(),
        ),
        Expanded(
          child: _getSecondBtn(context),
        ),
      ],
    );
  }

  Widget _getDividers(BuildContext context) {
    return Wrap(
      children: [
        _getCustomDividerLeft(context, firstBtnColor),
        _getCustomDividerRight(context, secondBtnColor),
      ],
    );
  }

  Widget _getFirstBtn() {
    return ProxyButtonTextWidget(
      onPressed: onFirstBtnPress,
      child: ProxyTextWidget(
        text: firstBtnText,
        color: firstBtnColor,
        fontSize: fontSize,
        fontWeight: firstTextWeight,
      ),
    );
  }

  Widget _getSecondBtn(BuildContext context) {
    return ProxyButtonTextWidget(
      onPressed: onSecondBtnPress,
      child: ProxyTextWidget(
        text: secondBtnText,
        color: secondBtnColor,
        fontSize: fontSize,
        fontWeight: secondTextWeight,
      ),
    );
  }

  Widget _getCustomDividerLeft(BuildContext context, Color color) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        height: lineHeight,
        color: color,
      ),
    );
  }

  Widget _getCustomDividerRight(BuildContext context, Color color) {
    return FractionallySizedBox(
      alignment: Alignment.centerRight,
      widthFactor: 0.5,
      child: Container(
        height: lineHeight,
        color: color,
      ),
    );
  }
}
