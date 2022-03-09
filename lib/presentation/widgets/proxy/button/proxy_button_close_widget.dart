import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

class ProxyButtonCloseWidget extends StatelessWidget {
  final double size;
  final Color color;
  final VoidCallback onPressed;

  const ProxyButtonCloseWidget({
    Key? key,
    this.size = 35,
    this.color = ThemeColors.black,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      color: color,
      iconSize: size,
      onPressed: onPressed,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
    );
  }
}