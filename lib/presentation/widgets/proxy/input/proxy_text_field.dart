import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/proxy.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/localization/translations.dart';

class ProxyTextField extends StatelessWidget {
  const ProxyTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.blue,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.black,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.orange,
          ),
        ),
        hintText: Translations.hintText,
        hintStyle: TextStyle(
          color: ThemeColors.black.withOpacity(0.5),
          fontSize: ProxyConstants.getFontSize(
            ProxyFontSize.extraSmall,
          ),
        ),
      ),
    );
  }
}
