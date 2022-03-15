import 'package:flutter/material.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
    required this.message,
    this.backgroundColor = ThemeColors.blue,
    this.textColor = ThemeColors.black,
  }) : super(key: key);

  final String message;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: StaticStyles.listViewPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: ListView(
        children: [
          ProxyTextWidget(
            text: message,
            color: textColor,
          ),
        ],
      ),
    );
  }
}